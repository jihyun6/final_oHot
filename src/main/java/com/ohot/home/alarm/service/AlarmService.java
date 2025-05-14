package com.ohot.home.alarm.service;

import java.util.List;

import com.ohot.home.alarm.vo.NotiStngVO;
import com.ohot.home.alarm.vo.NotificationVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.vo.ArtistGroupVO;

public interface AlarmService {

	public List<ArtistGroupVO> registeredGroupList(int memNo);

	public List<NotificationVO> alarmDetailList(int memNo, int artGroupNo);

	public NotiStngVO personalStng(int comProfileNo);

	public int savePersonalStng(NotiStngVO notiStngVO);


	public List<NotificationVO> forRealTimeAlarm(NotificationVO notificationVO);

	public int updateReadEnum(int memNo);

	public int checkEnum(int memNo);

	public List<NotificationVO> empDetailList(long memNo);

	public int empCheckEnum(long empNo);

	public int empReadEnum(long empNo);

}
