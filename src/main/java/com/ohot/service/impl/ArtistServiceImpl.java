package com.ohot.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.home.community.mapper.CommunityMapper;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.mapper.ArtistMapper;
import com.ohot.service.ArtistService;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class ArtistServiceImpl implements ArtistService {
	
	@Autowired
	ArtistMapper artistMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	CommunityMapper communityMapper;
	

	@Override
	public List<ArtistVO> artistList() {
		return this.artistMapper.artistList();
	}

	@Override
	public ArtistVO artistDetail(ArtistVO artistVO) {
		
		return this.artistMapper.artistDetail(artistVO);
	}

	@Override
	public int artistInsert(ArtistVO artistVO) {
		
		MultipartFile[] multipartFiles = artistVO.getUploadFile();
		
		if(multipartFiles[0]!=null && multipartFiles[0].getOriginalFilename().length()>0) {
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
			artistVO.setFileGroupNo(fileGroupNo);
		}
		
		return this.artistMapper.artistInsert(artistVO);
	}

	@Override
	public int artistUpdate(ArtistVO artistVO) {

		MultipartFile[] multipartFiles = artistVO.getUploadFile();
		
		// 파일 등록하지 않고 등록한 경우에 대한 수정 시
		if(artistVO.getFileGroupNo()==0) {
			
			if(multipartFiles[0]!=null && multipartFiles[0].getOriginalFilename().length()>0) {
				long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
				artistVO.setFileGroupNo(fileGroupNo);
			}
		}else {	// 파일 등록 했는데 글 변경시 파일에 대한 작업이 있을 때
			
			if(multipartFiles[0]!=null && multipartFiles[0].getOriginalFilename().length()>0) {
				long fileGroupNo = artistVO.getFileGroupNo();
				this.uploadController.multiImageUploadTOFileDetail(fileGroupNo, multipartFiles);
				artistVO.setFileGroupNo(fileGroupNo);
			}
		}
		
		return 0;
	}

	@Override
	public int artistDelete(ArtistVO artistVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getTotalArtist(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.artistMapper.getTotalArtist(map);
	}

	@Override
	public List<ArtistVO> artistSearchList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.artistMapper.artistSearchList(map);
	}

	@Override
	public List<ArtistVO> searchArtists(String keyword) {
		return this.artistMapper.searchArtists(keyword);
	}

	/*
	 * @Override public int updateArtistGroup(int artNo, int artGroupNo) {
	 * 
	 * 
	 * 
	 * }
	 */

	/*
	 * @Override public int removeArtistGroup(int artNo) { return
	 * this.artistMapper.removeArtistGroup(artNo); }
	 */

	@Override
	public int updateArtistGroup(ArtistVO artistVO) {
		/*
		 * ArtistVO(rnum=0, artNo=8, artGroupNo=16, artActNm=영신2, artExpln=테스트입니다2,
		 * artRegYmd=null, fileGroupNo=20250403016, memNo=13, artDelYn=null,
		 * memVO=MemberVO(rnum=0, memNo=13, memLastName=김, memFirstName=영신,
		 * memNicknm=null, memEmail=null, memTelno=null, memBirth=null, memPswd=null,
		 * joinYmd=null, secsnYmd=null, memAccessToken=null, enabled=0,
		 * memStatSecCodeNo=null, memSecCodeNo=null, memDelYn=null, fullName=null,
		 * snsMemYn=null, authNm=null, authVOList=null, artistVO=null),
		 * fileGroupVO=FileGroupVO(fileGroupNo=20250403016, fileRegdate=Thu Apr 03
		 * 17:39:25 KST 2025, fileDetailVOList=[FileDetailVO(fileSn=2,
		 * fileGroupNo=20250403016 , fileOriginalName=쇼타로.jpeg,
		 * fileSaveName=e8272b26-f056-419a-ad8a-e9f898e29696_쇼타로.jpeg ,
		 * fileSaveLocate=/2025/04/03/e8272b26-f056-419a-ad8a-e9f898e29696_쇼타로.jpeg,
		 * fileSize=7795 , fileExt=jpeg, fileMime=image/jpeg, fileFancysize=null,
		 * fileSaveDate=Thu Apr 03 20:59:45 KST 2025 , fileDowncount=0)]),
		 * uploadFile=null)
		 */
		
		// 아티스트 & 커뮤니티 조인해서 정보를 통해 커뮤니티 번호 존재시 artGoupNo 업데이트 해주는 로직 필요
		// 안그럼 그냥 x버튼 안누르고 그냥 아티스트 등록시 커뮤니티프로필번호 여러개 생성됨
		// 지금은 그냥 가입해주는 것만 존재
			
		CommunityProfileVO communityProfileVO = new CommunityProfileVO();
		communityProfileVO.setMemNo(artistVO.getMemNo());
		communityProfileVO.setComNm(artistVO.getArtActNm());
		communityProfileVO.setFileGroupNo(artistVO.getFileGroupNo());
		communityProfileVO.setArtGroupNo(artistVO.getArtGroupNo());
	
		int result = this.communityMapper.artJoinCommunity(communityProfileVO);
		log.info("updateArtistGroup=>communityProfileVO result : ", result);
		
		return this.artistMapper.updateArtistGroup(artistVO);
	}

	@Override
	public int removeArtistGroup(ArtistVO artistVO) {
		
		int result = this.communityMapper.deleteArtCommunity(artistVO);
		
		return this.artistMapper.removeArtistGroup(artistVO);
	}


}
