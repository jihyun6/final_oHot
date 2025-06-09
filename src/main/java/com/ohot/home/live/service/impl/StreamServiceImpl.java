package com.ohot.home.live.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ohot.home.live.mapper.StreamMapper;
import com.ohot.home.live.service.StreamService;
import com.ohot.home.live.vo.StreamVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor //final 키워드 사용시 최신 스프링 권장
public class StreamServiceImpl implements StreamService {

		private final StreamMapper streamMapper;

		@Override
		public int createStream(StreamVO streamVO) {
			log.debug("createStream: {}", streamVO);
	        return streamMapper.createStream(streamVO);
		}

		@Override
		public StreamVO getStream(int streamNo) {
			 log.debug("getStream: streamNo={}", streamNo);
		     return streamMapper.getStream(streamNo);
		}

		@Override
		public List<StreamVO> getStreamList(StreamVO streamVO) {
			log.debug("getStreamList: {}", streamVO);
	        return streamMapper.getStreamList(streamVO);
		}

		@Override
		public StreamVO getStreamByArtGroupNo(int artGroupNo) {
	        
	        StreamVO streamVO = streamMapper.getStreamByArtGroupNo(artGroupNo);
	        log.debug("getSreamByArtGroupNo->streamVO: {}", streamVO);
	        
	        return streamVO;
	    }

		@Override
		public int updateStreamStat(StreamVO streamVO) {
			log.debug("updateStreamStat: {}", streamVO);
	        return streamMapper.updateStream(streamVO);
		}

}
