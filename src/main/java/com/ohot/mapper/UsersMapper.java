package com.ohot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.vo.EmployeeVO;
import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;
import com.ohot.vo.UsersVO;

@Mapper
public interface UsersMapper {
	

	// email로 사용자의 정보 조회
	public UsersVO findByEmail(String userMail);
	
	// email로 memberVO 조회
	public MemberVO findByEmailMember(String userMail);
	
	// email로 관리자 및 직원 정보 조회
	public EmployeeVO findByEmailAdmin(String userMail);
	
	// 만료된 멤버십 리스트 불러오기
	public List<CommunityProfileVO> selectExpMemberShipList(int memNo);
	
	// 만료된 멤버십 N으로 돌리기
	public void expMemberShip(int comProfileNo);
	
	// 신고 유효기간 보기
	public ReportmanageVO getMemStopYN(int memNo);
	
	// 회원 상태 (정지 -> 활동) 업데이트
	public void updateMemStatus(int memNo);
	
}
