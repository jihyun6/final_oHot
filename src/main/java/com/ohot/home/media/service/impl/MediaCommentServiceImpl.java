package com.ohot.home.media.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.dto.MediaReplyDTO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.media.mapper.MediaCommentMapper;
import com.ohot.home.media.service.MediaCommentService;

@Service
public class MediaCommentServiceImpl implements MediaCommentService{
	@Autowired
	MediaCommentMapper mediaCommentMapper;
	
	@Override
	public int createReply(CommunityReplyVO communityReplyVO) {
		return mediaCommentMapper.createReply(communityReplyVO);
	}

	@Override
	public List<MediaReplyDTO> getReplyList(Map<String, Object> params) {
		return mediaCommentMapper.getReplyList(params);
	}

	@Override
	public int updateReply(int replyNo, String replyContent) {
		
		// 여기서 타입이 확정된 상태로 넘어온 파라미터들을 맵으로 넘겨주면 또 타입이 변환되므로 주의
		Map<String, Object> params = new HashMap<>();
		params.put("replyNo", replyNo);
		params.put("replyContent", replyContent);
		
		return mediaCommentMapper.updateReply(params);
	}

	@Override
	public int deleteReply(int replyNo) {
		
		return mediaCommentMapper.deleteReply(replyNo);
	}

}
