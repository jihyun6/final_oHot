package com.ohot.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.mapper.ArtistGroupMapper;
import com.ohot.mapper.FileGroupMapper;
import com.ohot.service.ArtistGroupService;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ArtistGroupServiceImpl implements ArtistGroupService {

	@Autowired
	ArtistGroupMapper artistGroupMapper;
	
	@Autowired
	UploadController uploadController;

	
	@Override
	public List<ArtistGroupVO> artistGroupList(Map<String, Object> map) {
		return this.artistGroupMapper.artistGroupList(map);
	}

	@Override
	public ArtistGroupVO artistGroupDetail(ArtistGroupVO artistGroupVO) {
		return this.artistGroupMapper.artistGroupDetail(artistGroupVO);
	}

	@Override
	public int artistGroupInsert(ArtistGroupVO artistGroupVO) {
		
		artistGroupVO.setArtGroupDebutYmd(artistGroupVO.getArtGroupDebutYmd().replaceAll("-", ""));
		
		MultipartFile[] multipartFiles = artistGroupVO.getUploadFile();
	
		// 아티스트 등록시 파일 등록할 때
		if(multipartFiles[0] != null && multipartFiles[0].getOriginalFilename().length() > 0) {
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
			artistGroupVO.setFileGroupNo(fileGroupNo);
		}
		
		return this.artistGroupMapper.artistGroupInsert(artistGroupVO);
	}

	@Override
	public int artistGroupUpdate(ArtistGroupVO artistGroupVO) {
		
		artistGroupVO.setArtGroupDebutYmd(artistGroupVO.getArtGroupDebutYmd().replaceAll("-", ""));
		
		MultipartFile[] multipartFiles = artistGroupVO.getUploadFile();
		
		
		
		//파일 등록을 하지 않고 등록한 경우에 대한 수정 시(파일을 새로 등록해야 함)
		if(artistGroupVO.getFileGroupNo()==0) {
			//최초 파일등록(x),파일 선택 안하면 건너뛰어야 함
			if(multipartFiles[0]!=null && multipartFiles[0].getOriginalFilename().length()>0) {
				long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
				artistGroupVO.setFileGroupNo(fileGroupNo);
			}
		}else {//파일 등록을 했는데 글 변경 시 파일에 대한 작업이 있을 때
			//최초 파일등록(o),파일 선택 안하면 건너뛰어야 함
			if(multipartFiles[0]!=null && multipartFiles[0].getOriginalFilename().length()>0) {
				long fileGroupNo = artistGroupVO.getFileGroupNo();
				this.uploadController.multiImageUploadTOFileDetail(fileGroupNo, multipartFiles);
				artistGroupVO.setFileGroupNo(fileGroupNo);
			}
		}
		
		return this.artistGroupMapper.artistGroupUpdate(artistGroupVO);
	}

	@Override
	public int getTotalArtistGroup(Map<String, Object> map) {
		return this.artistGroupMapper.getTotalArtistGroup(map);
	}

	@Override
	public FileDetailVO logoFilePost(MultipartFile[] uploadFileLogo) {
		
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFileLogo);
		
		return this.artistGroupMapper.logoFilePost(fileGroupNo);
	}
	
	// 홈 사용 시작
	
	@Override
	public List<ArtistGroupVO> homeArtistGroupList() {
		return this.artistGroupMapper.homeArtistGroupList();
	}

	@Override
	public List<ArtistVO> getArtistsInGroup(ArtistGroupVO artistGroupVO) {
		return this.artistGroupMapper.getArtistsInGroup(artistGroupVO);
	}

	@Override
	public int artistGroupDelete(int artGroupNo) {
		return this.artistGroupMapper.artistGroupDelete(artGroupNo);
	}

	@Override
	public int artistGroupActive(int artGroupNo) {
		return this.artistGroupMapper.artistGroupActive(artGroupNo);
	}

	

	// 홈 사용 끝

}
