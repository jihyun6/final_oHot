package com.ohot.vo;

import java.util.List;

import lombok.Data;

@Data
public class CommonCodeGroupVO {

	private String commCodeGrpNo;
	private String commCodeGrpNm;
	
	//CommonCodeGroupVO : CommonDetailCodeVO = 1 : N
	private List<CommonDetailCodeVO> commonDetailCodeVOList;
}
