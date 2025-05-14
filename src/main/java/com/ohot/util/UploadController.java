package com.ohot.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ohot.config.BeanController;
import com.ohot.mapper.FileGroupMapper;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
public class UploadController {
	
	// 업로드/다운로드 파일 경로
	@Autowired
	BeanController beanController;
	
	// 첨부 파일 쿼리 실행
	@Autowired
	FileGroupMapper fileGroupMapper;

	// ***4. [다중 파일 업로드]FILE_GROUP 테이블 및 FILE_DETAIL 테이블 사용
	// return : 20250224001(FILE_GROUP테이블의 FILE_GROUP_NO 컬럼의 값)
	public long multiImageUpload(MultipartFile[] multipartFiles) {
		long fileGroupNo = 0L;

		// 시작 ///
		String pictureUrl = "";
		int seq = 1;
		int result = 0;

		/*
		 * multipartFiles=[ 6c0e9dde , 33f91e83 ]
		 */
		// 1. FILE_GROUP 테이블에 insert(1회 실행)
		FileGroupVO fileGroupVO = new FileGroupVO();
		// 실행전 fileGroupVO{fileGroupNo=0,fileRegdate=null)
		// 실행후 fileGroupVO{fileGroupNo=20250226001,fileRegdate=null) 왜냐하면 selectKey에
		// 의해서..
		result += this.fileGroupMapper.insertFileGroup(fileGroupVO);
		// selectKey 태그에 의해 fileGropuNo가 채워짐
		fileGroupNo = fileGroupVO.getFileGroupNo();

		for (MultipartFile multipartFile : multipartFiles) {
			log.info("multipartFiles : " + multipartFile);
			log.info("이미지 파일 명 : " + multipartFile.getOriginalFilename());
			log.info("이미지 크기 : " + multipartFile.getSize());
			// MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
			// .jpg / .jpeg의 MIME 타입 : image/jpeg
			log.info("MIME 타입 : " + multipartFile.getContentType());
			// 서버측 업로드 대상 폴더
			log.info("uploadFolder : " + this.beanController.getUploadFolder());

			// 연월일 폴더 생성 설계
			// D:\\springboot\\upload \\ 2025\\05\\21
			File uploadPath = new File(this.beanController.getUploadFolder(), getFolder());

			// 연월일 폴더 생성 실행
			if (uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}

			// 파일명
			String uploadFileName = multipartFile.getOriginalFilename();

			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 시작----------------
			// java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID();
			// 원래의 파일 이름과 구분하기 위해 _를 붙임(sdafjasdlfksadj_개똥이.jpg)
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 끝----------------

			log.info("saveFile : " + uploadPath + "\\" + uploadFileName);
			// 설계
			// , : \\ (파일 세퍼레이터)
			// uploadFolder : D:\\springboot\\upload\\2025\\05\\21 + \\ + asdfljk_개똥이.jpg
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				// 2.파일 복사 실행(설계대로)
				// 스프링파일객체.transferTo(설계)
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			// 웹경로
			// getFolder().replace("\\", "/") : 2025/02/21
			// /2025/02/21/sdaflkfdsaj_개똥이.jpg
			pictureUrl = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;

			// 2. FILE_DETAIL 테이블에 insert(첨부파일의 개수만큼 실행)
			FileDetailVO fileDetailVO = new FileDetailVO();
			/*
			 * //실행전 fileGroupVO{fileGroupNo=0,fileRegdate=null) //실행후
			 * fileGroupVO{fileGroupNo=20250226001,fileRegdate=null) 왜냐하면 selectKey에 의해서..
			 * result += this.itemMapper.insertFileGroup(fileGroupVO);
			 */
			fileDetailVO.setFileGroupNo(fileGroupVO.getFileGroupNo());
			fileDetailVO.setFileSn(seq++);
			fileDetailVO.setFileOriginalName(multipartFile.getOriginalFilename());
			fileDetailVO.setFileSaveName(uploadFileName);// UUID + "_" + 파일명
			fileDetailVO.setFileSaveLocate(pictureUrl);// /2025/02/21/sdaflkfdsaj_개똥이.jpg
			fileDetailVO.setFileSize(multipartFile.getSize());
			fileDetailVO.setFileExt(multipartFile.getOriginalFilename()
					.substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1));// jpg(확장자)
			fileDetailVO.setFileMime(multipartFile.getContentType());// MIME타입
			fileDetailVO.setFileFancysize(null);// bytes->MB
			fileDetailVO.setFileSaveDate(null);
			fileDetailVO.setFileDowncount(0);

			// FILE_DETAIL 테이블에 insert
			result += this.fileGroupMapper.insertFileDetail(fileDetailVO);

		} // end for
			// 끝 ///

