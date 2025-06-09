package com.ohot.admin.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.admin.mapper.AdminGoodsMapper;
import com.ohot.admin.service.AdminGoodsService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.TicketVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminGoodsServiceImpl implements AdminGoodsService {
   
   @Autowired
   AdminGoodsMapper adminGoodsMapper;
   
   @Autowired
   UploadController uploadController;
   

   @Override
   public int ticketInsert(GoodsVO goodsVO, MultipartFile[] uploadFiles) {

      //파일있을때
      boolean hasRealFile = uploadFiles != null &&
                Arrays.stream(uploadFiles).anyMatch(file -> !file.isEmpty());
      
      if(hasRealFile) {
         long fileGroupNo=this.uploadController.multiImageUpload(uploadFiles);
         goodsVO.setFileGroupNo(fileGroupNo);
         this.adminGoodsMapper.goodsInsert(goodsVO);
      }else {
         this.adminGoodsMapper.goodsInsert(goodsVO);
      }
      
      log.info("-------------"+goodsVO);
      
      TicketVO ticketVO = goodsVO.getTicketVO();
        ticketVO.setGdsNo(goodsVO.getGdsNo());  // 외래키 설정
        ticketVO.setTkVprice(goodsVO.getUnitPrice()); // 굿즈 대표값이랑 티켓 전석값 부여
        this.adminGoodsMapper.ticketInsert(ticketVO);  // Ticket INSERT
      
      return ticketVO.getGdsNo();
   }

   @Override
   public List<GoodsVO> ticketList() {
      // TODO Auto-generated method stub
      return this.adminGoodsMapper.ticketList();
   }


   @Override
   public FileDetailVO ticketPoster(MultipartFile[] uploadFile) {
      MultipartFile[] multipartFiles = uploadFile;

      long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);

      return this.adminGoodsMapper.ticketPosterImg(fileGroupNo);

   }

   @Override
   public int tkDetailInsert(TkDetailVO tkDetailVO) {
      return this.adminGoodsMapper.tkDetailInsert(tkDetailVO);
   }

   @Override
   public GoodsVO ticketDetail(int gdsNo) {
      // TODO Auto-generated method stub
      return this.adminGoodsMapper.ticketDetail(gdsNo);
   }


   @Override
   @Transactional
   public int ticketUpdate(GoodsVO goodsVO, MultipartFile[] uploadFiles) {
      int result=0;
      
      boolean hasRealFile = uploadFiles != null &&
                Arrays.stream(uploadFiles).anyMatch(file -> !file.isEmpty());

      
      //파일 있을때
      if(hasRealFile) {
         long fileGroupNo=this.uploadController.multiImageUpload(uploadFiles);
         goodsVO.setFileGroupNo(fileGroupNo);
         result=this.adminGoodsMapper.ticketUpdateGds(goodsVO);
      } else {
         result=this.adminGoodsMapper.ticketUpdateGds(goodsVO);
      }
      
      result+= this.adminGoodsMapper.ticketUpdateTk(goodsVO.getTicketVO());
      
      log.info("ticketUpdate->result"+result);
      
//      for (TkDetailVO tkDetailVO : goodsVO.getTicketVO().getTkDetailVOList()) {
//         this.adminGoodsMapper.ticketUpdateTkDe(tkDetailVO);
//         
//         return result+1;
//      }
      
      
      return result;
   }

   @Override
   public int ticketDelete(int gdsNo) {
      // TODO Auto-generated method stub
      return this.adminGoodsMapper.ticketDelete(gdsNo);
   }

   @Override
   public List<GoodsVO> tkListSearchPost(Map<String, Object> data) {
      // TODO Auto-generated method stub
      return this.adminGoodsMapper.tkListSearchPost(data);
   }

   @Override
   public int tkListCount(Map<String, Object> data) {
      // TODO Auto-generated method stub
      return this.adminGoodsMapper.tkListCount(data);
   }

   @Override
   public List<ArtistGroupVO> goodsListSearchPost(Map<String, Object> data) {
	return adminGoodsMapper.goodsListSearchPost(data);
   }
   
   
   //굿즈 상품 등록
   @Override
   public int goodsInsert(GoodsVO goodsVO, MultipartFile[] uploadFiles) {
       
	   //파일있을때
	   boolean hasRealFile = uploadFiles != null && Arrays.stream(uploadFiles).anyMatch(file -> !file.isEmpty());
	   
	   if(hasRealFile) {
		   long fileGroupNo=this.uploadController.multiImageUpload(uploadFiles);
	       goodsVO.setFileGroupNo(fileGroupNo);
	   }
	   
	   return this.adminGoodsMapper.goodsInsert(goodsVO);
   }

   @Override
   public GoodsVO goodsDetail(int gdsNo) {
	   return adminGoodsMapper.goodsDetail(gdsNo);
   }
   
   @Override
   public int goodsUpdate(GoodsVO goodsVO) {
	   return adminGoodsMapper.goodsUpdate(goodsVO);
   }

   @Transactional
   @Override
   public int fileSnChange(List<FileDetailVO> fileDetailVOList) {
	   //fileGroupNo를 조회하여 해당 fileGroupNo의 FILE_SN Max 값을 가져와 file_SN을 기존값+MAX값으로 변경
	   int result;
	   
	   result = adminGoodsMapper.fileSnUpdate(fileDetailVOList.get(0).getFileGroupNo());
	 		
	   //fileGroupSn Update
	   result += adminGoodsMapper.fileDetailSnUpdate(fileDetailVOList);
	   
	   return result;
   }

   @Override
   public GoodsVO getMaxGdsNo() {
	   return adminGoodsMapper.getMaxGdsNo();
   }
}
