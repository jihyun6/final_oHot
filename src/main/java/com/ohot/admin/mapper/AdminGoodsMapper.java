package com.ohot.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.TicketVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;

@Mapper
public interface AdminGoodsMapper {

	public int goodsInsert(GoodsVO goodsVO);
	
	public int ticketInsert(TicketVO ticketVO);

	public List<GoodsVO> ticketList();

	public FileDetailVO ticketPosterImg(long fileGroupNo);

	//<insert 태그 내의 insert SQL을 실행하면  mybatis 프레이뭐크에서는 int 타입으로 리턴
	// 몇 행이 insert되었는지 리턴
	public int tkDetailInsert(TkDetailVO tkDetailVO);

	public GoodsVO ticketDetail(int gdsNo);

	public int ticketUpdateGds(GoodsVO goodsVO);

	public int ticketUpdateTk(TicketVO ticketVO);

	public int ticketUpdateTkDe(TkDetailVO tkDetailVO);

	public int ticketDelete(int gdsNo);

	public List<GoodsVO> tkListSearchPost(Map<String, Object> data);

	public int tkListCount(Map<String, Object> data);

	public List<ArtistGroupVO> goodsListSearchPost(Map<String, Object> data);

	public GoodsVO goodsDetail(int gdsNo);

	public int goodsUpdate(GoodsVO goodsVO);

	public int fileSnUpdate(long fileGroupNo);

	public int fileDetailSnUpdate(List<FileDetailVO> fileDetailVOList);

	public GoodsVO getMaxGdsNo();


}
