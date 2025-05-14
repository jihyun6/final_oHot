package com.ohot.home.community.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.home.alarm.mapper.AlarmMapper;
import com.ohot.home.community.mapper.CommunityMapper;
import com.ohot.home.community.service.CommunityService;
import com.ohot.home.community.vo.ArtistBirthVO;
import com.ohot.home.community.vo.ArtistScheduleVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;
import com.ohot.home.community.vo.MyCommuntiyVO;
import com.ohot.mapper.FileGroupMapper;
import com.ohot.util.UploadController;
import com.ohot.vo.FileGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	CommunityMapper communityMapper;
	@Autowired
	UploadController uploadController;
	@Autowired
	FileGroupMapper fileGroupMapper;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	@Override
	public int joinCommunity(CommunityProfileVO communityProfileVO) {
		

		
		MultipartFile[] uploadFile = communityProfileVO.getUploadFile();
		long fileGroupNo=0L;
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//FILE_GROUP 및 FILE_DETAIL 테이블에 INSERT
			//FILE_GROUP.FILE_GROUP_NO 값을 리턴
				
				fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
				log.info("joinCommunity->fileGroupNo : "+fileGroupNo);
				communityProfileVO.setFileGroupNo(fileGroupNo);
				//세팅된 파일 그룹 넘버로 파일프로필 테이블에 인서트 필요
				

		}

			//파일 그룹 번호 세팅
			//프로필파일에도 커뮤니티프로필넘버와 그룹파일넘버 인서트해야함
		if(communityProfileVO.getComFileGroupNo()==null && communityProfileVO.getFileGroupNo()==null) {
			communityProfileVO.setComFileGroupNo(0L);
			communityProfileVO.setFileGroupNo(0L);
		}
		communityMapper.joinCommunity(communityProfileVO);
		communityProfileVO = this.communityMapper.profileDetail(communityProfileVO);
		log.info("fileGroupNo ====="+communityProfileVO);
		
		//설정 디폴트값 인서트
		log.info("llllllllllllllllllllllllllllllllllllllllllll"+communityProfileVO);
		this.communityMapper.setSetting(communityProfileVO);
		communityProfileVO.setFileGroupNo(fileGroupNo);
		communityMapper.setFileProfile(communityProfileVO);
		
		return 1;
	}
	
	@Override
	public CommunityProfileVO profileDetail(CommunityProfileVO communityProfileVO) {
		log.info("profileDetail -> 사진 보여줘야돼~ : "+communityProfileVO);
		return this.communityMapper.profileDetail(communityProfileVO);
	}

	@Override
	public int editProfile(CommunityProfileVO communityProfileVO) {
		MultipartFile[] uploadFile = communityProfileVO.getUploadFile();
		log.info("editProfileService -> communityProfileVO : " + communityProfileVO);
		log.info("editProfileService -> communityProfileVO.getComFileGroupNo : " + communityProfileVO.getFileGroupNo());
		if(communityProfileVO.getComFileGroupNo()== null ) {
			communityProfileVO.setComFileGroupNo(0L);
		}
		long fileGroupNo=0L;
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//FILE_GROUP 및 FILE_DETAIL 테이블에 INSERT
			//동일한 파일 그룹 넘버의 디테일에 새로운 파일 SN 추가
			log.info("editProfileService -> communityProfileVO : " + communityProfileVO);
				fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
			communityProfileVO.setFileGroupNo(fileGroupNo);
			communityProfileVO.setComFileGroupNo(fileGroupNo);
			log.info("editProfile->fileGroupNo : "+communityProfileVO.getComFileGroupNo());
			
			this.communityMapper.setFileProfile(communityProfileVO);
			
		}
		
		//닉네임도 변경 해야함
		if(communityProfileVO.getComNm()!=null&&communityProfileVO.getComNm()!="") {
				communityMapper.editProfileNm(communityProfileVO);
		}
		
		return 1;
	}

	@Override
	public void deleteProfile(CommunityProfileVO communityProfileVO) {
		this.communityMapper.deleteProfile(communityProfileVO);
		this.communityMapper.deleteMyPost(communityProfileVO);
		this.communityMapper.deleteMyReply(communityProfileVO);
		
		//팔로윙 리스트 삭제
		this.communityMapper.deleteMyFollow(communityProfileVO);
		this.communityMapper.delYMyFollow(communityProfileVO);
		//좋아요도 삭제
		this.communityMapper.deleteMyLike(communityProfileVO);
		
		//멤버십 삭제는 불필요 할 듯..?
	}


	

	//리턴값으로 게시물 별 댓글리스트 , 게시물의 좋아요 총합, 댓글의 좋아요 총합을 postVOList에 담아 리턴
	@Override
	public List<CommunityPostVO> artistBoardList(Map<String, Object> map) {
		log.info("fanBaordListService -> VO : "+map);
		List<CommunityPostVO> communityPostVOList =this.communityMapper.artistBoardList(map);
		
		log.info("fanBoardList->communityPostVOList : " + communityPostVOList);
		
		
		
		//아티스트 그룹별 프로필 정보 받아오기
		log.info("fanBaordListService->postList: "+communityPostVOList);
		if (communityPostVOList != null) {
		    for (CommunityPostVO post : communityPostVOList) {
		        int boardNo= post.getBoardNo();
		        long boardFileGroupNo=0L;
		        //post의 프로필 사진 불러오는곳
		        int postProfileNo = post.getComProfileNo();
		        CommunityProfileVO boardProfileDetail = new CommunityProfileVO();
		        boardProfileDetail.setComProfileNo(postProfileNo);
		        boardProfileDetail = this.profileDetail(boardProfileDetail);
		        post.setCommunityProfileVO(boardProfileDetail);
		        //담아주기
		        FileGroupVO fileGroupVO = boardProfileDetail.getFileGroupVO();
		        if (fileGroupVO != null) {
		            post.setFileGroupVO2(fileGroupVO);
		        } else {
		            log.warn("boardProfileDetail.getFileGroupVO() is null for postProfileNo: " + postProfileNo);
		        }
		        //post.setFileGroupVO2(boardProfileDetail.getFileGroupVO());
		        //좋아요 리스트 (memNo)
		        List<LikeDetailVO> boardLikeList = this.communityMapper.boardLikeList(boardNo);
		        post.setBoardLikeList(boardLikeList);
		        
		        
		        List<CommunityReplyVO> communityReplyVOList = this.communityMapper.replyList(boardNo);
		        //좋아요 처리 해주는 부분 // 보드/게시물별 따로 세팅
		        
		       if(communityReplyVOList != null) {
		    	   for(CommunityReplyVO reply : communityReplyVOList) {
		    		long repFileGroupNo=0L;
		    		//댓글 프로필 사진 불러오는 곳
		    		int replyProfileNo =  reply.getComProfileNo();
		    		CommunityProfileVO repProfileDetail = new CommunityProfileVO();
		    		repProfileDetail.setComProfileNo(replyProfileNo);
		    		//댓글 좋아요 카운트
		        	int replyLikeCnt = this.communityMapper.replyLikeCnt(reply);
		    		repProfileDetail= this.profileDetail(repProfileDetail);
		    		
		    		repFileGroupNo = repProfileDetail.getFileGroupVO().getFileGroupNo();
		        	//담아주기
		    		
		    		//댓글 좋아요 리스트(memNo)
		    		List<LikeDetailVO> replyLikeList = this.communityMapper.replyLikeList(reply);
		    		repProfileDetail = this.profileDetail(repProfileDetail);

		    		reply.setCommunityProfileVO(repProfileDetail);
		    		reply.setReplyLikeList(replyLikeList);
		    		reply.setReplyLikeCnt(replyLikeCnt);
		        	reply.setFileGroupNo(repFileGroupNo);
		        	reply.setFileGroupVO(repProfileDetail.getFileGroupVO());
		        	}
		       }
		       
		       //해당 정보들 전부 post에 세팅해서 넘겨줌
		        int boardLikeCnt = this.communityMapper.boardLikeCnt(boardNo);
		        post.setBoardLikeCnt(boardLikeCnt);
		        post.setReplyList(communityReplyVOList);		        
		        log.info("fanBaordListService->communityReplyVOList :" + communityReplyVOList);
		        
		        
		    }
		}
		log.info("communityPostVOList +Reply : "+communityPostVOList);
		
		return communityPostVOList;
	}
	
	//리턴값으로 게시물 별 댓글리스트 , 게시물의 좋아요 총합, 댓글의 좋아요 총합을 postVOList에 담아 리턴
	@Override
	public List<CommunityPostVO> fanBoardList(Map<String, Object> map) {
		log.info("fanBaordListService -> VO : "+map);
		List<CommunityPostVO> communityPostVOList =this.communityMapper.fanBoardList(map);
		
		log.info("fanBoardList->communityPostVOList : " + communityPostVOList);
		
		
		
		//아티스트 그룹별 프로필 정보 받아오기
		log.info("fanBaordListService->postList: "+communityPostVOList);
		if (communityPostVOList != null) {
		    for (CommunityPostVO post : communityPostVOList) {
		        int boardNo= post.getBoardNo();
		        Long boardFileGroupNo=0L;
		        //post의 프로필 사진 불러오는곳
		        int postProfileNo = post.getComProfileNo();
		        CommunityProfileVO boardProfileDetail = new CommunityProfileVO();
		        boardProfileDetail.setComProfileNo(postProfileNo);
		        boardProfileDetail = this.profileDetail(boardProfileDetail);
		        log.info("eiortoeirtjaeoigjaoerig::"+boardProfileDetail);
		        post.setCommunityProfileVO(boardProfileDetail);
		        //담아주기
		        FileGroupVO fileGroupVO = boardProfileDetail.getFileGroupVO();
		        if (fileGroupVO != null) {
		            post.setFileGroupVO2(fileGroupVO);
		        } else {
		            log.warn("boardProfileDetail.getFileGroupVO() is null for postProfileNo: " + postProfileNo);
		        }
		        //post.setFileGroupVO2(boardProfileDetail.getFileGroupVO());
		        //좋아요 리스트 (memNo)
		        List<LikeDetailVO> boardLikeList = this.communityMapper.boardLikeList(boardNo);
		        post.setBoardLikeList(boardLikeList);
		        
		        
		        List<CommunityReplyVO> communityReplyVOList = this.communityMapper.replyList(boardNo);
		        //좋아요 처리 해주는 부분 // 보드/게시물별 따로 세팅
		        
		       if(communityReplyVOList != null) {
		    	   for(CommunityReplyVO reply : communityReplyVOList) {
		    		long repFileGroupNo=0L;
		    		//댓글 프로필 사진 불러오는 곳
		    		int replyProfileNo =  reply.getComProfileNo();
		    		CommunityProfileVO repProfileDetail = new CommunityProfileVO();
		    		repProfileDetail.setComProfileNo(replyProfileNo);
		    		reply.setCommunityProfileVO(repProfileDetail);
		    		//댓글 좋아요 카운트
		        	int replyLikeCnt = this.communityMapper.replyLikeCnt(reply);
		    		repProfileDetail= this.profileDetail(repProfileDetail);
		    		repFileGroupNo = repProfileDetail.getFileGroupVO().getFileGroupNo();
		        	//담아주기
		    		
		    		//댓글 좋아요 리스트(memNo)
		    		List<LikeDetailVO> replyLikeList = this.communityMapper.replyLikeList(reply);
		    		
		    		reply.setReplyLikeList(replyLikeList);
		    		reply.setReplyLikeCnt(replyLikeCnt);
		        	reply.setFileGroupNo(repFileGroupNo);
		        	reply.setFileGroupVO(repProfileDetail.getFileGroupVO());
		        	}
		       }
		       
		       //해당 정보들 전부 post에 세팅해서 넘겨줌
		        int boardLikeCnt = this.communityMapper.boardLikeCnt(boardNo);
		        post.setBoardLikeCnt(boardLikeCnt);
		        post.setReplyList(communityReplyVOList);		        
		        log.info("fanBaordListService->communityReplyVOList :" + communityReplyVOList);
		        
		        
		    }
		}
		log.info("communityPostVOList +Reply : "+communityPostVOList);
		
		return communityPostVOList;
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.communityMapper.getTotal(map);
	}

	@Override
	public int followingCnt(CommunityProfileVO communityProfileVO) {
		// TODO Auto-generated method stub
		return this.communityMapper.followingCnt(communityProfileVO);
	}

	@Override
	public int followerCnt(CommunityProfileVO communityProfileVO) {
		// TODO Auto-generated method stub
		return this.communityMapper.followerCnt(communityProfileVO);
	}


	
	//해야함
	
	@Override
	public int getTotalArtists(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.communityMapper.getTotalArtists(map);
	}



	@Override
	@Transactional(rollbackFor = { IOException.class, SQLException.class, IllegalStateException.class })
	public int addReply(CommunityReplyVO communityReplyVO) {

		log.debug("lllllllll" + communityReplyVO);
		int successReply = this.communityMapper.addReply(communityReplyVO);
		int replyNo = communityReplyVO.getReplyNo();
		communityReplyVO.setReplyNo(replyNo);

		if (successReply == 0) {
			throw new IllegalStateException("댓글 등록 실패로 롤백 처리");
		} else {

			int alarmSuccess = 0;
			if ("ROLE_ART".equals(communityReplyVO.getUrlCategory())) {
				alarmSuccess = this.alarmMapper.alarmReply(communityReplyVO);
				return alarmSuccess;
			}
			
			return successReply;
		}

	}

	@Override
	@Transactional(rollbackFor = {IOException.class, SQLException.class, IllegalStateException.class})
	public int addBoard(CommunityPostVO communityPostVO) {
		
		MultipartFile[] uploadFile = communityPostVO.getUploadFile();
		log.info("addBoard -> communityPostVO : " + communityPostVO);
		long fileGroupNo=0L;
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//FILE_GROUP 및 FILE_DETAIL 테이블에 INSERT
			//동일한 파일 그룹 넘버의 디테일에 새로운 파일 SN 추가
			log.info("addBoard -> communityPostVO : " + communityPostVO);
				fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
				communityPostVO.setFileGroupNo(fileGroupNo);
			
		}
		
		int succesInsert =this.communityMapper.addBoard(communityPostVO);
		communityPostVO.getBoardNo();
		log.debug("dddddddddddddddddd"+communityPostVO.getBoardNo());
		
		int allSuccess=0;
		if(succesInsert ==0){
			throw new IllegalStateException("게시물등록 실패로 롤백 처리");
		}else {
		
			communityPostVO.setBoardNo(communityPostVO.getBoardNo());
			if("ROLE_ART".equals(communityPostVO.getUrlCategory())) {
				allSuccess= this.alarmMapper.alarmComPost(communityPostVO);
				log.debug("알림 isnert 몇개? : "+allSuccess);
			}
		}
		return allSuccess;
		
		
	}

	@Override
	public int boardLikeYn(LikeDetailVO likeYN) {
		// TODO Auto-generated method stub
		int boardLike = likeYN.getBoardNo();
		this.communityMapper.boardLikeYn(likeYN);
		this.communityMapper.boardLikeDelete(likeYN);
		int boardLikeCnt = this.communityMapper.boardLikeCnt(boardLike);
		return boardLikeCnt;
	}

	@Override
	public int replyLikeYn(LikeDetailVO likeYn) {
		int boardNo = likeYn.getBoardNo();
		int replyNo = likeYn.getReplyNo();
		
		CommunityReplyVO communityReplyVO = new CommunityReplyVO();
		communityReplyVO.setBoardNo(boardNo);
		communityReplyVO.setReplyNo(replyNo);
		
		this.communityMapper.replyLikeYn(likeYn);
		this.communityMapper.replyLikeDelete(likeYn);
		int replyLikeCnt = this.communityMapper.replyLikeCnt(communityReplyVO);
		
		return replyLikeCnt;
	}

	@Override
	public List<CommunityProfileVO> followingList(CommunityProfileVO communityProfileVO) {
		// TODO Auto-generated method stub
		return this.communityMapper.followingList(communityProfileVO);
	}

	@Override
	public int deleteBoard(int boardNo) {

		this.communityMapper.deleteBoard(boardNo);
		return 1;
	}

	@Override
	public int deleteReply(int replyNo) {
		
		this.communityMapper.deleteReply(replyNo);

		return 1;
	}

	@Override
	public CommunityPostVO exEditBoard(CommunityPostVO communityPostVO) {

		
		return this.communityMapper.boardDetail(communityPostVO);
	}

	@Override
	public int editBoard(CommunityPostVO communityPostVO) {
		
		MultipartFile[] uploadFile = communityPostVO.getUploadFile();
		log.info("editBoard -> communityPostVO : " + communityPostVO);
		long fileGroupNo=0L;
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//FILE_GROUP 및 FILE_DETAIL 테이블에 INSERT
			//동일한 파일 그룹 넘버의 디테일에 새로운 파일 SN 추가
			log.info("editProfileService -> communityProfileVO : " + communityPostVO);
				fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
				communityPostVO.setFileGroupNo(fileGroupNo);

		}
		
		return this.communityMapper.editBoard(communityPostVO);
	}

	@Override
	public int followYn(int comProfileNo, int followProfileNo) {
		// TODO Auto-generated method stub
		CommunityProfileVO communityProfileVO = new CommunityProfileVO();
		communityProfileVO.setComProfileNo(followProfileNo);
		
		this.communityMapper.followYn(comProfileNo,followProfileNo);
		this.communityMapper.followDelete(comProfileNo,followProfileNo);
		int followerCnt = this.communityMapper.followerCnt(communityProfileVO);
		return followerCnt;
	}

	@Override
	public List<CommunityPostVO> myPostList(Map<String, Object> map) {
	    List<CommunityPostVO> myPostList = this.communityMapper.myPostList(map);

	    for (CommunityPostVO myPost : myPostList) {
	        int boardNo = myPost.getBoardNo();

	        // 각 게시물마다 좋아요와 댓글 리스트를 새로 조회하여 개별적으로 설정
	        List<LikeDetailVO> boardLikeList = communityMapper.boardLikeList(boardNo);
	        List<CommunityReplyVO> boardReplyList = communityMapper.replyList(boardNo);

	        myPost.setBoardLikeList(boardLikeList);
	        myPost.setReplyList(boardReplyList);
	    }

	    return myPostList;
	}

	@Override
	public int getMyPostTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.communityMapper.getMyPostTotal(map);
	}

	@Override
	public List<CommunityReplyVO> myReplyList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.communityMapper.myReplyList(map);
	}

	@Override
	public int getMyReplyTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.communityMapper.getMyReplyTotal(map);
	}

	@Override
	public List<CommunityReplyVO> artistRecentReplyList(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.communityMapper.artistRecentReplyList(artGroupNo);
	}

	@Override
	public String membershipYn(int comProfileNo) {
		// TODO Auto-generated method stub
		return this.communityMapper.membershipYn(comProfileNo);
	}

	@Override
	public List<ArtistScheduleVO> artistSchduleVOList(ArtistScheduleVO artistScheduleVO) {
		// TODO Auto-generated method stub
		return this.communityMapper.artistSchduleVOList(artistScheduleVO);
	}

	@Override
	public int addSchedule(ArtistScheduleVO artistScheduleVO) {
		// TODO Auto-generated method stub
		return this.communityMapper.addSchedule(artistScheduleVO);
	}

	@Override
	public List<ArtistBirthVO> getArtBirth(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.communityMapper.getArtBirth(artGroupNo);
	}

	@Override
	public List<MyCommuntiyVO> myCommunity(int memNo) {
		// TODO Auto-generated method stub
		return this.communityMapper.myCommunity(memNo);
	}

	@Override
	public void fileSnDel(long fileGroupNo, int sn) {
		// TODO Auto-generated method stub
		this.communityMapper.fileSnDel(fileGroupNo,sn);
		
	}





}
