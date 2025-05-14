package com.ohot.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FileDetailVO {
	private long fileSn;
	private long fileGroupNo;
	private String fileOriginalName;
	private String fileSaveName;
	private String fileSaveLocate;
	private long fileSize;
	private String fileExt;
	private String fileMime;
	private String fileFancysize;
	private Date fileSaveDate;
	private int fileDowncount;
	
	
}
