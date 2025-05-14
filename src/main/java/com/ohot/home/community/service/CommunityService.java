package com.ohot.home.community.service;

import java.util.List;
import java.util.Map;

import com.ohot.home.community.vo.ArtistBirthVO;
import com.ohot.home.community.vo.ArtistScheduleVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;
import com.ohot.home.community.vo.MyCommuntiyVO;
import com.ohot.vo.ArtistGroupVO;



public interface CommunityService {

	public int joinCommunity(CommunityProfileVO communityProfileVO);

	public CommunityProfileVO profileDetail(CommunityProfileVO communityProfileVO);

	public int editProfile(CommunityProfileVO communityProfileVO);
	
	public void deleteProfile(CommunityProfileVO communityProfileVO);

	public List<CommunityPostVO> fanBoardList(Map<String, Object> map);


	public int getTotal(Map<String, Object> map);

	public int followingCnt(CommunityProfileVO communityProfileVO);

	public int followerCnt(CommunityProfileVO communityProfileVO);

	public List<CommunityProfileVO> followingList(CommunityProfileVO communityProfileVO);

	public int getTotalArtists(Map<String, Object> map);

	public List<CommunityPostVO> artistBoardList(Map<String, Object> map);

	public int addReply(CommunityReplyVO communityReplyVO);

	public int addBoard(CommunityPostVO communityPostVO);

	public int boardLikeYn(LikeDetailVO likeYN);

	public int replyLikeYn(LikeDetailVO likeYn);

	public int deleteBoard(int boardNo);

	public int deleteReply(int replyNo);

	public CommunityPostVO exEditBoard(CommunityPostVO communityPostVO);

	public int editBoard(CommunityPostVO communityPostVO);

	public int followYn(int comProfileNo, int followProfileNo);

	public List<CommunityPostVO> myPostList(Map<String, Object> map);

	public int getMyPostTotal(Map<String, Object> map);

	public List<CommunityReplyVO> myReplyList(Map<String, Object> map);

	public int getMyReplyTotal(Map<String, Object> map);

	public List<CommunityReplyVO> artistRecentReplyList(int artGroupNo);

	public String membershipYn(int comProfileNo);

	public List<ArtistScheduleVO> artistSchduleVOList(ArtistScheduleVO artistScheduleVO);

	public int addSchedule(ArtistScheduleVO artistScheduleVO);

	public List<ArtistBirthVO> getArtBirth(int artGroupNo);

	public List<MyCommuntiyVO> myCommunity(int memNo);

	public void fileSnDel(long fileGroupNo, int sn);





}
