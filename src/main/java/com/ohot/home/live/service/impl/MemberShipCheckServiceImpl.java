package com.ohot.home.live.service.impl;

import org.springframework.stereotype.Service;

import com.ohot.home.live.mapper.StreamMapper;
import com.ohot.home.live.service.MemberShipCheckService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberShipCheckServiceImpl implements MemberShipCheckService {
	
	private final StreamMapper streamMapper;
	// 멤버쉽 체크
	public String memberShipCheck(int comProfileNo) {
		// TODO Auto-generated method stub
		return streamMapper.membershipCheck(comProfileNo);
	}

}
