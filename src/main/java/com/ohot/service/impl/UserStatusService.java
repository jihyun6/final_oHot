package com.ohot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.mapper.UsersMapper;
import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;
import com.ohot.vo.UsersVO;

@Service
public class UserStatusService {
	
	@Autowired
    private UsersMapper usersMapper;
	
	public void checkAndUpdateMemberStatus(UsersVO usersVO) {
		 MemberVO memVO = usersMapper.findByEmailMember(usersVO.getUserMail());
	        
		if(memVO != null) {
			usersVO.setMemberVO(memVO);
			
			// 탈퇴한 회원 체크
			if(memVO.getMemDelYn().equals("Y")) {
				throw new UsernameNotFoundException("DELETED_MEMBER");
			}
			
			int memNo = (int)usersVO.getUserNo();
			
			// 활동정지된 회원 체크
			if(usersVO.getMemberVO().getMemStatSecCodeNo().equals("004")) { // 004 = 활동정지
				// 활동정지 종료일 여부 체크
				ReportmanageVO reportVO = this.usersMapper.getMemStopYN(memNo);
				if(reportVO != null) { // 종료일이 지나지 않았을 경우
					throw new UsernameNotFoundException("STOP_MEMBER, EndDate=" + reportVO.getReportEndDt());
				}else { // 종료일이 지났을 경우
					// 회원 상태 업데이트 (정지->활동)
					this.usersMapper.updateMemStatus(memNo);
				}
			}
			
			// 멤버십 유효기간이 지난 커뮤니티 체크
			List<CommunityProfileVO> communityProfileVOList = this.usersMapper.selectExpMemberShipList(memNo);
			
			if(!communityProfileVOList.isEmpty()) {
				// 유효기간이 지난 커뮤니티 리스트
				for(CommunityProfileVO communityProfileVO : communityProfileVOList) {
					int comProfileNo = communityProfileVO.getComProfileNo();
					// 커뮤니티 멤버십 해제
					this.usersMapper.expMemberShip(comProfileNo);
				}
			}
			
		}
	}
}
