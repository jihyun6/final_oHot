package com.ohot.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.mapper.ArtistMapper;
import com.ohot.mapper.MemberMapper;
import com.ohot.service.MemberService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

// UserService가 우리가 만든 interface
@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	ArtistMapper artistMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	// 회원가입
	@Override
	@Transactional
	public int signUp(MemberVO memberVO) {
		String memPswd = memberVO.getMemPswd();
		memPswd = this.bCryptPasswordEncoder.encode(memPswd);
		String memBirth = memberVO.getMemBirth();
		memBirth = memBirth.replaceAll("[^0-9]", "");
		
		memberVO.setMemPswd(memPswd); // 암호화된 패스워드를 set
		memberVO.setMemBirth(memBirth); // 하이픈 제거한 생년월일
		
		int result = this.memberMapper.signUp(memberVO);
		log.info("signUp -> result : " + result);
		if(result > 0) this.memberMapper.insertAuth(memberVO);
		
		return result;
	}

	@Override
	public List<MemberVO> memberList() {
		return this.memberMapper.memberList();
	}

	@Transactional
	@Override
	public MemberVO memberUpdate(MemberVO memberVO) {
		
		memberVO.setMemTelno(memberVO.getMemTelno().replaceAll("-", ""));
		memberVO.setMemBirth(memberVO.getMemBirth().replaceAll("-", ""));
		memberVO.setJoinYmd(memberVO.getJoinYmd().replaceAll("-", ""));
		memberVO.setSecsnYmd(memberVO.getSecsnYmd().replaceAll("-", ""));
		log.info("memberUpdate=>memberVO : " + memberVO);
		
		// 회원 구분 선택이 M01 -> 일반회원 일 때
		if("M01".equals(memberVO.getMemSecCodeNo())) {
			this.memberMapper.memberUpdate(memberVO);
			
			// 일반 회원 상태가 탈퇴일때
			if(memberVO.getMemStatSecCodeNo().equals("002")) {
				this.memberMapper.memberCancle(memberVO);
				this.memberMapper.authDelete(memberVO);
			}
			
			return this.memberMapper.memberDetail(memberVO);
		
		}else{// 회원 구분 선택이 M02->아티스트일 경우
			
			
			// 처음 아티스트 정보 입력해줄 경우
			if(memberVO.getArtistVO() !=null && memberVO.getArtistVO().getArtNo() == 0) {
				
				MultipartFile[] multipartFiles = memberVO.getArtistVO().getUploadFile();
				this.memberMapper.memberUpdate(memberVO);
				this.memberMapper.authUpdate(memberVO);
					
				if(multipartFiles[0] != null && multipartFiles[0].getOriginalFilename().length() > 0) {
					long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
					memberVO.getArtistVO().setFileGroupNo(fileGroupNo);
				}
				
				//ARTIST 테이블의 MEM_NO 값은 필수임!
				memberVO.getArtistVO().setMemNo(memberVO.getMemNo());
				
				this.artistMapper.artistInsert(memberVO.getArtistVO());
				
			}else {// 아티스트 정보가 들어있고 수정할 경우
				
				log.info("memberUpdate 실행!");
				
				int memberUpdateResp = this.memberMapper.memberUpdate(memberVO);
				log.info("memberUpdateResp : " + memberUpdateResp);
				
				// 아티스트 회원 상태가 탈퇴일때
				if(memberVO.getMemStatSecCodeNo().equals("002")) {
					this.memberMapper.memberCancle(memberVO);
					this.memberMapper.authDelete(memberVO);
				}else {// 아티스트 회원 상태가 탈퇴가 아닐 때
					
					//memberVO
					log.info("memberVO.getArtistVO() : " + memberVO.getArtistVO());
					
					// 파일 등록하지 않고 등록한 경우에 대한 수정
					if(memberVO.getArtistVO().getFileGroupNo() == 0) {
						
						MultipartFile[] multipartFiles = memberVO.getArtistVO().getUploadFile();
						
						if(multipartFiles != null && multipartFiles.length>0 && multipartFiles[0] != null && multipartFiles[0].getOriginalFilename().length() > 0) {
							long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
							memberVO.getArtistVO().setFileGroupNo(fileGroupNo);
						}
						
					}else if(memberVO.getArtistVO() != null && memberVO.getArtistVO().getArtNo() != 0) {
						
						MultipartFile[] multipartFiles = memberVO.getArtistVO().getUploadFile();
						
						if(multipartFiles != null && multipartFiles.length>0 && multipartFiles[0] != null && multipartFiles[0].getOriginalFilename().length() > 0) {
							
							long fileGroupNo = memberVO.getArtistVO().getFileGroupNo();
							this.uploadController.multiImageUploadTOFileDetail(fileGroupNo, multipartFiles);
							
						}
						
						this.artistMapper.artistUpdate(memberVO.getArtistVO());
					}
					
					this.artistMapper.artistUpdate(memberVO.getArtistVO());
				}
				
			}
		
			return this.memberMapper.modalDetailInfo(memberVO);
		}
		
	}

	@Override
	public List<MemberVO> memberSearchList(Map<String, Object> map) {
		return this.memberMapper.memberSearchList(map);
	}

	@Override
	public int getTotalMember(Map<String, Object> map) {
		return this.memberMapper.getTotalMember(map);
	}

	@Override
	public MemberVO memberDetail(MemberVO memberVO) {
		return this.memberMapper.memberDetail(memberVO);
	}

	@Override
	public int memberDelete(int memNo) {
		return this.memberMapper.memberDelete(memNo);
	}

	@Override
	public MemberVO modalDetailInfo(MemberVO memberVO) {
		
		return this.memberMapper.modalDetailInfo(memberVO);
	}
	
	/////// 홈에서 필요한 메소드 시작 ///////
	
	// 핸드폰 중복검사
	@Override
	public MemberVO phoneDuplCheck(String memTelno) {
		return this.memberMapper.phoneDuplCheck(memTelno);
	}

	// 닉네임 중복 검사
	@Override
	public MemberVO nickDuplCheck(String memNicknm) {
		return this.memberMapper.nickDuplCheck(memNicknm);
	}

	// 디엠 리스트
	@Override
	public List<ArtistGroupVO> getDmList(Map<String, Object> dmMap) {
		return this.memberMapper.getArtistGroupList(dmMap);
	}

	// 새로운 아티스트 그룹 리스트
	@Override
	public List<ArtistGroupVO> getNewArtistGroupList(Map<String, Object> unMemMap) {
		return this.memberMapper.getArtistGroupList(unMemMap);
	}

	// 커뮤니티에 가입한 아티스트 그룹 리스트
	@Override
	public List<ArtistGroupVO> getJoinArtistGroupList(Map<String, Object> joinMap) {
		return this.memberMapper.getArtistGroupList(joinMap);
	}

	// 가입한 아티스트 그룹의 굿즈 정보 리스트
	@Override
	public List<GoodsVO> getGoodsVOList(Map<String, Object> goodsMap) {
		return this.memberMapper.getGoodsList(goodsMap);
	}

	// 가입한 아티스트 그룹 중 굿즈가 있는 아티스트 그룹
	@Override
	public List<ArtistGroupVO> getArtWithGoods(int memNo) {
		return this.memberMapper.getArtWithGoods(memNo);
	}

	// 사용자 정보 수정
	@Transactional
	@Override
	public int editInfo(Map<String, Object> map) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
		
		if(map.get("memPswd") != null) { // 비밀번호일 경우에는 암호화
			String memPswd = (String) map.get("memPswd");
			memPswd = this.bCryptPasswordEncoder.encode(memPswd);
			map.put("memPswd", memPswd);
			log.info("암호화 확인 : " +  map.get("memPswd"));
		}
		
		int result = this.memberMapper.editInfo(map);
		
		if(result > 0 ) { // 수정 성공했을 시 UserVO에 변경된 정보를 다시 set한다.
			
			if(map.get("memNicknm") != null) {
				String memNicknm = (String) map.get("memNicknm");
				customUser.getUsersVO().getMemberVO().setMemNicknm(memNicknm);
			}
			if(map.get("memTelno") != null) {
				String memTelno = (String) map.get("memTelno");
				customUser.getUsersVO().getMemberVO().setMemTelno(memTelno);
			}
			if(map.get("memLastName") != null && map.get("memFirstName") != null) {
				String memLastName = (String) map.get("memLastName");
				String memFirstName = (String) map.get("memFirstName");
				customUser.getUsersVO().getMemberVO().setMemLastName(memLastName);
				customUser.getUsersVO().getMemberVO().setMemFirstName(memFirstName);
			}
			
			if(map.get("memPswd") != null) { // 비밀번호일 경우에는 암호화
				String memPswd = (String) map.get("memPswd");
				customUser.getUsersVO().getMemberVO().setMemPswd(memPswd);
			}
		}
		
		return result;
	}

	/////// 홈에서 필요한 메소드 끝 ///////
}
