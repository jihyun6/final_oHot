package com.ohot.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.AdminCommunityPostVO;
import com.ohot.vo.AdminCommunityReplyVO;

@Mapper
public interface AdminCommunityMapper {

	public int getTotalPost(Map<String, Object> data);

	public List<AdminCommunityPostVO> adminPostList(Map<String, Object> data);

	public List<AdminCommunityReplyVO> adminReplyList(Map<String, Object> data);

	public int getTotalReply(Map<String, Object> data);

	public AdminCommunityPostVO postDetail(int boardNo);

	public void postDelete(int boardNo);

	public void postUnDelete(int boardNo);

	public void replyDelete(int replyNo);

	public void replyUnDelete(int replyNo);

	public List<AdminCommunityPostVO> allPostList();

	public List<AdminCommunityReplyVO> allReplyList();

}
