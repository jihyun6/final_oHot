package com.ohot.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;

import lombok.Data;

@Data
public class AdminCommunityPostVO {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardOnlyMembership;
	private String boardCreateDate;
	private String boardDelyn;
	private Date boardCreateDt;
	private String boardOnlyFan;
	private String urlCategory;
	private int comProfileNo;
	private int memNo;
	private String comAuth;
	//게시물 작성자 닉네임
	private String comNm;
	//게시물 수정 전 기존 파일 정보 불러주기 위한 변수
	//파일 그룹 번호
	private long fileGroupNo;
	private FileGroupVO fileGroupVO;
	private MultipartFile[] uploadFile;
	
	private String boardCreateDt2;
	
	
}
