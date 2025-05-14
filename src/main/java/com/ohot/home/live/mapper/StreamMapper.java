package com.ohot.home.live.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.live.vo.StreamVO;

@Mapper
public interface StreamMapper {

	public int createStream(StreamVO streamVO);
	
	// 방송 정보 조회
	public StreamVO getStream(int streamNo);
	
	public int updateStream(StreamVO streamVO);
	
	public StreamVO getStreamByArtGroupNo(int artGroupNo);
    // 방송 목록
    List<StreamVO> getStreamList(StreamVO streamVO);
    
    //회원 멤버쉽 여부 체크
    public String membershipCheck(int comProfileNo);
}
