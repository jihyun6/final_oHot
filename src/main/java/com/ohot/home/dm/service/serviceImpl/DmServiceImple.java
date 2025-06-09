package com.ohot.home.dm.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.home.dm.mapper.DmMapper;
import com.ohot.home.dm.service.DmService;
import com.ohot.home.dm.vo.DmMsgVO;
import com.ohot.home.dm.vo.DmSubVO;
import com.ohot.vo.ArtistGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DmServiceImple implements DmService{

	@Autowired
	DmMapper dmMapper;
	
	@Override
	public List<ArtistGroupVO> artGroupList(int memNo) {
		// TODO Auto-generated method stub
		return this.dmMapper.artGroupList(memNo);
	}

	@Override
	public List<ArtistGroupVO> myArtistList(int memNo) {
		// TODO Auto-generated method stub
		return this.dmMapper.myArtistList(memNo);
	}

	@Override
	public List<DmSubVO> checkPurchaseDm(DmSubVO dmSubVO) {
		// TODO Auto-generated method stub
		return this.dmMapper.checkPurchaseDm(dmSubVO);
	}

	@Override
	public void resetExpiredDms() {

		int count = dmMapper.resetExpiredDms();
		log.debug("만료된 dm구독권 수: "+count);
	}

	@Override
	public int saveMsg(DmMsgVO dmMsgVO) {
		// TODO Auto-generated method stub
		return this.dmMapper.saveMsg(dmMsgVO);
	}

	@Override
	public List<DmSubVO> myFanList(int artNo) {
		// TODO Auto-generated method stub
		return this.dmMapper.myFanList(artNo);
	}

	@Override
	public List<DmMsgVO> lastChat(DmMsgVO dmMsgVO) {
		// TODO Auto-generated method stub
		return this.dmMapper.lastChat(dmMsgVO);
	}

	@Override
	public List<DmMsgVO> lastChatForArt(DmMsgVO dmMsgVO) {
		// TODO Auto-generated method stub
		return this.dmMapper.lastChatForArt(dmMsgVO);
	}

	@Override
	public List<ArtistGroupVO> dmsearchFilter(int artGroupNo ,String dmSrhKeyword) {
		// TODO Auto-generated method stub
		return this.dmMapper.dmsearchFilter( artGroupNo, dmSrhKeyword);
	}

	@Override
	public int updateReadY(long dmSubNo) {
		// TODO Auto-generated method stub
		return this.dmMapper.updateReadY(dmSubNo);
	}

}