		return fileGroupNo;
	}

	// ***4-2. [다중 파일 업로드]FILE_DETAIL 테이블 사용
	// return : insert된 건수
	public int multiImageUploadTOFileDetail(long fileGroupNo, MultipartFile[] multipartFiles) {

		// 시작 ///
		String pictureUrl = "";
		int seq = 1;
		int result = 0;

		/*
		 * multipartFiles=[ 6c0e9dde , 33f91e83 ]
		 */

		for (MultipartFile multipartFile : multipartFiles) {
			log.info("이미지 파일 명 : " + multipartFile.getOriginalFilename());
			log.info("이미지 크기 : " + multipartFile.getSize());
			// MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
			// .jpg / .jpeg의 MIME 타입 : image/jpeg
			log.info("MIME 타입 : " + multipartFile.getContentType());
			// 서버측 업로드 대상 폴더
			log.info("uploadFolder : " + this.beanController.getUploadFolder());

			// 연월일 폴더 생성 설계
			// D:\\springboot\\upload \\ 2025\\05\\21
			File uploadPath = new File(this.beanController.getUploadFolder(), getFolder());

			// 연월일 폴더 생성 실행
			if (uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}

			// 파일명
			String uploadFileName = multipartFile.getOriginalFilename();

			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 시작----------------
			// java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID();
			// 원래의 파일 이름과 구분하기 위해 _를 붙임(sdafjasdlfksadj_개똥이.jpg)
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 끝----------------

			log.info("saveFile : " + uploadPath + "\\" + uploadFileName);
			// 설계
			// , : \\ (파일 세퍼레이터)
			// uploadFolder : D:\\springboot\\upload\\2025\\05\\21 + \\ + asdfljk_개똥이.jpg
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				// 2.파일 복사 실행(설계대로)
				// 스프링파일객체.transferTo(설계)
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			// 웹경로
			// getFolder().replace("\\", "/") : 2025/02/21
			// /2025/02/21/sdaflkfdsaj_개똥이.jpg
			pictureUrl = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
			// 2. FILE_DETAIL 테이블에 insert(첨부파일의 개수만큼 실행)
			FileDetailVO fileDetailVO = new FileDetailVO();
			/*
			 * //실행전 fileGroupVO{fileGroupNo=0,fileRegdate=null) //실행후
			 * fileGroupVO{fileGroupNo=20250226001,fileRegdate=null) 왜냐하면 selectKey에 의해서..
			 * result += this.itemMapper.insertFileGroup(fileGroupVO);
			 */
			fileDetailVO.setFileGroupNo(fileGroupNo);
			fileDetailVO.setFileSn(seq++);
			fileDetailVO.setFileOriginalName(multipartFile.getOriginalFilename());
			fileDetailVO.setFileSaveName(uploadFileName);// UUID + "_" + 파일명
			fileDetailVO.setFileSaveLocate(pictureUrl);// /2025/02/21/sdaflkfdsaj_개똥이.jpg
			fileDetailVO.setFileSize(multipartFile.getSize());
			fileDetailVO.setFileExt(multipartFile.getOriginalFilename()
					.substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1));// jpg(확장자)
			fileDetailVO.setFileMime(multipartFile.getContentType());// MIME타입
			fileDetailVO.setFileFancysize(null);// bytes->MB
			fileDetailVO.setFileSaveDate(null);
			fileDetailVO.setFileDowncount(0);

			// FILE_DETAIL 테이블에 insert
			result += this.fileGroupMapper.insertFileDetail(fileDetailVO);

		} // end for
			// 끝 ///

		return result;
	}

	// 5. 파일 다운로드

	// 연 월 일 폴더 생성
	public String getFolder() {
		// 2025-02-21 형식(format) 지정
		// 간단 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		String str = sdf.format(date);
		// str : 2025-02-21
		log.info("str : " + str);
		// str : 2025-02-21 -> 2025\\02\\21
		log.info("str.replace : " + str.replace("-", "\\"));
		log.info("str.replace : " + str.replace("-", File.separator));

		return str.replace("-", File.separator);
	}

	// fancySize 리턴("1059000")
	public String makeFancySize(String bytes) {
		log.info("bytes : " + bytes);
		String retFormat = "0";
		// 숫자형문자->실수형으로 형변환(1059000)
		Double size = Double.parseDouble(bytes);// 1059000.0

		String[] s = { "bytes", "KB", "MB", "GB", "TB", "PB" };

		if (bytes != "0") {
			// bytes->KB
			// Math.log(1059000) : 13.8728
			// 13.8728 / 1024 :
			System.out.println("Math.log(size) : " + Math.log(size)); // 13.872835624583544
			System.out.println("Math.log(1024) : " + Math.log(1024)); // 6.931471805599453
			int idx = (int) Math.floor(Math.log(size) / Math.log(1024));// 2.0
			DecimalFormat df = new DecimalFormat("#,###.##");
			System.out.println("Math.floor(idx) : " + Math.floor(idx));// 2.0
			double ret = ((size / Math.pow(1024, Math.floor(idx))));
			System.out.println("ret : " + ret);// 1.0099411010742188
			retFormat = df.format(ret) + " " + s[idx];// 1.01 MB
		} else {
			retFormat += " " + s[0];
		}

		return retFormat;
	}

	// 파일 다운로드
	// localhost/download?fileName=2022/07/25/cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg
	@GetMapping("/download")
	public ResponseEntity<Resource> download(@RequestParam String fileName) {
		log.info("download->fileName : " + fileName);

		// resource : 다운로드 받을 파일(자원)
		// this.beanController.getUploadFolder() : D:\\springboot\\upload
		// , : File seperator 즉, 역슬러시 두개
		Resource resource = new FileSystemResource(this.beanController.getUploadFolder() + "\\" + fileName);
		// 메타데이터(데이터를 위한 데이터-눈에 보이지 않는 정보)
		// cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg
		String resourceName = resource.getFilename();
		// 다운로드는 헤더를 통해서 진행됨
		// header : 인코딩 정보, 파일명 정보 포함해보자
		HttpHeaders headers = new HttpHeaders();

		// 헤더명 값
		try {
			headers.add("Content-Disposition",
					"attachment;filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			log.info(e.getMessage());
		}
		// 응답 body -> 파일 데이터
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	// CKEditor 이미지 업로드
	// {ckfinder:{uploadUrl:"/image/upload"}
	// HttpServletRequest request : 파일업로드가 없을 때
	// MultipartHttpServletRequest : 파일업로드가 있을 때
	@ResponseBody
	@PostMapping("/image/upload")
	public Map<String, Object> image(MultipartHttpServletRequest request) throws Exception {
		// ckeditor는 이미지 업로드 후 이미지 표시하기 위해 uploaded 와 url을 json 형식으로 받아야 함
		// modelandview를 사용하여 json 형식으로 보내기위해 모델앤뷰 생성자 매개변수로 jsonView 라고 써줌
		// jsonView 라고 쓴다고 무조건 json 형식으로 가는건 아니고 @Configuration 어노테이션을 단
		// WebConfig 파일에 MappingJackson2JsonView 객체를 리턴하는 jsonView 매서드를 만들어서 bean으로
		// 등록해야함
		ModelAndView mav = new ModelAndView("jsonView");

		// ckeditor 에서 파일을 보낼 때 upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서
		// request{upload=파일객체}
		// uploadFile에 저장함
		MultipartFile uploadFile = request.getFile("upload");
		log.info("image->uploadFile : " + uploadFile);

		// 파일의 오리지널 네임
		String originalFileName = uploadFile.getOriginalFilename();
		log.info("image->originalFileName : " + originalFileName);

		// 파일의 확장자(개똥이.jpg)
		String ext = originalFileName.substring(originalFileName.indexOf("."));
		log.info("image->ext : " + ext);

		// 서버에 저장될 때 중복된 파일 이름인 경우를 방지하기 위해 UUID에 확장자를 붙여 새로운 파일 이름을 생성
		// fkjalfjdalk.jpg
		String newFileName = UUID.randomUUID() + ext;

		// 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
//	      String realPath = request.getServletContext().getRealPath("/");
		String url = request.getRequestURL().toString();
		log.info("image->url : " + url);
		
		//http://loclahost
        //http://loclahost:8090
		url.substring(0, url.indexOf("/", 7));

		// 현재경로/upload/파일명이 저장 경로 window용 seperator
		// D:\\springboot\\upload \\ fkjalfjdalk.jpg
		String savePath = this.beanController.getUploadFolder() + "\\" + newFileName;

		// 브라우저에서 이미지 불러올 때 절대 경로로 불러오면 보안의 위험 있어 상대경로를 쓰거나 이미지 불러오는 jsp 또는 클래스 파일을 만들어
		// 가져오는 식으로 우회해야 함
		// 때문에 savePath와 별개로 상대 경로인 uploadPath 만들어줌
		// FileConfig -> addResourceHandlers에 설정한대로
		String uploadPath = "/upload/" + newFileName;
		log.info("iamge->uploadPath : " + uploadPath);

		// 저장 경로로 파일 객체 생성(설계)
		File file = new File(savePath);

		// 파일 업로드
		uploadFile.transferTo(file);

		// 파일 업로드 완료 후 base64이미지 처리
		String base64Img = imageToBase64(savePath);

		// uploaded, url 값을 modelandview를 통해 보냄
//	      mav.addObject("uploaded", true); // 업로드 완료
//	      mav.addObject("url", uploadPath); // 업로드 파일의 경로

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uploaded", true);
		// DB에 이미지 자체가 저장되므로 DB 용량을 많이 차지하게 됨
		//map.put("url", "data:image/jpeg;base64,"+base64Img);
		//map.put("url", "data:"+uploadFile.getContentType()+";base64,"+base64Img);
		
		// url + uploadPath : http://localhost:8080 + /upload/adfkjla.jpg
		// DB에 경로가 저장되므로 DB가 가벼워짐(추천!)
		map.put("url", url + uploadPath);
		
		// 1) <img src="/resources/upload/개동이.jpg">
//	      map.put("url", url + uploadPath);
		// 2) <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABoHC...생략...">
		log.info("image->map : " + map);
		
		// map : {uploaded=true,
		// url=/resources/upload/b8baefc3-34c0-44c8-af3b-4a9464a61e7c.jpg}

		return map;
	}

	/**
	 * 이미지를 Base64로 변환하기 서버에 저장되어있는 이미지를 웹화면에 뿌려주어야할 때 base64로 변환하여 표현하는 방법을 사용한다
	 * <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABoHC...생략..."> 이 값을
	 * 만들기 위해 필요한 로직을 알아보자 가. Parameter : 1. 파일의 경로 filePath, 2. 파일명 fileName 나.
	 * Return : 1. base64 문자열 base64Img
	 * 
	 * @throws Exception
	 */
	public String imageToBase64(String savePath) throws Exception {
		String base64Img = "";

		log.info("imageToBase64->savePath : " + savePath);

		File f = new File(savePath);
		if (f.exists() && f.isFile() && f.length() > 0) {
            byte[] bt = new byte[(int) f.length()];
            try (FileInputStream fis = new FileInputStream(f)) {
                fis.read(bt);
                /*
                자바 21 이상 버젼에서는 기본 api로 해결 가능해서 지금 문법에서 오류난다고합니다! 
                외부라이브러리 base64로 안끌어와도된다고합니다 
                 */
                // Using java.util.Base64
                base64Img = Base64.getEncoder().encodeToString(bt);
                log.info("Base64 Encoded Image: " + base64Img);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

		return base64Img;
	}

	
	
}// end class
