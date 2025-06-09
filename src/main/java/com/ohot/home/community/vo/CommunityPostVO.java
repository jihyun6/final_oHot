package com.ohot.home.community.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.vo.FileGroupVO;

import lombok.Data;

@Data
public class CommunityPostVO {
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
	private Long fileGroupNo;
	
	//아트 그룹 넘버(아티스트 게시판)
	private int artGroupNo;
	
	//BOOK_INFO : FILE_GROUP : 1: 1
	private FileGroupVO fileGroupVO;
	private FileGroupVO fileGroupVO2;//프로필사진용
	
	private CommunityProfileVO communityProfileVO;
	private MultipartFile[] uploadFile;
	
	//게시물 당 댓글 리스트
	private List<CommunityReplyVO> replyList;
	
	//게시물 별 좋아요 합산
	private int boardLikeCnt;
	
	private List<LikeDetailVO> boardLikeList;
	
	private int notiNo;

}
