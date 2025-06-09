package com.ohot.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.StatsVO;

@Mapper
public interface StatsMapper {



	public List<StatsVO> statsList(StatsVO statsVO);

	public List<StatsVO> listBarAjax(StatsVO statsVO);

	public StatsVO listdoughnutAjax(StatsVO statsVO);

	public List<StatsVO> SubscriptionTotal(StatsVO statsVO);

	public List<StatsVO> memberTotal(StatsVO statsVO);

	public List<StatsVO> FollowersTotal(StatsVO statsVO);
	
	public List<StatsVO> goodTotal(StatsVO statsVO);

	public List<StatsVO> volume(StatsVO statsVO);

	public int pazing(Map<String, Object> map);

	public List<StatsVO> listMemberAjax(StatsVO statsVO);

	public List<StatsVO> communityMember(StatsVO statsVO);

	public List<StatsVO> goodcnt(StatsVO statsVO);

	public List<StatsVO> goodNm(StatsVO statsVO);

	public List<StatsVO> editPost(StatsVO statsVO);

	public List<StatsVO> listdoughnutAjax2(StatsVO statsVO);

	public List<StatsVO> goodsStatistics(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public List<StatsVO> topList(StatsVO statsVO);

	public List<StatsVO> GoodsStatisticsAjax(StatsVO statsVO);

	//판매수량
	public List<StatsVO> salesVolume(StatsVO statsVO);

	//총매출
	public List<StatsVO> totalSales(StatsVO statsVO);

	//예매총매출
	public List<StatsVO> reservationTotalSales(StatsVO statsVO);

	//콘서트매출
	public List<StatsVO> concertSales(StatsVO statsVO);

	//팬미팅매출
	public List<StatsVO> fanSales(StatsVO statsVO);

	public List<StatsVO> restSales(StatsVO statsVO);

	//신고토탈
	public List<StatsVO> reportTotal(StatsVO statsVO);

	//굿즈통계 그래프
	public List<StatsVO> subscriptionList(StatsVO statsVO);

	//연령별 그래프
	public List<StatsVO> subscriptionList2(StatsVO statsVO);
	
	//커뮤니티 통계 총매풀
	public List<StatsVO> subscriptionTotalSales(StatsVO statsVO);

	public String getTotalSalesByPeriod(Map<String, Object> map);
	
	/*커뮤니티통계 통계 -> 2) 티켓예매 매출(*)
	총매출, 콘서트, 팬미팅, 기타 매출 
	StatsVO(..startDate=2025-04-01, endDate=2025-05-31,..., startRow=1, endRow=10)
	<select id="subscriptionStatList" parameterType="com.ohot.vo.StatsVO" resultType="hashMap">
	*/
	public List<Map<String,Object>> subscriptionStatList(StatsVO statsVO);

}
