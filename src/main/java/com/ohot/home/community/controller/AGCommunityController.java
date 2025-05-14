package com.ohot.home.community.controller;

import java.io.Console;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.home.alarm.controller.AlarmController;
import com.ohot.home.alarm.controller.AlarmWebSocketController;
import com.ohot.home.alarm.vo.AlarmVO;
import com.ohot.home.community.mapper.CommunityMapper;
import com.ohot.home.community.service.ArtistGroupNoticeService;
import com.ohot.home.community.service.CommunityService;
import com.ohot.home.community.service.impl.BadWordFilterService;
import com.ohot.home.community.vo.ArtistBirthVO;
import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.home.community.vo.ArtistScheduleVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;
import com.ohot.home.community.vo.MyCommuntiyVO;
import com.ohot.service.impl.ArtistGroupServiceImpl;
import com.ohot.util.BoardPage;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.UserAuthVO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/oho/community")
@Controller
public class AGCommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@Autowired
	CommunityMapper communityMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	ArtistGroupServiceImpl artistGroupService;
	
	@Autowired
	ArtistGroupNoticeService artistGroupNoticeService;
	
	@Autowired
	BadWordFilterService badWordFilterService;
	
	@Autowired
	AlarmWebSocketController alarmWebSocketController;
	
	//커뮤니티 디폴트 페이지(그룹아티스트 페이지에서 넘어왔을 때 첫 페이지)
	///oho/community/fanBoardList?comProfileNo=18
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/fanBoardList")
	public String fanBoardList(
			CommunityProfileVO communityProfileVO,
			@AuthenticationPrincipal CustomUser customUser,
			Model model
			) {
		//로그인되어있는 멤버 넘버
		int memNo = (int)customUser.getUsersVO().getUserNo();
		communityProfileVO.setMemNo(memNo);
		//아티스트 그룹별 아티스트 정보 받아오기
		int artGroupNo = communityProfileVO.getArtGroupNo();
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		List<ArtistVO>artistsInGroup = this.artistGroupService.getArtistsInGroup(artistGroupVO);
		
		artistGroupVO.setArtistVOList(artistsInGroup);
		//아티스트 별 댓글 작성 리스트 불러와야 함 <-- 동기 
		List<CommunityReplyVO> artistRecentReplyList = this.communityService.artistRecentReplyList(artGroupNo);
		//커뮤니티 공지사항 불러오는 곳 // 그 중 상위 4개만 불러오기
		Map<String, Object> map = new HashMap<String,Object>();
		int currentPage = 1;
		map.put("artGroupNo", artGroupNo);
		map.put("currentPage", currentPage);
		
		List<ArtistGroupNoticeVO> artistGroupNoticeVOList = this.artistGroupNoticeService.artistGroupNoticeList(map);
		List<ArtistGroupNoticeVO> recentNoticeList = new ArrayList<ArtistGroupNoticeVO>();
		
		log.info("artistGroupNoticeVOList:::"+artistGroupNoticeVOList);
		int i=0;
		//공지 5개만 불러오기
		for (ArtistGroupNoticeVO artistGroupNotice : artistGroupNoticeVOList) {
			if(i==5)break;
			recentNoticeList.add(artistGroupNotice);
			i++;
		}
		
		//아티스트 생일 불러오는 곳
		List<ArtistBirthVO> artistBirthVO = this.communityService.getArtBirth(artGroupNo);
		
		log.info("recentNoticeList:::::"+recentNoticeList);
		
		Date date = new Date();
		SimpleDateFormat formmater = new SimpleDateFormat("MMdd");
		String formattedDate = formmater.format(date);
		
		log.info("DATE======="+formattedDate);
		
		for (ArtistBirthVO artistBirth : artistBirthVO) {
			log.info("생일ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ"+artistBirth.getMemBirth());
			log.info("artActNm====="+artistBirth.getArtActNm());
			if(artistBirth.getMemBirth().contains(formattedDate)) {
				model.addAttribute("artistBirth",artistBirth);
				break;
			}else {
				model.addAttribute("artistBirth","없음");
			}
		}
		//생일 끝
		//myCommunityList 불러오는 곳

		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		
		
		model.addAttribute("recentNoticeList",recentNoticeList);
		model.addAttribute("artistRecentReplyList",artistRecentReplyList);
		model.addAttribute("artistGroupVO", artistGroupVO);
			/*
			CommunityProfileVO(comProfileNo=18, memNo=0, comNm=null, comFileGroupNo=0, comJoinYmd=null, comDelyn=null
			, comAuth=null, artGroupNo=0, profileFileNo=0, fileGroupNo=0, fileGroupVO=null, artistGroupVO=null, uploadFile=null)
			 */
		  log.info("artistBoardList->communityProfileVO(전) : " + communityProfileVO);
		  
    	  String comAuth = customUser.getUsersVO().getUserAuthList().get(0).getAuthNm();
    	  log.info("comAuth======"+comAuth);

	      int artistGroupNo = communityProfileVO.getArtGroupNo();
	      log.info("왜 두번씩 나오니?  : "+communityProfileVO.getMemNo());
	      communityProfileVO.setComAuth(comAuth);
    	  communityProfileVO = communityService.profileDetail(communityProfileVO);
    	  
    	  /*
    	   CommunityProfileVO(comProfileNo=18, memNo=7, comNm=텟, comFileGroupNo=0, comJoinYmd=20250326, comDelyn=N
    	   , comAuth=ROLE_MEM, artGroupNo=1, profileFileNo=0, fileGroupNo=0
    	   , fileGroupVO=FileGroupVO(fileGroupNo=20250402025, fileRegdate=null
	    	   , fileDetailVOList=[FileDetailVO(fileSn=1, fileGroupNo=20250402025
	    	   , fileOriginalName=6a2db153-c13d-43bc-9d34-4c6790dccbf7_KakaoTalk_20250221_143038849_27.jpg
	    	   , fileSaveName=aa1e4d4a-717c-4258-809b-e76a1268cc76_6a2db153-c13d-43bc-9d34-4c6790dccbf7_KakaoTalk_20250221_143038849_27.jpg
	    	   , fileSaveLocate=/2025/04/02/aa1e4d4a-717c-4258-809b-e76a1268cc76_6a2db153-c13d-43bc-9d34-4c6790dccbf7_KakaoTalk_20250221_143038849_27.jpg
	    	   , fileSize=265558, fileExt=jpg, fileMime=image/jpeg, fileFancysize=null, fileSaveDate=Wed Apr 02 10:14:57 KST 2025, fileDowncount=0)
	    	   ]
    	   ), artistGroupVO=null, uploadFile=null)
    	   */
    	  log.info("artistBoardList->communityProfileVO(후) : " + communityProfileVO);

	      //communityProfileVO가 널이면 jsp에서 가입하기 버튼 노출 , 아닐 시 가입하기 버튼 비노출
	      if(communityProfileVO==null||communityProfileVO.getMemNo()==0) {
	         CommunityProfileVO newUser = new CommunityProfileVO();
	         newUser.setMemNo(memNo);
	         newUser.setArtGroupNo(artistGroupNo);
	         newUser.setComAuth(comAuth);
	         model.addAttribute("communityProfileVO",newUser);
	         log.info("넌 안나오면되는데 : "+newUser.getMemNo());
	         //모델에 가입 여부 담긴 VO 담아서 jsp로 넘겨줌
	         //artistGroup name, 그룹에 해당하는 artist 넘버 및 이름 , 파일 사진 필요
	         
	         return "community/fanBoardList";         
	      }
	      else{
	    	//artistGroup name, 그룹에 해당하는 artist 넘버 및 이름 , 파일 사진 필요
	         model.addAttribute("communityProfileVO",communityProfileVO);
	         log.info("fanCommunity -> communityProfileVO  "+communityProfileVO);
	 		//로그인 회원 멤버십 유무 체크 1이면 있음 0이면 없음
	 		int comProfileNo = communityProfileVO.getComProfileNo();
	 		String membershipYn = this.communityService.membershipYn(comProfileNo);
	 		
	 		model.addAttribute("membershipYn",membershipYn);
	         return "community/fanBoardList";
	      }
	      //신고,댓글,좋아요,,,,,등등...해야함.... jsp에서 hide from artist 처리도 해야함.

	}
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/artistBoardList")
	public String artistBoardList(
			HttpSession session,
			@AuthenticationPrincipal CustomUser customUser,
			CommunityProfileVO communityProfileVO,
			Model model
			) {
		
		//로그인되어있는 멤버 넘버
		int memNo = (int)customUser.getUsersVO().getUserNo();
		communityProfileVO.setMemNo(memNo);
		
		//아티스트 그룹별 아티스트 정보 받아오기
		int artGroupNo = communityProfileVO.getArtGroupNo();
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		List<ArtistVO>artistsInGroup = this.artistGroupService.getArtistsInGroup(artistGroupVO);
		
		artistGroupVO.setArtistVOList(artistsInGroup);
		//아티스트 별 댓글 작성 리스트 불러와야 함 <-- 동기 
		List<CommunityReplyVO> artistRecentReplyList = this.communityService.artistRecentReplyList(artGroupNo);

		//공지사항
		Map<String, Object> map = new HashMap<String,Object>();
		int currentPage = 1;
		map.put("artGroupNo", artGroupNo);
		map.put("currentPage", currentPage);
		
		List<ArtistGroupNoticeVO> artistGroupNoticeVOList = this.artistGroupNoticeService.artistGroupNoticeList(map);
		List<ArtistGroupNoticeVO> recentNoticeList = new ArrayList<>();
		
		
		log.info("artistGroupNoticeVOList:::"+artistGroupNoticeVOList);
		int i=0;
		//공지 5개만 불러오기
		for (ArtistGroupNoticeVO artistGroupNotice : artistGroupNoticeVOList) {
			if(i==5)break;
			recentNoticeList.add(artistGroupNotice);
			i++;
		}
		log.info("recentNoticeList:::::"+recentNoticeList);
		
		//아티스트 생일 불러오는 곳
		List<ArtistBirthVO> artistBirthVO = this.communityService.getArtBirth(artGroupNo);
		
		log.info("recentNoticeList:::::"+recentNoticeList);
		
		Date date = new Date();
		SimpleDateFormat formmater = new SimpleDateFormat("MMdd");
		String formattedDate = formmater.format(date);
		
		log.info("DATE======="+formattedDate);
		if(artistBirthVO.size()>0 && artistBirthVO != null) {
			for (ArtistBirthVO artistBirth : artistBirthVO) {
				log.info("생일ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ"+artistBirth.getMemBirth());
				if(artistBirth.getMemBirth().contains(formattedDate)) {
					model.addAttribute("artistBirth",artistBirth);
				}else {
					model.addAttribute("artistBirth","없음");
				}
			}
		}
		//생일 끝
		//마이 커뮤니티 리스트
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		
		model.addAttribute("recentNoticeList",recentNoticeList);		
		model.addAttribute("artistGroupVO", artistGroupVO);
		model.addAttribute("artistRecentReplyList",artistRecentReplyList);
		/*
			CommunityProfileVO(comProfileNo=18, memNo=0, comNm=null, comFileGroupNo=0, comJoinYmd=null, comDelyn=null
			, comAuth=null, artGroupNo=0, profileFileNo=0, fileGroupNo=0, fileGroupVO=null, artistGroupVO=null, uploadFile=null)
		 */
		log.info("fanBoardList->communityProfileVO(전) : " + communityProfileVO);
		
		memNo = communityProfileVO.getMemNo();
		int artistGroupNo = communityProfileVO.getArtGroupNo();
		log.info("왜 두번씩 나오니?  : "+communityProfileVO.getMemNo());
		communityProfileVO = communityService.profileDetail(communityProfileVO);
		
		/*
    	   CommunityProfileVO(comProfileNo=18, memNo=7, comNm=텟, comFileGroupNo=0, comJoinYmd=20250326, comDelyn=N
    	   , comAuth=ROLE_MEM, artGroupNo=1, profileFileNo=0, fileGroupNo=0
    	   , fileGroupVO=FileGroupVO(fileGroupNo=20250402025, fileRegdate=null
	    	   , fileDetailVOList=[FileDetailVO(fileSn=1, fileGroupNo=20250402025
	    	   , fileOriginalName=6a2db153-c13d-43bc-9d34-4c6790dccbf7_KakaoTalk_20250221_143038849_27.jpg
	    	   , fileSaveName=aa1e4d4a-717c-4258-809b-e76a1268cc76_6a2db153-c13d-43bc-9d34-4c6790dccbf7_KakaoTalk_20250221_143038849_27.jpg
	    	   , fileSaveLocate=/2025/04/02/aa1e4d4a-717c-4258-809b-e76a1268cc76_6a2db153-c13d-43bc-9d34-4c6790dccbf7_KakaoTalk_20250221_143038849_27.jpg
	    	   , fileSize=265558, fileExt=jpg, fileMime=image/jpeg, fileFancysize=null, fileSaveDate=Wed Apr 02 10:14:57 KST 2025, fileDowncount=0)
	    	   ]
    	   ), artistGroupVO=null, uploadFile=null)
		 */
		log.info("fanBoardList->communityProfileVO(후) : " + communityProfileVO);
		
		//communityProfileVO가 널이면 jsp에서 가입하기 버튼 노출 , 아닐 시 가입하기 버튼 비노출
		if(communityProfileVO==null||communityProfileVO.getMemNo()==0) {
			CommunityProfileVO newUser = new CommunityProfileVO();
			newUser.setMemNo(memNo);
			newUser.setArtGroupNo(artistGroupNo);
			model.addAttribute("communityProfileVO",newUser);
			log.info("넌 안나오면되는데 : "+newUser.getMemNo());
			//모델에 가입 여부 담긴 VO 담아서 jsp로 넘겨줌
			//artistGroup name, 그룹에 해당하는 artist 넘버 및 이름 , 파일 사진 필요
			
			return "community/artistBoardList";         
		}
		else{
			
			//로그인 회원 멤버십 유무 체크 1이면 있음 0이면 없음
			int comProfileNo = communityProfileVO.getComProfileNo();
			String membershipYn = this.communityService.membershipYn(comProfileNo);
			
			model.addAttribute("membershipYn",membershipYn);
			//artistGroup name, 그룹에 해당하는 artist 넘버 및 이름 , 파일 사진 필요
			model.addAttribute("communityProfileVO",communityProfileVO);
			log.info("fanCommunity -> communityProfileVO  "+communityProfileVO);
			return "community/artistBoardList";
		}
		//신고,댓글,좋아요,,,,,등등...해야함.... jsp에서 hide from artist 처리도 해야함.
		
	}
	
	@ResponseBody
	@PostMapping("/artistBoardListPost")
	public BoardPage<CommunityPostVO> artistBoardListAjax(
			@RequestBody CommunityProfileVO communityProfileVO,
			@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword
			//@RequestBody(required = false) Map<String, Object> params
			
			) {

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("artGroupNo", communityProfileVO.getArtGroupNo());
		
		//map : {artGroupNo=1, currentPage=1, keyword=}
		log.info("fanBoardListAjax->map : " + map);
		//DB에서 데이터 가져오기 ( 페이지 별 셀렉트값 )
		List<CommunityPostVO> communityPostVOList = this.communityService.artistBoardList(map);
		log.info("fanBoardList -> communityPostVOList : "+communityPostVOList);
		
		if(communityPostVOList.size()>0) {
			for (CommunityPostVO communityPostVO : communityPostVOList) {
				if(communityPostVO.getBoardContent().contains("script")) {
					communityPostVO.setBoardContent("보안에 위배된 문구입니다 다시 작성해주세요");
				}else if(communityPostVO.getBoardTitle().contains("script")) {
					communityPostVO.setBoardTitle("보안에 위배된 문구입니다 다시 작성해주세요");
				}
				communityPostVO.getBoardContent().replaceAll(">", "&gt");
				communityPostVO.getBoardContent().replaceAll("<", "&lt");
				communityPostVO.getBoardTitle().replaceAll(">", "&gt");
				communityPostVO.getBoardTitle().replaceAll("<", "&lt");
			}
		}
		
		//욕 필터 처리
		String isBadWord = this.badWordFilterService.badWord();
		String regex = String.join("|", isBadWord.split(",\\r\\n"));
		Pattern pattern = Pattern.compile(regex);

		for (CommunityPostVO isBadReply : communityPostVOList) {
		    Matcher matcher = pattern.matcher(isBadReply.getBoardContent());
		    if (matcher.find()) {
		        isBadReply.setBoardContent("욕은 금지입니다");
		    }
		}
		
		int total = this.communityService.getTotalArtists(map);
		
		BoardPage<CommunityPostVO> boardPage =
				new BoardPage<CommunityPostVO>(total, currentPage, 8, keyword, communityPostVOList, keyword);
		
		log.info("fanBoardListAjax -> boardPage : "+boardPage);
	    boolean isLastPage = currentPage >= boardPage.getTotalPages();
	    log.info("isLastPage -> "+isLastPage);
	    boardPage.setIsLastPage(isLastPage);
		
		return boardPage;
	}
	
	//널이여서 가입을 해야해서 가입버튼을 누른다면(form -> submit)
	@GetMapping("/join")
	public String joinCommunity(
			CommunityProfileVO communityProfileVO,
			@RequestParam(value = "gdsType", required=false, defaultValue = "" ) String gdsType,
			Model model
			) {
		//커뮤니티 가입하는 화면으로 이동
		//VO에 artistGroupNo 와 memNo 담겨서 커뮤니티 가입창으로
		log.info("join->communityProfileVO: "+communityProfileVO);
		model.addAttribute("communityProfileVO",communityProfileVO);
		model.addAttribute("gdsType",gdsType);
		log.info("gdsType:::::"+gdsType);
		return "community/join";
	}
	
	@PostMapping("/joinPost")
	public String joinCommunityPost(
			CommunityProfileVO communityProfileVO,
			@AuthenticationPrincipal CustomUser customUser,
			@RequestParam(value = "gdsType", required=false ) String gdsType,
			Model model

			) {
		//닉네임 및 프사 등록
		//프로필 사진 추가하는 로직 추가해야함
		log.info("joinCommunityPost->CommunityProfileVO : " + communityProfileVO);
		
		int memNo = (int)customUser.getUsersVO().getUserNo();
		communityProfileVO.setMemNo(memNo);
		
		int result = this.communityService.joinCommunity(communityProfileVO);
		log.info("joinCommunityPost->result : "+ result);
		//communityProfileVO.set memNo , artistGroupNo
		
		communityProfileVO = this.communityService.profileDetail(communityProfileVO);
		String link ="redirect:/oho/community/profileDetail?comProfileNo="+communityProfileVO.getComProfileNo();
		log.info("gdsType=="+gdsType);
		if(gdsType.equals("M")) {
			model.addAttribute("gdsType", gdsType);
			model.addAttribute("artGroupNo",communityProfileVO.getArtGroupNo());
			link = "community/redirectMemberShip";
		}
		return link;
	}
	
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/profileDetail")
	public String getProfile(
			CommunityProfileVO communityProfileVO,
			@AuthenticationPrincipal CustomUser customUser,
			Model model
			) {
		//팔로우,팔로워 로직
		int followingCnt = this.communityService.followingCnt(communityProfileVO);
		int followerCnt = this.communityService.followerCnt(communityProfileVO);

		log.info("profileDetail -> followingCnt : " +followingCnt);
		log.info("profileDetail -> followerCnt : "+followerCnt);
		//프로필 사진 들어가는거 추가해야함
		//파일 그룹 VO에 들어있는 값 중 최근 사진 중 하나만 꺼내와야 하는 로직
		//detail에서 Max(FILE_SN)만 추가
		
		//아티스트 그룹별 아티스트 정보 받아오기
		
		
		int artGroupNo = this.communityService.profileDetail(communityProfileVO).getArtGroupNo();
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		log.info("artGroupNo:::::::::::::"+artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		//끝
		
		//마이 커뮤니티 리스트
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("myCommunityList::::"+myCommunityList);
		

		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		
		
		communityProfileVO = this.communityService.profileDetail(communityProfileVO);
		
		model.addAttribute("artistGroupVO",artistGroupVO);
		model.addAttribute("communityProfileVO",communityProfileVO);
		model.addAttribute("followingCnt",followingCnt);
		model.addAttribute("followerCnt",followerCnt);
		log.info("getProfile-> communityProfileVO"+communityProfileVO);
		
		return "community/profileDetail";
	}
	
	//팔로윙 중인 목록 노출 (본인일 경우만 노출)
	//인피니티 스크롤로 필요............
	//아마 모달?
	@ResponseBody
	@GetMapping("/followingList")
	public List<CommunityProfileVO> followingListAjax(
			CommunityProfileVO communityProfileVO
			) {
		//프로필 디테일 팔로우 리스트 
		if(communityProfileVO.getComProfileNo()==0) {
		int memNo = communityProfileVO.getMemNo();
		int artGroupNo = communityProfileVO.getArtGroupNo();
		int comProfileNo = this.communityService.profileDetail(communityProfileVO).getComProfileNo();
		communityProfileVO.setComProfileNo(comProfileNo);
		log.info("followingList:::::::: 오고있니? "+communityProfileVO);
		}
		List<CommunityProfileVO> followingList = this.communityService.followingList(communityProfileVO);
		log.info("followingListAjax -> followingList : "+followingList);
		
		this.communityService.followingCnt(communityProfileVO);
		
		
		return followingList;
	}
	@ResponseBody
	@PostMapping("/followYn")
	public int followYn(
			@RequestBody Map<String,Object>map
			) {
		//map으로 데이터 받기(int 세개 RB로 못받음)
		int artGroupNo = (int)map.get("artGroupNo");
		int followProfileNo = (int)map.get("followProfileNo");
		int memNo = (int)map.get("memNo");
		
		
		//접속한 계정에 대한 정보
		CommunityProfileVO myCommunityProfileVO = new CommunityProfileVO();
		myCommunityProfileVO.setArtGroupNo(artGroupNo);
		myCommunityProfileVO.setMemNo(memNo);
		int comProfileNo = this.communityService.profileDetail(myCommunityProfileVO).getComProfileNo();
		
		log.info("followYn :::::들어왓니?",followProfileNo);
		int followerCnt = this.communityService.followYn(comProfileNo,followProfileNo);
		return followerCnt;
	}
	
	
	
	@GetMapping("/editProfile")
	public String editProfile(
			CommunityProfileVO communityProfileVO,
			@AuthenticationPrincipal CustomUser customUser,
			Model model
			) {
		//VO에 artistGroupNo 와 memNo 담겨서 커뮤니티 가입창으로
		communityProfileVO = this.communityService.profileDetail(communityProfileVO);
		log.info("editProfile-> groupFileNo : "+communityProfileVO.getComProfileNo());
		
		//아티스트 그룹별 아티스트 정보 받아오기
		int artGroupNo = communityProfileVO.getArtGroupNo();
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		//끝
		
		//마이 커뮤니티 리스트
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		
		model.addAttribute("artistGroupVO",artistGroupVO);
		model.addAttribute("communityProfileVO",communityProfileVO);
		return "community/editProfile";
	}
	@PostMapping("/editProfilePost")
	public String editProfilePost(
			CommunityProfileVO communityProfileVO

			) {
		//닉네임 및 프사 수정
		//프로필 사진 수정하는 로직 추가해야함
		//communityProfileVO.set memNo , artistGroupNo
		int result = this.communityService.editProfile(communityProfileVO);
		
		log.info("editProfilePost->result : "+result);
		
		//Authentication 처리 한 후 oho 지울 예정
		return "redirect:/oho/community/profileDetail?comProfileNo="+communityProfileVO.getComProfileNo();
	}

	
	@GetMapping("/deleteBoard")
	public String deleteBoard(
			@RequestParam int boardNo,
			@RequestParam int comProfileNo,
			@AuthenticationPrincipal CustomUser customUser
			) {
		//url 조작 처리
		CommunityPostVO communityPostVO = new CommunityPostVO();
		communityPostVO.setBoardNo(boardNo);
		int memNo = this.communityMapper.boardDetail(communityPostVO).getMemNo();
		if(memNo != customUser.getUsersVO().getUserNo()) {
			return "/error";
		}
		
		this.communityService.deleteBoard(boardNo);
		CommunityProfileVO comProfileVO = new CommunityProfileVO();
		comProfileVO.setComProfileNo(comProfileNo);
		comProfileVO = this.communityService.profileDetail(comProfileVO);
		int artGroupNo = comProfileVO.getArtGroupNo();
		
		String userAuth = customUser.getUsersVO().getUserAuthList().get(0).getAuthNm();
		String link = "";
		
		if(userAuth.equals("ROLE_MEM")) {
			link = "redirect:/oho/community/fanBoardList?comProfileNo="+comProfileNo+"&artGroupNo="+artGroupNo;

		}else {
			link="redirect:/oho/community/artistBoardList?comProfileNo="+comProfileNo+"&artGroupNo="+artGroupNo;

		}
		
		return link;
	}
	@ResponseBody
	@GetMapping("/deleteReply")
	public int deleteReply(
			@RequestParam int replyNo,
			@RequestParam int boardNo
			) {
		
		 this.communityService.deleteReply(replyNo);
		List<CommunityReplyVO> replyList = this.communityMapper.replyList(boardNo);
		
		int replyCnt = replyList.size();
		log.info("replyList length : "+replyCnt);
		return replyCnt;
	}
	
	//댓글(3)과 같이 댓글 클릭시 게시글의 댓글 목록을 모달창에 보여줌
	@ResponseBody
	@PostMapping("/replyList")
	public List<CommunityReplyVO> replyList(
			@RequestParam int boardNo
			) {
		//클릭한 게시글의 댓글 목록 select
		List<CommunityReplyVO> replyList = this.communityMapper.replyList(boardNo);
		log.info("replyList replyList : "+replyList);
		if(replyList.size()>0) {
		for (CommunityReplyVO communityReplyVO : replyList) {
			int comProfileNo = communityReplyVO.getComProfileNo();
			CommunityProfileVO communityProfileVO = new CommunityProfileVO();
			communityProfileVO.setComProfileNo(comProfileNo);
			
			communityProfileVO = this.communityMapper.profileDetail(communityProfileVO);
			communityReplyVO.setCommunityProfileVO(communityProfileVO);
			}
		}
		
		//여기에 comProfile 정보 담아줘야 하나?
		
		//script 공격 막는 구문
		if(replyList.size()>0) {
		for(CommunityReplyVO reply : replyList) {
			if(reply.getReplyContent().contains("script")) {
				reply.setReplyContent("보안에 위배된 문구입니다 다시 작성해주세요");
			}
			String replyContent =  reply.getReplyContent();
			replyContent.replaceAll(">", "&gt");
			replyContent.replaceAll("<", "&lt");
			}
		}
		
		//욕 필터 처리
		String isBadWord = this.badWordFilterService.badWord();
		String regex = String.join("|", isBadWord.split(",\\r\\n"));
		Pattern pattern = Pattern.compile(regex);

		for (CommunityReplyVO isBadReply : replyList) {
		    Matcher matcher = pattern.matcher(isBadReply.getReplyContent());
		    if (matcher.find()) {
		        isBadReply.setReplyContent("욕은 금지입니다");
		    }
		}
		
		
		return replyList;
	}
	
	
	//커뮤니티 사용자 전체가 쓴 게시글 리스트
	//xml에서는 artist게시판도 같이 쓸 쿼리 작성하기// hide from artist -> jsp 에서 처리
	@ResponseBody
	@PostMapping("/fanBoardListPost")
	public BoardPage<CommunityPostVO> fanBoardListAjax(
			@RequestBody CommunityProfileVO communityProfileVO,
			@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword
			//@RequestBody(required = false) Map<String, Object> params
			
			) {

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("artGroupNo", communityProfileVO.getArtGroupNo());
		
		//map : {artGroupNo=1, currentPage=1, keyword=}
		log.info("fanBoardListAjax->map : " + map);
		//DB에서 데이터 가져오기 ( 페이지 별 셀렉트값 )
		List<CommunityPostVO> communityPostVOList = this.communityService.fanBoardList(map);
		
		//욕 필터 처리
		String isBadWord = this.badWordFilterService.badWord();
		String regex = String.join("|", isBadWord.split(",\\r\\n"));
		Pattern pattern = Pattern.compile(regex);

		for (CommunityPostVO isBadReply : communityPostVOList) {
		    Matcher matcher = pattern.matcher(isBadReply.getBoardContent());
		    if (matcher.find()) {
		        isBadReply.setBoardContent("욕은 금지입니다");
		    }
		}
		
		log.info("fanBoardList -> communityPostVOList : "+communityPostVOList);
		//스크립트 공격 무력화
		if(communityPostVOList.size()>0) {
			for(CommunityPostVO communityPostVO :communityPostVOList) {
				if(communityPostVO.getBoardContent().contains("script")) {
					communityPostVO.setBoardContent("보안에 위배된 문구입니다 다시 작성해주세요");
				}else if(communityPostVO.getBoardTitle().contains("script")) {
					communityPostVO.setBoardTitle("보안에 위배된 문구입니다 다시 작성해주세요");
				}
				communityPostVO.getBoardContent().replaceAll(">","&gt");
				communityPostVO.getBoardContent().replaceAll("<", "&lt");
				communityPostVO.getBoardTitle().replaceAll(">","&gt");
				communityPostVO.getBoardTitle().replaceAll("<", "&lt");
			}
		}
		

		
		
		int total = this.communityService.getTotal(map);
		
		BoardPage<CommunityPostVO> boardPage =
				new BoardPage<CommunityPostVO>(total, currentPage, 8, keyword, communityPostVOList, keyword);
		
		log.info("fanBoardListAjax -> boardPage : "+boardPage);
	    boolean isLastPage = currentPage >= boardPage.getTotalPages();
	    log.info("isLastPage -> "+isLastPage);
	    boardPage.setIsLastPage(isLastPage);
		
		return boardPage;
	}
	

	
	
	
	
	@PostMapping("/addBoard")
	public String addBoard(
			CommunityPostVO communityPostVO,
			@AuthenticationPrincipal CustomUser customUser,
			Model model
			) {
		
		
		//urlCategory 추가
		List<UserAuthVO> getUserAuthList = customUser.getUsersVO().getUserAuthList();
		UserAuthVO userAuthVO = getUserAuthList.get(0);
		log.info("urlCategory::::::::"+userAuthVO);
		communityPostVO.setUrlCategory(userAuthVO.getAuthNm());
		
		int result = this.communityService.addBoard(communityPostVO);
		int comProfileNo = communityPostVO.getComProfileNo();
		//로그인되어있는 멤버 넘버
        int memNo = (int)customUser.getUsersVO().getUserNo();
        
        
		//아티스트 그룹별 아티스트 정보 받아오기
		int artGroupNo = communityPostVO.getArtGroupNo();
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		List<ArtistVO>artistsInGroup = this.artistGroupService.getArtistsInGroup(artistGroupVO);
		
		artistGroupVO.setArtistVOList(artistsInGroup);
		//아티스트 별 댓글 작성 리스트 불러와야 함 <-- 동기 
		List<CommunityReplyVO> artistRecentReplyList = this.communityService.artistRecentReplyList(artGroupNo);
		String link = "";
		if(userAuthVO.getAuthNm().equals("ROLE_MEM")) {
			link = "redirect:/oho/community/fanBoardList?artGroupNo="+artGroupNo;
		}else {
			link = "redirect:/oho/community/artistBoardList?artGroupNo="+artGroupNo;
		}
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);

		log.info("addFanBaordPost -> addBoard : "+result);

		return link;
		
	}
	
	
	@PostMapping("/addArtBoard")
	public String addArtBoard(
			CommunityPostVO communityPostVO,
			@AuthenticationPrincipal CustomUser customUser,
			Model model
			) {
		
		log.info("뭐야 왜안찍힘"+communityPostVO);
		
		List<UserAuthVO> getUserAuthList = customUser.getUsersVO().getUserAuthList();
		UserAuthVO userAuthVO = getUserAuthList.get(0);
		log.info("replyurlCategory::::::::"+userAuthVO);
		
		communityPostVO.setUrlCategory(userAuthVO.getAuthNm());
		
		int result = this.communityService.addBoard(communityPostVO);
		int comProfileNo = communityPostVO.getComProfileNo();
		log.info("addFanBaordPost -> addBoard : "+result);
		
		
		if(result>0 && "ROLE_ART".equals(communityPostVO.getUrlCategory())) {
			log.info("llllllllllllllllllll 여기임?"+communityPostVO);
			AlarmVO alarmVO = new AlarmVO();
			alarmVO.setCommunityPostVO(communityPostVO);
			this.alarmWebSocketController.alarmFromPost(alarmVO);
		}
		
		return "redirect:/oho/community/artistBoardList?artGroupNo="+communityPostVO.getArtGroupNo();
	}
	
	
	//게시물 수정
	@PostMapping("/editBoard")
	public String editBoard(
			CommunityPostVO communityPostVO,
			@AuthenticationPrincipal CustomUser customUser,
	        @RequestParam(value = "deletedFileSnList", required = false) String deletedFileSnListStr
			) {

	    int[] deletedFileSnList = null;
		log.info(deletedFileSnListStr);
		long fileGroupNo = 0L;
		if(communityPostVO.getFileGroupNo() != null && communityPostVO.getFileGroupNo() != 0 ) {
		fileGroupNo = communityPostVO.getFileGroupNo();
		}
		if(deletedFileSnListStr!=null && !deletedFileSnListStr.isEmpty()) {
			log.info(deletedFileSnListStr);
	        deletedFileSnList = Arrays.stream(deletedFileSnListStr.split(","))
                    .map(String::trim)
                    .mapToInt(Integer::parseInt)
                    .toArray();

			for (int sn : deletedFileSnList) {
			log.info("deletedFileSnList === {}", sn);
			this.communityService.fileSnDel(fileGroupNo,sn);
			}
		}
		
		
		
		int boardNo = communityPostVO.getBoardNo();
		log.info("boardNo =-=-===="+boardNo);
		int result = this.communityService.editBoard(communityPostVO);
		int comProfileNo = communityPostVO.getComProfileNo();
		int artGroupNo = communityPostVO.getArtGroupNo();
		log.info("addFanBaordPost -> editBoard : "+result);
		
		String userAuth = customUser.getUsersVO().getUserAuthList().get(0).getAuthNm();
		
		log.info("userAuth=-=-=-"+userAuth);
		
		String link = "";
		if(userAuth.equals("ROLE_MEM")) {
			link = "redirect:/oho/community/fanBoardList?artGroupNo="+artGroupNo;
		}else {
			link = "redirect:/oho/community/artistBoardList?artGroupNo="+artGroupNo;
		}
		
		return link;
	}
	//마이페이지에서 오는거
	@PostMapping("/editBoard2")
	public String editBoard2(
			CommunityPostVO communityPostVO
			
			) {
		int boardNo = communityPostVO.getBoardNo();
		log.info("boardNo =-=-===="+boardNo);
		int result = this.communityService.editBoard(communityPostVO);
		int comProfileNo = communityPostVO.getComProfileNo();
		log.info("addFanBaordPost -> editBoard : "+result);
		return "redirect:/oho/community/profileDetail?comProfileNo="+comProfileNo;
	}
	
	/*
	 * //팬 게시글 등록
	 * 
	 * @GetMapping("/addFanBoard") public String addFanBoard( CommunityReplyVO
	 * communityReplyVO, Model model ) {
	 * model.addAttribute("communityReplyVO",communityReplyVO);
	 * 
	 * return "/community/addFanBoard"; }
	 */
	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/addFanBoardAjax") public int addFanBoardAjax(
	 * 
	 * @RequestBody CommunityPostVO communityPostVO
	 * 
	 * ) {
	 * 
	 * 
	 * int result = this.communityService.addBoard(communityPostVO);
	 * 
	 * log.info("addFanBaordPost -> addBoard : "+result); //oho Authentication 후 지울
	 * 예정 return result; }
	 */
	
	//기존 보드내용 가져오기
	@ResponseBody
	@GetMapping("/editFanBoardAjax")
	public CommunityPostVO editFanBoardAjax(
			CommunityPostVO communityPostVO
		
			
			) {

		communityPostVO = this.communityService.exEditBoard(communityPostVO);
		log.info("editBoard ~~~~~====== :" + communityPostVO);
		//oho Authentication 후 지울 예정
		return communityPostVO;
	}
	@ResponseBody
	@GetMapping("/editFanBoardAjax2")
	public CommunityPostVO editFanBoardAjax2(
			CommunityPostVO communityPostVO
			
			) {
		
		
		communityPostVO = this.communityService.exEditBoard(communityPostVO);
		log.info("editBoard ~~~~~====== :" + communityPostVO);
		//oho Authentication 후 지울 예정
		return communityPostVO;
	}
	
	
	//아티스트 게시글 등록
	
	//팬 게시글 등록
	@GetMapping("/addArtistBoard")
	public String addArtistBoard(
			CommunityReplyVO communityReplyVO,
			Model model
			) {
		
		model.addAttribute("communityReplyVO",communityReplyVO);
		
		return "/community/addArtistBoard";
	}
	
	/*
	 * @PostMapping("/addArtistBoardPost") public String addArtistBoardPost(
	 * CommunityPostVO communityPostVO,
	 * 
	 * ) {
	 * 
	 * 
	 * int result = this.communityService.addBoard(communityPostVO);
	 * 
	 * log.info("addArtistBaordPost -> addBoard : "+result); //oho Authentication 후
	 * 지울 예정 return
	 * "redirect:/oho/community/BoardDetail?boardNo="+communityPostVO.getBoardNo();
	 * }
	 */
	
	//신고하기 기능 필요
	//게시글 넘버
	@GetMapping("/report")
	public String report(
			CommunityPostVO communityPostVO,
			Model model
			) {
		
		model.addAttribute("communityPostVO",communityPostVO);
		
		//임시-> jsp 파일 폼 누가? 
		return "/community/report";
	}
	
	
	
	//jsp에서 아작스 두개 만들어서 board는 boardNo만 reply는 boardNo과 replyNo 두개 넘겨주면됌
	//좋아요 보드랑 팬이랑 나눠야 함? 아마 팬,아티스트 게시물로 옮길듯.+팔로우
	@ResponseBody
	@GetMapping("/boardLikeYnAjax")
	public int boardLikeYnAjax(
			LikeDetailVO likeYn
			) {
		if(likeYn.getComProfileNo()==0) {
			int memNo = likeYn.getMemNo();
			int artGroupNo = likeYn.getArtGroupNo();
			log.info("dfagdfgdfg ::" +artGroupNo);
			CommunityProfileVO communityProfileVO = new CommunityProfileVO();
			communityProfileVO.setArtGroupNo(artGroupNo);
			communityProfileVO.setMemNo(memNo);
			
			communityProfileVO=this.communityService.profileDetail(communityProfileVO);
			likeYn.setComProfileNo(communityProfileVO.getComProfileNo());
		}
		log.info("likeYnAjax -> likeYn : "+likeYn);
		int boardLikeCnt = this.communityService.boardLikeYn(likeYn);
		
		return boardLikeCnt;
	}
	@ResponseBody
	@GetMapping("/replyLikeYnAjax")
	public int replyLikeYnAjax(
			LikeDetailVO likeYn
			) {
		if(likeYn.getComProfileNo()==0) {
			int memNo = likeYn.getMemNo();
			int artGroupNo = likeYn.getArtGroupNo();
			
			CommunityProfileVO communityProfileVO = new CommunityProfileVO();
			communityProfileVO.setArtGroupNo(artGroupNo);
			communityProfileVO.setMemNo(memNo);
			
			this.communityService.profileDetail(communityProfileVO);
			likeYn.setComProfileNo(communityProfileVO.getComProfileNo());
		}
		log.info("likeYnAjax -> likeYn : "+likeYn);
		int replyLikeCnt = this.communityService.replyLikeYn(likeYn);
		
		return replyLikeCnt;
	}
	
	//팬 댓글 등록하기
	@ResponseBody
	@GetMapping("/addReplyAjax")
	public CommunityReplyVO AddreplyControllerAjax(
			CommunityReplyVO communityReplyVO,
			@AuthenticationPrincipal CustomUser customUser,
			CommunityProfileVO communityProfileVO
			) {
		
		List<UserAuthVO> getUserAuthList = customUser.getUsersVO().getUserAuthList();
		UserAuthVO userAuthVO = getUserAuthList.get(0);
		log.info("replyurlCategory::::::::"+userAuthVO);
		
		communityReplyVO.setUrlCategory(userAuthVO.getAuthNm());
		int result = this.communityService.addReply(communityReplyVO);

		communityReplyVO.setCommunityProfileVO(communityProfileVO);
		log.info("AddreplyController -> result : "+result);
		
		if(result>0 && "ROLE_ART".equals(communityReplyVO.getUrlCategory())) {
			log.info("실시간 알림연결 실행"+ communityReplyVO);
			AlarmVO alarmVO = new AlarmVO();
			alarmVO.setCommunityReplyVO(communityReplyVO);
			this.alarmWebSocketController.alarmFromPost(alarmVO);
		}
		
		return communityReplyVO;
		
	}
	
	@ResponseBody
	@PostMapping("/myPostList")
	public BoardPage<CommunityPostVO> myPostList(
			@RequestBody CommunityProfileVO communityProfileVO
			){
		
		int currentPage = communityProfileVO.getCurrentPage();
		String keyword = communityProfileVO.getKeyword();
		
		if(currentPage==0) {
			currentPage = 1;
		}
		
		if(keyword==null){
			keyword = "";
		}
		
		/*
		CommunityProfileVO(comProfileNo=8, memNo=0, comNm=null, comFileGroupNo=0, comJoinYmd=null, comDelyn=null
		, comAuth=null, artGroupNo=1, profileFileNo=0, fileGroupNo=0, fileGroupVO=null, artistGroupVO=null
		, uploadFile=null)
		 */
		log.info("myPostList->communityProfileVO : " + communityProfileVO);
		log.info("myPostList->currentPage : " + currentPage);
		log.info("myPostList->keyword : " + keyword);
		
		//페이지네이션 처리
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("comProfileNo", communityProfileVO.getComProfileNo());
		
		List<CommunityPostVO> myPostList = this.communityService.myPostList(map);
		int getMyPostTotal = this.communityService.getMyPostTotal(map);
		//욕 필터 처리
		String isBadWord = this.badWordFilterService.badWord();
		String regex = String.join("|", isBadWord.split(",\\r\\n"));
		Pattern pattern = Pattern.compile(regex);

		for (CommunityPostVO isBadReply : myPostList) {
		    Matcher matcher = pattern.matcher(isBadReply.getBoardContent());
		    if (matcher.find()) {
		        isBadReply.setBoardContent("욕은 금지입니다");
		    }
		}
		
		for (CommunityPostVO communityPostVO : myPostList) {
			if(communityPostVO.getBoardContent().contains("script")) {
				communityPostVO.setBoardContent("보안 위배된 문구입니다");
			}else if(communityPostVO.getBoardTitle().contains("sciprt")) {
				communityPostVO.setBoardTitle("보안에 위배된 문구입니다");
			}
			communityPostVO.getBoardContent().replaceAll(">", "&gt");
			communityPostVO.getBoardContent().replaceAll("<", "&lt");
			communityPostVO.getBoardTitle().replaceAll(">", "&gt");
			communityPostVO.getBoardTitle().replaceAll("<", "&lt");
			
		}
		
		
		BoardPage<CommunityPostVO> boardPage = new BoardPage<>(getMyPostTotal, currentPage, 8, keyword, myPostList, keyword);
		
		

		
		
		log.info("들어오고 있니?  "+boardPage);
	    boolean isLastPage = currentPage >= boardPage.getTotalPages();
	    log.info("isLastPage -> "+isLastPage);
	    boardPage.setIsLastPage(isLastPage);
		return boardPage;
	}
	@ResponseBody
	@PostMapping("/myReplyList")
	public BoardPage<CommunityReplyVO> myReplyList(
			@RequestBody CommunityProfileVO communityProfileVO

			){
		//페이지네이션 처리
		
		int currentReplyPage = communityProfileVO.getCurrentReplyPage();
		String keyword = communityProfileVO.getKeyword();
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentReplyPage);
		map.put("keyword", keyword);
		map.put("comProfileNo", communityProfileVO.getComProfileNo());
		
		List<CommunityReplyVO> myReplyList = this.communityService.myReplyList(map);
		
		//욕 필터 처리
		String isBadWord = this.badWordFilterService.badWord();
		String regex = String.join("|", isBadWord.split(",\\r\\n"));
		Pattern pattern = Pattern.compile(regex);

		for (CommunityReplyVO isBadReply : myReplyList) {
		    Matcher matcher = pattern.matcher(isBadReply.getReplyContent());
		    if (matcher.find()) {
		        isBadReply.setReplyContent("욕은 금지입니다");
		    }
		}
		
		//스크립트 공격 방지
		for (CommunityReplyVO communityReply : myReplyList) {
			if(communityReply.getReplyContent().contains("script")){
				communityReply.setReplyContent("보안 위배된 문구입니다");
			}
			communityReply.getReplyContent().replaceAll(">","&gt");
			communityReply.getReplyContent().replaceAll("<","&lt");
			
		}
		
		int getMyReplyTotal = this.communityService.getMyReplyTotal(map);
		
		BoardPage<CommunityReplyVO> boardPage = new BoardPage<>(getMyReplyTotal, currentReplyPage, 8, keyword, myReplyList, keyword);
		
		log.info("reply current들어오고 있니?  "+boardPage);
		boolean isReplyLastPage = currentReplyPage >= boardPage.getTotalPages();
		log.info("isLastPage -> "+isReplyLastPage);
		boardPage.setIsReplyLastPage(isReplyLastPage);
		return boardPage;
	}

	
	@GetMapping("/fullcalendar")
	public String getArtistSchedule(
			ArtistScheduleVO artistScheduleVO,
			Model model
			) {
		List<ArtistScheduleVO> artistScheduleVOList = this.communityService.artistSchduleVOList(artistScheduleVO);
		model.addAttribute("artistScheduleVOList",artistScheduleVOList);
		
		log.info("fullcalendar ::::::: "+artistScheduleVOList);
		return "community/fullcalendar";
	}
	@PostMapping("/addSchedule")
	public String addSchedule(
			ArtistScheduleVO artistScheduleVO
			
			) {
		int result = this.communityService.addSchedule(artistScheduleVO);
				
		log.info("addSchedult->result::"+result);
		return "redirect:/oho/community/fullcalendar?artGroupNo="+artistScheduleVO.getArtGroupNo();
	}
	@PostMapping("/deleteProfile")
	public String deleteProfile(
			CommunityProfileVO communityProfileVO,
			@AuthenticationPrincipal CustomUser customUser
			) {

		log.info("delete-> communityProfileVO"+communityProfileVO);
		this.communityService.deleteProfile(communityProfileVO);
		return "redirect:/oho";
	}
}
