package com.ohot.home.inquiry.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.inquiry.vo.InquiryTypeVO;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.BoardTypeVO;
import com.ohot.vo.FileGroupVO;

@Mapper
public interface InquiryPostMapper {

	// 전체 문의글 리스트
	public List<BoardPostVO> getInquiryPostList(Map<String, Object> map);
	
	// 파일
	public FileGroupVO getFileDetail(long fileGroupNo);

	// 토탈 카운트
	public int getTotalCnt(Map<String, Object> map);

	// 게시글 상세
	public BoardPostVO getInquiryDetail(int boardNo);
	
	// 답글
	public BoardPostVO getReplyPost(int boardNo);

	// 기본키 최대값 구하기
	public int getMaxNo();

	// 게시판명 불러오기
	public List<InquiryTypeVO> getInqTypeVO();

	// 문의게시글 작성 시 BoardPost 테이블 insert
	public int insertBoardPost(Map<String, Object> map); 
	
	// 문의게시글 작성 시 InquiryPost 테이블 insert
	public int insertInquiryPost(Map<String, Object> map);

	// 문의게시글 수정 시 BoardPost 테이블 update
	public int editBoardPost(Map<String, Object> map);
	
	// 문의게시글 수정 시 InquiryPost 테이블 update
	public int editInquiryPost(Map<String, Object> map);

	// 게시글 삭제
	public int deletePost(int bbsPostNo);

	// 답글 등록
	public int createReplyPost(Map<String, Object> map);

	// 답글여부 업데이트
	public int ansYnUpdate(int parentNo);

	// 답글 수정
	public void editReply(BoardPostVO boardPostVO);

	// 답글에 비밀번호 설정
	public void addReplyPswd(Map<String, Object> map);

	// 답글 비밀번호 수정
	public void editReplyPswd(Map<String, Object> map);

	// 답글삭제
	public int deleteReplyPost(Map<String, Object> map);

	// 답글 여부 N변경
	public void deleteAnsYn(Map<String, Object> map);

	// 비밀글 비밀번호 초기화
	public int inqPswdReset(Map<String, Object> params);
	
	// 답글 비밀번호 삭제 시 inquiryPost 테이블에서 삭제
	public void replyPswdReset(Map<String, Object> params);

	// 비밀글 여부
	public String isSecret(int boardNo);

}
