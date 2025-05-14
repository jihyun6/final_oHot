package com.ohot.admin.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.admin.mapper.AdminCommunityMapper;
import com.ohot.admin.service.AdminCommunityService;
import com.ohot.vo.AdminCommunityPostVO;
import com.ohot.vo.AdminCommunityReplyVO;

@Service
public class AdminCommunityServiceImpl implements AdminCommunityService {
	
	@Autowired
	AdminCommunityMapper adminCommunityMapper;

	@Override
	public int getTotalPost(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return this.adminCommunityMapper.getTotalPost(data);
	}

	@Override
	public List<AdminCommunityPostVO> adminPostList(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return this.adminCommunityMapper.adminPostList(data);
	}

	@Override
	public List<AdminCommunityReplyVO> adminReplyList(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return this.adminCommunityMapper.adminReplyList(data);
	}

	@Override
	public int getTotalReply(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return this.adminCommunityMapper.getTotalReply(data);
	}

	@Override
	public AdminCommunityPostVO postDetail(int boardNo) {
		// TODO Auto-generated method stub
		return this.adminCommunityMapper.postDetail(boardNo);
	}

	@Override
	public void postDelete(int boardNo) {
		
		this.adminCommunityMapper.postDelete(boardNo);
	}

	@Override
	public void postUnDelete(int boardNo) {
		this.adminCommunityMapper.postUnDelete(boardNo);
		
	}

	@Override
	public void replyDelete(int replyNo) {
		this.adminCommunityMapper.replyDelete(replyNo);
	}

	@Override
	public void replyUnDelete(int replyNo) {
		
		this.adminCommunityMapper.replyUnDelete(replyNo);
	}
	public List<AdminCommunityPostVO> allPostList(){
		
		return this.adminCommunityMapper.allPostList();
	}

	@Override
	public List<AdminCommunityReplyVO> allReplyList() {
		// TODO Auto-generated method stub
		return this.adminCommunityMapper.allReplyList();
	}


}
