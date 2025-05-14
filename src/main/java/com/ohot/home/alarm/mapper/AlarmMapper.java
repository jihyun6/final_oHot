package com.ohot.home.alarm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohot.home.alarm.vo.NotiStngVO;
import com.ohot.home.alarm.vo.NotificationVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.vo.ArtistGroupVO;

@Mapper
public interface AlarmMapper {

	public List<ArtistGroupVO> registeredGroupList(int memNo) ;

	public List<NotificationVO> alarmDetailList(@Param("memNo") int memNo, @Param("artGroupNo") int artGroupNo);

	public int alarmComPost(CommunityPostVO communityPostVO);

	public int alarmReply(CommunityReplyVO communityReplyVO);

	public NotiStngVO personalStng(int comProfileNo);

	public int savePersonalStng(NotiStngVO notiStngVO);


	public List<NotificationVO> forRealTimeAlarm(NotificationVO notificationVO);

	public int updateReadEnum(int memNo);

	public int checkEnum(int memNo);

	public List<NotificationVO> empDetailList(long memNo);
	
	public int empAlarmInsert(NotificationVO notificationVO);

	public int empCheckEnum(long empNo);

	public int empReadEnum(long empNo);
}
