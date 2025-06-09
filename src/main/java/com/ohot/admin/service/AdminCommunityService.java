package com.ohot.admin.service;

import java.util.List;
import java.util.Map;

import com.ohot.vo.AdminCommunityPostVO;
import com.ohot.vo.AdminCommunityReplyVO;

public interface AdminCommunityService {

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
 