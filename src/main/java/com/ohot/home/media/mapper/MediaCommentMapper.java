package com.ohot.home.media.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.dto.MediaReplyDTO;
import com.ohot.home.community.vo.CommunityReplyVO;

@Mapper
public interface MediaCommentMapper {

	public int createReply(CommunityReplyVO communityReplyVO);
	
	public List<MediaReplyDTO> getReplyList(Map<String, Object> params); 
	
	public int updateReply(Map<String, Object> params);
	
	public int deleteReply(int replyNo);
	
}
