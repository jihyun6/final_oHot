package com.ohot.home.community.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.community.vo.ArtistBirthVO;
import com.ohot.home.community.vo.ArtistScheduleVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;
import com.ohot.home.community.vo.MyCommuntiyVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;


@Mapper
public interface CommunityMapper {

	public int joinCommunity(CommunityProfileVO communityProfileVO);

	public CommunityProfileVO profileDetail(CommunityProfileVO communityProfileVO);

	public int editProfileNm(CommunityProfileVO communityProfileVO);

	public int setFileProfile(CommunityProfileVO communityProfileVO);

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

	public List<CommunityReplyVO> replyList(int boardNo);

	public int boardLikeCnt(int boardNo);
	
	public int replyLikeCnt(CommunityReplyVO reply);

	public int boardLikeYn(LikeDetailVO likeYN);

	public void boardLikeDelete(LikeDetailVO likeYN);

	public void replyLikeYn(LikeDetailVO likeYn);

	public void replyLikeDelete(LikeDetailVO likeYn);

	public List<LikeDetailVO> replyLikeList(CommunityReplyVO reply);

	public List<LikeDetailVO> boardLikeList(int boardNo);

	public int deleteBoard(int boardNo);

	public int deleteReply(int replyNo);

	public void exEditBoard(CommunityPostVO communityPostVO);

	public CommunityPostVO boardDetail(CommunityPostVO communityPostVO);

	public int editBoard(CommunityPostVO communityPostVO);

	public int followYn(int comProfileNo, int followProfileNo);

	public void followDelete(int comProfileNo, int followProfileNo);

	public List<CommunityPostVO> myPostList(Map<String, Object> map);

	public int getMyPostTotal(Map<String, Object> map);

	public List<CommunityReplyVO> myReplyList(Map<String, Object> map);

	public int getMyReplyTotal(Map<String, Object> map);

	// 아티스트 커뮤니티 가입
	public int artJoinCommunity(CommunityProfileVO communityProfileVO);

	public int deleteArtCommunity(ArtistVO artistVO);

	public List<CommunityReplyVO> artistRecentReplyList(int artGroupNo);

	public String membershipYn(int comProfileNo);

	public List<ArtistScheduleVO> artistSchduleVOList(ArtistScheduleVO artistScheduleVO);

	public int addSchedule(ArtistScheduleVO artistScheduleVO);

	public void deleteMyPost(CommunityProfileVO communityProfileVO);

	public void deleteMyReply(CommunityProfileVO communityProfileVO);

	public void deleteMyFollow(CommunityProfileVO communityProfileVO);

	public void delYMyFollow(CommunityProfileVO communityProfileVO);

	public void deleteMyLike(CommunityProfileVO communityProfileVO);

	public void setSetting(CommunityProfileVO communityProfileVO);

	public List<ArtistBirthVO> getArtBirth(int artGroupNo);

	public List<MyCommuntiyVO> myCommunity(int memNo);

	public int getBaordNo(CommunityPostVO communityPostVO);

	public void fileSnDel(long fileGroupNo, int sn);


}
