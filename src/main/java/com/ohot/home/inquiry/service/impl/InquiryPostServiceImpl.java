package com.ohot.home.inquiry.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ohot.home.inquiry.mapper.InquiryPostMapper;
import com.ohot.home.inquiry.service.InquiryPostService;
import com.ohot.home.inquiry.vo.InquiryTypeVO;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.FileGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class InquiryPostServiceImpl implements InquiryPostService{

	@Autowired
	InquiryPostMapper inquiryPostMapper;
	
	// 전체 문의글 리스트
	@Transactional
	@Override
	public List<BoardPostVO> getInquiryPostList(Map<String, Object> map) {
		
		List<BoardPostVO> boardPostVOList = this.inquiryPostMapper.getInquiryPostList(map);
		
		List<BoardPostVO> inquiryPostVOList = new ArrayList<>();
		
		if(!boardPostVOList.isEmpty()) {
			for(BoardPostVO boardPostVO : boardPostVOList) {
				
				if(boardPostVO.getInquiryPostVO().getInqPswd()!=null) {
					boardPostVO.getInquiryPostVO().setPswdYn("Y");
				}else {
					boardPostVO.getInquiryPostVO().setPswdYn("N");
				}
				
				FileGroupVO fileGroupVo = this.inquiryPostMapper.getFileDetail(boardPostVO.getFileGroupNo());
				boardPostVO.setFileGroupVO(fileGroupVo);
				inquiryPostVOList.add(boardPostVO);
			}
		}
		
		return inquiryPostVOList;
	}

	// 토탈 카운트
	@Override
	public int getTotalCnt(Map<String, Object> map) {
		return this.inquiryPostMapper.getTotalCnt(map);
	}

	// 게시글 상세 (답글이 있으면 추가해 줌)
	@Transactional
	@Override
	public BoardPostVO getInquiryDetail(int boardNo) {
		BoardPostVO inquiryPost = this.inquiryPostMapper.getInquiryDetail(boardNo);
		BoardPostVO replyPost = this.inquiryPostMapper.getReplyPost(boardNo);
		
		if(replyPost != null) {
			inquiryPost.setReplyPostVO(replyPost);
		}
		
		return inquiryPost;
	}

	// 기본키 최대값 구하기
	@Override
	public int getMaxNo() {
		return this.inquiryPostMapper.getMaxNo();
	}

	// 게시판 명 불러오기
	@Override
	public List<InquiryTypeVO> getInqTypeVO() {
		return this.inquiryPostMapper.getInqTypeVO();
	}

	// 문의게시글 작성 시 BoardPost 테이블 insert
	@Transactional
	@Override
	public int insertBoardPost(Map<String, Object> map) {
		int result = this.inquiryPostMapper.insertBoardPost(map);
		if(result == 1) {
			// 문의게시글 작성 시 InquiryPost 테이블 insert
			result += this.inquiryPostMapper.insertInquiryPost(map);
		}
		return result;
	}

	// 문의게시글 수정 시 BoardPost테이블 update
	@Transactional
	@Override
	public int editBoardPost(Map<String, Object> map) {
		
		// 비밀번호가 변경된 경우
		// 비밀번호가 생성된 경우
		// 비밀번호가 삭제된 경우
			int result = this.inquiryPostMapper.editBoardPost(map);
			if(result > 0) {
				result += this.inquiryPostMapper.editInquiryPost(map);
				if(!map.get("replyPostNo").equals(null) && !map.get("replyPostNo").equals("")) { // 답글이 있는 경우 답글의 비밀번호도 변경해야 됨
					map.put("bbsPostNo", (String)map.get("replyPostNo"));
					if(map.get("pswdStatus").equals("pswdAdd")) { // 1. 비밀번호 생성인 경우
						this.inquiryPostMapper.addReplyPswd(map);
					}else { // 2. 비밀번호 수정인 경우
						if(!map.get("inqPswd").equals(null) && !map.get("inqPswd").equals("")) { // 2-1. 값 변경
							this.inquiryPostMapper.editReplyPswd(map);
						}else {	// 2-2. 값 삭제
							this.inquiryPostMapper.replyPswdReset(map);
						}
					}
				}
			}
		return result;
	}

	// 게시글 삭제
	@Override
	public int deletePost(int bbsPostNo) {
		return this.inquiryPostMapper.deletePost(bbsPostNo);
	}

	// 답글 등록
	@Transactional
	@Override
	public void createReplyPost(Map<String, Object> map) {
		int result = this.inquiryPostMapper.createReplyPost(map);
		if(result > 0) {
			int parentNo = (int)map.get("parentPostNo");
			result = this.inquiryPostMapper.ansYnUpdate(parentNo);
			
			if(!map.get("inqPswd").equals(null) && !map.get("inqPswd").equals("")) {
				log.info("map.get(\"inqPswd\") : " + map.get("inqPswd"));
				log.info("비밀번호가 있나요");
				this.inquiryPostMapper.addReplyPswd(map);
			}
		}
	}

	// 답글 수정
	@Override
	public void editReply(BoardPostVO boardPostVO) {
		this.inquiryPostMapper.editReply(boardPostVO);
	}

	// 답글 삭제
	@Transactional
	@Override
	public void deleteReplyPost(Map<String, Object> map) {
		int result = this.inquiryPostMapper.deleteReplyPost(map);
		if(result > 0 ) {
			this.inquiryPostMapper.deleteAnsYn(map);
		}
	}

	// 비밀글 비밀번호 초기화
	@Transactional
	@Override
	public void inqPswdReset(Map<String, Object> params) {
		int result = this.inquiryPostMapper.inqPswdReset(params);
		String parentPostNo = (String)params.get("parentPostNo");
		if(!parentPostNo.equals(null) && !parentPostNo.equals("0")) {
			if(result > 0) {
				this.inquiryPostMapper.replyPswdReset(params);
			}
		}
	}

}
