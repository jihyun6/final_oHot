package com.ohot.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FileGroupVO {
	private long fileGroupNo;
	private Date fileRegdate;
	
	//FILE_GROUP : FILE_DETAIL = 1 : N
	private List<FileDetailVO> fileDetailVOList;
}
