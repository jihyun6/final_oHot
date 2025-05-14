package com.ohot.home.media.service;

import java.util.List;
import java.util.Map;

import com.ohot.dto.MediaReplyDTO;
import com.ohot.home.community.vo.CommunityReplyVO;

public interface MediaCommentService {
	
	public int createReply(CommunityReplyVO communityReplyVO);
	
	// 댓글 리스트 조회
	// 나중에 검색 조건 추가해야 될 수도 있음 생각해야함
	public List<MediaReplyDTO> getReplyList(Map<String, Object> params);
	
	public int updateReply(int replyNo, String replyContent);
	
	public int deleteReply(int replyNo);
}
