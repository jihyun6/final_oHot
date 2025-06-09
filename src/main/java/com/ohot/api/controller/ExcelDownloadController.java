package com.ohot.api.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.ohot.admin.service.AdminCommunityService;
import com.ohot.vo.AdminCommunityPostVO;
import com.ohot.vo.AdminCommunityReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ExcelDownloadController {
	
	@Autowired
	AdminCommunityService adminCommunityService;
	
    @GetMapping("/api/excel/postList/download")
    public ResponseEntity<byte[]> downloadPostListExcel(
    		AdminCommunityPostVO adminCommunityPostVO
    		) throws IOException {
    	Workbook workbook = new XSSFWorkbook();
    	Sheet sheet = workbook.createSheet(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")) + "게시글 리스트");

    	// 🔷 스타일 정의
    	// 1. 헤더 스타일
    	CellStyle headerStyle = workbook.createCellStyle();
    	headerStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
    	headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    	headerStyle.setBorderTop(BorderStyle.THIN);
    	headerStyle.setBorderBottom(BorderStyle.THIN);
    	headerStyle.setBorderLeft(BorderStyle.THIN);
    	headerStyle.setBorderRight(BorderStyle.THIN);
    	headerStyle.setAlignment(HorizontalAlignment.CENTER);

    	Font headerFont = workbook.createFont();
    	headerFont.setBold(true);
    	headerFont.setColor(IndexedColors.DARK_GREEN.getIndex());
    	headerStyle.setFont(headerFont);

    	// 2. 일반 데이터 셀 스타일
    	CellStyle bodyStyle = workbook.createCellStyle();
    	bodyStyle.setBorderTop(BorderStyle.THIN);
    	bodyStyle.setBorderBottom(BorderStyle.THIN);
    	bodyStyle.setBorderLeft(BorderStyle.THIN);
    	bodyStyle.setBorderRight(BorderStyle.THIN);
    	bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);

    	// 3. 가운데 정렬 스타일 (번호, 멤버십 등)
    	CellStyle centerStyle = workbook.createCellStyle();
    	centerStyle.cloneStyleFrom(bodyStyle);
    	centerStyle.setAlignment(HorizontalAlignment.CENTER);

    	// 🔸 헤더 작성
    	Row headerRow = sheet.createRow(0);
    	String[] headers = { "순번", "제목", "내용", "멤버십 전용", "팬 전용", "삭제 여부", "작성 일시", "유저 타입", "유저 번호" };

    	for (int i = 0; i < headers.length; i++) {
    	    Cell cell = headerRow.createCell(i);
    	    cell.setCellValue(headers[i]);
    	    cell.setCellStyle(headerStyle);
    	    sheet.autoSizeColumn(i);
    	}

    	// 🔸 데이터 작성
    	List<AdminCommunityPostVO> allPostList = this.adminCommunityService.allPostList();
    	int rowIdx = 1;

    	for (AdminCommunityPostVO post : allPostList) {
    	    if (post.getUrlCategory() != null && !post.getUrlCategory().isEmpty()) {
    	        String userType = post.getUrlCategory().equals("ROLE_MEM") ? "회원" : "아티스트";
    	        post.setUrlCategory(userType);
    	    }

    	    Row row = sheet.createRow(rowIdx++);

    	    CellStyle[] styles = { centerStyle, bodyStyle, bodyStyle, centerStyle, centerStyle, centerStyle, bodyStyle, centerStyle, centerStyle };

    	    String[] values = {
    	        String.valueOf(post.getBoardNo()),
    	        post.getBoardTitle(),
    	        post.getBoardContent(),
    	        post.getBoardOnlyMembership(),
    	        post.getBoardOnlyFan(),
    	        post.getBoardDelyn(),
    	        String.valueOf(post.getBoardCreateDate()),
    	        post.getUrlCategory(),
    	        String.valueOf(post.getMemNo())
    	    };

    	    for (int i = 0; i < values.length; i++) {
    	        Cell cell = row.createCell(i);
    	        cell.setCellValue(values[i]);
    	        cell.setCellStyle(styles[i]);
    	        sheet.autoSizeColumn(i);
    	    }
    	}
    	// 엑셀 파일을 ByteArrayOutputStream에 작성
    	ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
    	workbook.write(outputStream);
    	workbook.close();
    	
    	//엑셀 파일 이름 넣어주는 곳
    	String fileName = "게시글 리스트_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    	String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
    	// HTTP 응답 헤더 설정
    	HttpHeaders header = new HttpHeaders();
    	header.add("Content-Disposition", "attachment; filename=" + outputFileName +".xlsx");
    	header.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    	
    	return new ResponseEntity<>(outputStream.toByteArray(), header, HttpStatus.OK);
    }  
    
    @GetMapping("/api/excel/replyList/download")
    public ResponseEntity<byte[]> downloadReplyListExcel(AdminCommunityReplyVO adminCommunityReplyVO) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")) + "댓글 리스트");

        // 1. 스타일 설정
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setBorderTop(BorderStyle.THIN);
        headerStyle.setBorderBottom(BorderStyle.THIN);
        headerStyle.setBorderLeft(BorderStyle.THIN);
        headerStyle.setBorderRight(BorderStyle.THIN);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setColor(IndexedColors.DARK_GREEN.getIndex());
        headerStyle.setFont(headerFont);

        CellStyle bodyStyle = workbook.createCellStyle();
        bodyStyle.setBorderTop(BorderStyle.THIN);
        bodyStyle.setBorderBottom(BorderStyle.THIN);
        bodyStyle.setBorderLeft(BorderStyle.THIN);
        bodyStyle.setBorderRight(BorderStyle.THIN);
        bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        CellStyle centerStyle = workbook.createCellStyle();
        centerStyle.cloneStyleFrom(bodyStyle);
        centerStyle.setAlignment(HorizontalAlignment.CENTER);

        // 2. 헤더 작성
        Row headerRow = sheet.createRow(0);
        String[] headers = {
            "순번", "내용", "삭제 여부", "작성 일시", "유저 타입",
            "유저 번호", "커뮤니티 게시글 번호", "미디어 게시글 번호", "티켓 번호", "댓글 번호"
        };
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            sheet.autoSizeColumn(i);
        }

        // 3. 데이터 생성
        List<AdminCommunityReplyVO> allReplyList = this.adminCommunityService.allReplyList();
        int rowIdx = 1;

        for (AdminCommunityReplyVO reply : allReplyList) {
            if (reply.getUrlCategory() != null && !reply.getUrlCategory().isEmpty()) {
                String userType = reply.getUrlCategory().equals("ROLE_MEM") ? "회원" : "아티스트";
                reply.setUrlCategory(userType);
            }

            Row row = sheet.createRow(rowIdx++);

            String[] values = {
                String.valueOf(rowIdx-1),
                reply.getReplyContent(),
                reply.getReplyDelyn(),
                String.valueOf(reply.getReplyCreateDate()),
                reply.getUrlCategory(),
                String.valueOf(reply.getMemNo()),
                String.valueOf(reply.getBoardNo()),
                String.valueOf(reply.getMediaPostNo()),
                String.valueOf(reply.getTkNo()),
                String.valueOf(reply.getReplyNo())
            };

            // 셀별 스타일 매핑
            CellStyle[] styles = {
                centerStyle, bodyStyle, centerStyle, bodyStyle, centerStyle,
                centerStyle, centerStyle, centerStyle, centerStyle, centerStyle
            };

            for (int i = 0; i < values.length; i++) {
                Cell cell = row.createCell(i);
                cell.setCellValue(values[i]);
                cell.setCellStyle(styles[i]);
                sheet.autoSizeColumn(i);
            }
        }

        // 4. 파일로 변환
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        String fileName = "댓글 리스트_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");

        HttpHeaders headersHttp = new HttpHeaders();
        headersHttp.add("Content-Disposition", "attachment; filename=" + outputFileName + ".xlsx");
        headersHttp.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        return new ResponseEntity<>(outputStream.toByteArray(), headersHttp, HttpStatus.OK);
    }
    
    
    
	/*
	 * 위에건 디자인 된 것, 아래 코드로 작성하고 디자인은 본인이 하시길
	 * 
	 * @GetMapping("/api/excel/replyList/download") public ResponseEntity<byte[]>
	 * downloadReplyListExcel( AdminCommunityReplyVO adminCommunityReplyVO ) throws
	 * IOException { Workbook workbook = new XSSFWorkbook();
	 * 
	 * Date today = new Date(); //엑셀의 시트 이름 넣어주는 곳 Sheet sheet =
	 * workbook.createSheet(LocalDateTime.now().format(DateTimeFormatter.ofPattern(
	 * "yyyyMMdd"))+"댓글 리스트");
	 * 
	 * // 엑셀 헤더 생성 Row dataRow = sheet.createRow(0);
	 * dataRow.createCell(0).setCellValue("순번");
	 * dataRow.createCell(1).setCellValue("내용");
	 * dataRow.createCell(2).setCellValue("삭제 여부");
	 * dataRow.createCell(3).setCellValue("작성 일시");
	 * dataRow.createCell(4).setCellValue("유저 타입");
	 * dataRow.createCell(5).setCellValue("유저 번호");
	 * dataRow.createCell(6).setCellValue("커뮤니티 게시글 번호");
	 * dataRow.createCell(7).setCellValue("미디어 게시글 번호");
	 * dataRow.createCell(8).setCellValue("티켓 번호");
	 * dataRow.createCell(9).setCellValue("댓글 번호");
	 * 
	 * sheet.autoSizeColumn(0);
	 * 
	 * log.info("dataRow::::::"+dataRow);
	 * 
	 * // 엑셀 데이터 생성 List<AdminCommunityReplyVO> allReplyList =
	 * this.adminCommunityService.allReplyList();
	 * 
	 * int index =1 ;
	 * 
	 * for (AdminCommunityReplyVO adminCommunityReply : allReplyList) { dataRow =
	 * sheet.createRow(index); if(adminCommunityReply.getUrlCategory()!=null &&
	 * adminCommunityReply.getUrlCategory() != "") { String userType=
	 * adminCommunityReply.getUrlCategory().equals("ROLE_MEM") ? "회원" : "아티스트";
	 * adminCommunityReply.setUrlCategory(userType); }
	 * 
	 * dataRow.createCell(0).setCellValue(adminCommunityReply.getBoardNo());
	 * dataRow.createCell(1).setCellValue(adminCommunityReply.getReplyContent());
	 * dataRow.createCell(2).setCellValue(adminCommunityReply.getReplyDelyn());
	 * dataRow.createCell(3).setCellValue(adminCommunityReply.getReplyCreateDate());
	 * dataRow.createCell(4).setCellValue(adminCommunityReply.getUrlCategory());
	 * dataRow.createCell(5).setCellValue(adminCommunityReply.getMemNo());
	 * dataRow.createCell(6).setCellValue(adminCommunityReply.getBoardNo());
	 * dataRow.createCell(7).setCellValue(adminCommunityReply.getMediaPostNo());
	 * dataRow.createCell(8).setCellValue(adminCommunityReply.getTkNo());
	 * dataRow.createCell(9).setCellValue(adminCommunityReply.getReplyNo());
	 * 
	 * sheet.autoSizeColumn(index); index++; }
	 * 
	 * 
	 * 
	 * // 엑셀 파일을 ByteArrayOutputStream에 작성 ByteArrayOutputStream outputStream = new
	 * ByteArrayOutputStream(); workbook.write(outputStream); workbook.close();
	 * 
	 * //엑셀 파일 이름 넣어주는 곳 String fileName = "댓글 리스트_" +
	 * LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")); String
	 * outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1"); // HTTP
	 * 응답 헤더 설정 HttpHeaders headers = new HttpHeaders();
	 * headers.add("Content-Disposition", "attachment; filename=" + outputFileName
	 * +".xlsx"); headers.add("Content-Type",
	 * "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	 * 
	 * return new ResponseEntity<>(outputStream.toByteArray(), headers,
	 * HttpStatus.OK); }
	 */
}
