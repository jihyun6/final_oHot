package com.ohot.home.alarm.vo;

import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;

import lombok.Data;

@Data
public class AlarmVO {

	private CommunityPostVO communityPostVO;
	private CommunityReplyVO communityReplyVO;
	private LikeDetailVO likeDetailVO;
	
}
