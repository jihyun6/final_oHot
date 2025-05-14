package com.ohot.home.inquiry.service;

import java.util.List;
import java.util.Map;

import com.ohot.home.inquiry.vo.InquiryTypeVO;
import com.ohot.vo.BoardPostVO;

public interface InquiryPostService {

	// 전체 문의글 리스트
	public List<BoardPostVO> getInquiryPostList(Map<String, Object> map);

	// 카운트
	public int getTotalCnt(Map<String, Object> map);

	// 게시글 상세
	public BoardPostVO getInquiryDetail(int boardNo);

	// 기본키 최대값 구하기
	public int getMaxNo();

	// 게시판명 불러오기
	public List<InquiryTypeVO> getInqTypeVO();

	// 문의게시글 작성 시 BoardPost 테이블 insert
	public int insertBoardPost(Map<String, Object> map);

	// 문의게시글 수정 시 BoardPost 테이블 update
	public int editBoardPost(Map<String, Object> map);

	// 게시글 삭제
	public int deletePost(int bbsPostNo);

	// 답글 등록
	public void createReplyPost(Map<String, Object> map);

	// 답글 수정
	public void editReply(BoardPostVO boardPostVO);

	// 답글 삭제
	public void deleteReplyPost(Map<String, Object> map);

	// 비밀글 비밀번호 초기화
	public void inqPswdReset(Map<String, Object> params);

}
