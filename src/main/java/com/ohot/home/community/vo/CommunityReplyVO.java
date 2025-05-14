package com.ohot.home.community.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.FileGroupVO;

import lombok.Data;

@Data
public class CommunityReplyVO {
	
	private int replyNo;
	private String replyContent;
	private String replyDelyn;
	private Date replyCreateDt;
	private int boardNo;
	private int artNo;
	private int memNo;
	private int mediaPostNo;
	private int comProfileNo;
	private String repCreateDate;
	private long tkNo;
	//댓글 별 좋아요 합산 (아마 안쓸듯)
	private int replyLikeCnt;
	//닉네임
	private String comNm;
	private String comAuth;
	private String urlCategory;

	//게시글의 댓글을 작성한 작성자의 profile-img
	private String fileSaveLocate;
	
	//프로필 파일넘버
	private int profileFileNo;
	
	private Long fileGroupNo;

	private CommunityProfileVO communityProfileVO;
	
	private List<LikeDetailVO> replyLikeList;
	
	private FileGroupVO fileGroupVO;
	
	//CommunityProfileVO : ArtistGroupVO : 1 : 1
	
	
	private MultipartFile[] uploadFile;
	
	private String memNm;
	
	private int artGroupNo;
	
}
