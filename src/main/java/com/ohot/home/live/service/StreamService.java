package com.ohot.home.live.service;

import java.util.List;

import com.ohot.home.live.vo.StreamVO;

public interface StreamService {
	
	public int createStream(StreamVO streamVO);
 
	public StreamVO getStream(int streamNo);
	 
	public List<StreamVO> getStreamList(StreamVO streamVO);
	 
	public StreamVO getStreamByArtGroupNo(int artGroupNo);
	
	public int updateStreamStat(StreamVO streamVO);

}
