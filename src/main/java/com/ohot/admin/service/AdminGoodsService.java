package com.ohot.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;

public interface AdminGoodsService {

	public int ticketInsert(GoodsVO goodsVO , MultipartFile[] uploadFiles);

	public List<GoodsVO> ticketList();

	public FileDetailVO ticketPoster(MultipartFile[] uploadFile);

	public int tkDetailInsert(TkDetailVO tkDetailVO);

	public GoodsVO ticketDetail(int gdsNo);

	public int ticketUpdate(GoodsVO goodsVO, MultipartFile[] uploadFiles);

	public int ticketDelete(int gdsNo);

	public List<GoodsVO> tkListSearchPost(Map<String, Object> data);

	public int tkListCount(Map<String, Object> data);

	public List<ArtistGroupVO> goodsListSearchPost(Map<String, Object> data);

	public int goodsInsert(GoodsVO goodsVO, MultipartFile[] uploadFiles);

	public GoodsVO goodsDetail(int gdsNo);

	public int fileSnChange(List<FileDetailVO> fileDetailVOList);

	public int goodsUpdate(GoodsVO goodsVO);

	public GoodsVO getMaxGdsNo();

}
