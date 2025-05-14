package com.ohot.home.alarm.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.home.alarm.mapper.AlarmMapper;
import com.ohot.home.alarm.service.AlarmService;
import com.ohot.home.alarm.vo.NotiStngVO;
import com.ohot.home.alarm.vo.NotificationVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.vo.ArtistGroupVO;

@Service
public class AlarmServiceImpl implements AlarmService{

	@Autowired
	AlarmMapper alarmMapper;
	
	@Override
	public List<ArtistGroupVO> registeredGroupList(int memNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.registeredGroupList(memNo);
	}

	@Override
	public List<NotificationVO> alarmDetailList(int memNo, int artGroupNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.alarmDetailList(memNo, artGroupNo);
	}

	@Override
	public NotiStngVO personalStng(int comProfileNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.personalStng(comProfileNo);
	}

	@Override
	public int savePersonalStng(NotiStngVO notiStngVO) {
		// TODO Auto-generated method stub
		return this.alarmMapper.savePersonalStng(notiStngVO);
	}


	@Override
	public List<NotificationVO> forRealTimeAlarm(NotificationVO notificationVO) {
		// TODO Auto-generated method stub
		return this.alarmMapper.forRealTimeAlarm(notificationVO);
	}

	@Override
	public int updateReadEnum(int memNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.updateReadEnum(memNo);
	}

	@Override
	public int checkEnum(int memNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.checkEnum(memNo);
	}

	@Override
	public List<NotificationVO> empDetailList(long memNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.empDetailList(memNo);
	}

	@Override
	public int empCheckEnum(long empNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.empCheckEnum(empNo);
	}

	@Override
	public int empReadEnum(long empNo) {
		// TODO Auto-generated method stub
		return this.alarmMapper.empReadEnum(empNo);
	}

}
