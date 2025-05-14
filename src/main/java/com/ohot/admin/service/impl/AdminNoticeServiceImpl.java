package com.ohot.admin.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.admin.mapper.AdminNoticeMapper;
import com.ohot.admin.service.AdminNoticeService;
import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminNoticeServiceImpl implements AdminNoticeService{
	
	@Autowired
	AdminNoticeMapper adminNoticeMapper;
	
	@Autowired
	UploadController uploadController;

	@Override
	public List<ArtistGroupNoticeVO> artGroupNoticeList(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return this.adminNoticeMapper.artGroupNoticeList(data);
	}

	@Override
	public int getTotal(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return this.adminNoticeMapper.getTotal(data);
	}

	@Override
	public List<ArtistGroupVO> artGroupList() {
		// TODO Auto-generated method stub
		return this.adminNoticeMapper.artGroupList();
	}

	@Override
	public String getArtNm(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.adminNoticeMapper.getArtNm(artGroupNo);
	}

	@Override
	public ArtistGroupNoticeVO detailNotice(int bbsPostNo) {
		// TODO Auto-generated method stub
		return this.adminNoticeMapper.detailNotice(bbsPostNo);
	}

	@Override
	public int editNotice(ArtistGroupNoticeVO aritistGroupNoticeVO) {
		
		//파일 그룹 넘버 받고 셋해서 보내서 업데이트
		MultipartFile[] uploadFile = aritistGroupNoticeVO.getUploadFile();
		log.info("addBoard -> communityPostVO : " + aritistGroupNoticeVO);
		long fileGroupNo=0L;
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//FILE_GROUP 및 FILE_DETAIL 테이블에 INSERT
			//동일한 파일 그룹 넘버의 디테일에 새로운 파일 SN 추가
			log.info("addBoard -> communityPostVO : " + aritistGroupNoticeVO);
				fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
				aritistGroupNoticeVO.setFileGroupNo(fileGroupNo);
			
		}
		
		return this.adminNoticeMapper.editNotice(aritistGroupNoticeVO);
	}

	@Override
	public void deleteNotice(int bbsPostNo) {
		
		this.adminNoticeMapper.deleteNotice(bbsPostNo);
	}

	@Override
	public void unDeleteNotice(int bbsPostNo) {

		this.adminNoticeMapper.unDeleteNotice(bbsPostNo);
		
	}

	@Override
	public int addNotice(ArtistGroupNoticeVO artistGroupNoticeVO) {
		//파일 그룹 넘버 받고 셋해서 보내서 업데이트
		log.info("addNotice->artGroupNo : "+artistGroupNoticeVO.getArtGroupNo());
		MultipartFile[] uploadFile = artistGroupNoticeVO.getUploadFile();
		log.info("addBoard -> communityPostVO : " + artistGroupNoticeVO);
		long fileGroupNo=0L;
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//FILE_GROUP 및 FILE_DETAIL 테이블에 INSERT
			//동일한 파일 그룹 넘버의 디테일에 새로운 파일 SN 추가
			log.info("addBoard -> communityPostVO : " + artistGroupNoticeVO);
				fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
				artistGroupNoticeVO.setFileGroupNo(fileGroupNo);
			
		}
		this.adminNoticeMapper.addNotice(artistGroupNoticeVO);
		int bbsPostNo= this.adminNoticeMapper.getNo();
		log.info("bbsPostNo::::"+bbsPostNo);
		return bbsPostNo;
	}

}
