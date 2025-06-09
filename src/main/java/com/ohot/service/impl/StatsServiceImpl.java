package com.ohot.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.mapper.StatsMapper;
import com.ohot.service.StatsService;
import com.ohot.util.UploadController;
import com.ohot.vo.StatsVO;

@Service
public class StatsServiceImpl implements StatsService{

	@Autowired
	StatsMapper statsMapper;

	@Autowired
	UploadController uploadController;


	@Override
	public List<StatsVO> statsList(StatsVO statsVO) {
		return this.statsMapper.statsList(statsVO);
	}

	@Override
	public List<StatsVO> listBarAjax(StatsVO statsVO) {
		return this.statsMapper.listBarAjax(statsVO);
	}

	@Override
	public StatsVO listdoughnutAjax(StatsVO statsVO) {
		return this.statsMapper.listdoughnutAjax(statsVO);
	}

	@Override
	public List<StatsVO> SubscriptionTotal(StatsVO statsVO) {
		return this.statsMapper.SubscriptionTotal(statsVO);
	}

	@Override
	public List<StatsVO> memberTotal(StatsVO statsVO) {
		return this.statsMapper.memberTotal(statsVO);
	}

	@Override
	public List<StatsVO> FollowersTotal(StatsVO statsVO) {
		return this.statsMapper.FollowersTotal(statsVO);
	}

	@Override
	public List<StatsVO> goodTotal(StatsVO statsVO) {
		return  this.statsMapper.goodTotal(statsVO);
	}

	@Override
	public List<StatsVO> volume(StatsVO statsVO) {
		return this.statsMapper.volume(statsVO);
	}

	@Override
	public int pazing(Map<String, Object> map) {
		return this.statsMapper.pazing(map);
	}

	@Override
	public List<StatsVO> listMemberAjax(StatsVO statsVO) {
		return this.statsMapper.listMemberAjax(statsVO);
	}

	@Override
	public List<StatsVO> communityMember(StatsVO statsVO) {
		return this.statsMapper.communityMember(statsVO);
	}

	@Override
	public List<StatsVO> goodcnt(StatsVO statsVO) {
		return this.statsMapper.goodcnt(statsVO);
	}

	@Override
	public List<StatsVO> goodNm(StatsVO statsVO) {
		return this.statsMapper.goodNm(statsVO);
	}

	//아이돌 사진 top5
	@Override
	public List<StatsVO> editPost(StatsVO statsVO) {
		
		MultipartFile[] multipartFile = statsVO.getUploadFile();
	
		if (multipartFile != null && multipartFile.length > 0) {
			long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
			statsVO.setFileGroupNo(fileGroupNo);
			
			
		}
		return this.statsMapper.editPost(statsVO);
	}

	@Override
	public List<StatsVO> listdoughnutAjax2(StatsVO statsVO) {
		return this.statsMapper.listdoughnutAjax2(statsVO);
	}

	@Override
	public List<StatsVO> goodsStatistics(Map<String, Object> map) {
		return this.statsMapper.goodsStatistics(map);
	}

	//페이징 밑 검색
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.statsMapper.getTotal(map);
	}

	@Override
	public List<StatsVO> topList(StatsVO statsVO) {
		return this.statsMapper.topList(statsVO);
	}

	@Override
	public List<StatsVO> GoodsStatisticsAjax(StatsVO statsVO) {
		return this.statsMapper.GoodsStatisticsAjax(statsVO);
	}

	//판매수량
	@Override
	public List<StatsVO> salesVolume(StatsVO statsVO) {
		return this.statsMapper.salesVolume(statsVO);
	}

	@Override
	public List<StatsVO> totalSales(StatsVO statsVO) {
		return this.statsMapper.totalSales(statsVO);
	}

	//예매총매출
	@Override
	public List<StatsVO> reservationTotalSales(StatsVO statsVO) {
		return this.statsMapper.reservationTotalSales(statsVO);
	}

	//콘서트매출
	@Override
	public List<StatsVO> concertSales(StatsVO statsVO) {
		return this.statsMapper.concertSales(statsVO);
	}

	//
	@Override
	public List<StatsVO> fanSales(StatsVO statsVO) {
		return this.statsMapper.fanSales(statsVO);
	}

	//
	@Override
	public List<StatsVO> restSales(StatsVO statsVO) {
		return this.statsMapper.restSales(statsVO);
	}

	//신고토탈
	@Override
	public List<StatsVO> reportTotal(StatsVO statsVO) {
		return this.statsMapper.reportTotal(statsVO);
	}

	//커뮤니티통계 통계 -> 1) 굿즈, 티켓 통계
	@Override
	public List<StatsVO> subscriptionList(StatsVO statsVO) {
		return this.statsMapper.subscriptionList(statsVO);
	}
	
	/*커뮤니티통계 통계 -> 2) 티켓예매 매출(*)
	총매출, 콘서트, 팬미팅, 기타 매출 
	StatsVO(..startDate=2025-04-01, endDate=2025-05-31,...,gubun=GD02, startRow=1, endRow=10)
	<select id="subscriptionStatList" parameterType="com.ohot.vo.StatsVO" resultType="hashMap">
	*/
	@Override
	public List<Map<String,Object>> subscriptionStatList(StatsVO statsVO){
		return this.statsMapper.subscriptionStatList(statsVO);
	}

	//연령별 그래프
	@Override
	public List<StatsVO> subscriptionList2(StatsVO statsVO) {
		return this.statsMapper.subscriptionList2(statsVO);
	}

	@Override
	public List<StatsVO> subscriptionTotalSales(StatsVO statsVO) {
		return this.statsMapper.subscriptionTotalSales(statsVO);
	}

	@Override
	public String getTotalSalesByPeriod(String startDate, String endDate, int startRow, int endRow) {
		 Map<String, Object> map = new HashMap<>();
		    map.put("startDate", startDate);
		    map.put("endDate", endDate);
		    map.put("startRow", startRow);
		    map.put("endRow", endRow);
		return this.statsMapper.getTotalSalesByPeriod(map);
	}

	
	
	
}
