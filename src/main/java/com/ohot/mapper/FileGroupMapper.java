package com.ohot.mapper;
import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;



@Mapper
public interface FileGroupMapper {
	//1. FILE_GROUP 테이블에 insert(1회 실행)
	//실행전 fileGroupVO{fileGroupNo=0,fileRegdate=null)
	//실행후 fileGroupVO{fileGroupNo=20250226001,fileRegdate=null) 왜냐하면 selectKey에 의해서..
	public int insertFileGroup(FileGroupVO fileGroupVO);

	//FILE_DETAIL 테이블에 insert
	public int insertFileDetail(FileDetailVO fileDetailVO);
	
	//파일정보 가져오기
	public FileDetailVO selectFileDetail(FileDetailVO fileDetailVO);
	
	/* 이미지들 삭제
    FileDetailVO(fileSn=1, fileGroupNo=20250226070, fileOriginalName=null, fileSaveName=null
   , fileSaveLocate=null, fileSize=0, fileExt=null, fileMime=null, fileFancysize=null
   , fileSaveDate=null, fileDowncount=0)
    */
	public int deleteFileDetail(FileDetailVO fileDetailVO);


}