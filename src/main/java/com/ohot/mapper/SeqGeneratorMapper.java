package com.ohot.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.SeqGeneratorVO;

@Mapper
public interface SeqGeneratorMapper {
	public SeqGeneratorVO findSeqGenerator(SeqGeneratorVO seqGeneratorVO);
	
	public int incrementSeqGenerator(SeqGeneratorVO seqGeneratorVO);

	public int updateSeqGeneratorDate(SeqGeneratorVO seqGeneratorVO);
}
