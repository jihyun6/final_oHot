package com.ohot.util;

import java.util.List;

import lombok.Data;

@Data
public class BoardPage<T> {
	// 전체글 수
	private int total;
	// 현재 페이지 번호
	private int currentPage;
	//블록의 크기
	private int blockSize = 5;
	// 전체 페이지수
	private int totalPages;
	// 블록의 시작 페이지 번호
	private int startPage;
	// 블록의 종료 페이지 번호
	private int endPage;
	// 검색어
	private String keyword = "";
	// 요청URL
	private String url = "";
	// select 결과 데이터
	private List<T> content;
	// 페이징 처리
	private String pagingArea = "";
	// 무한 스크롤 마지막 페이지 여부
	private Boolean isLastPage;
	// 댓글 무한스크롤(profileDetail)
	private Boolean isReplyLastPage;
	
	//비동기 페이징 블록
	//오버로딩 : 동일한 클래스에서 같은 이름의 메소드를 사용(매개변수의 개수가 다르거나 매개변수의 타입이 다름)
	//생성자(Constructor) : 페이징 정보를 생성
	//						79					1		10					select결과10행
	public BoardPage(int total, int currentPage, int size, String keyword, List<T> content, String mode) {
		  //size : 한 화면에 보여질 목록의 행 수
	      this.total = total;
	      this.currentPage = currentPage;
	      this.keyword = keyword;
	      this.content = content;
	      
	      //전체글 수가 0이면?
	      if(total==0) {
	         totalPages = 0;//전체 페이지 수
	         startPage = 0;//블록 시작번호
	         endPage = 0; //블록 종료번호
	      }else {//글이 있다면
	         //전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
	         // 7.9 = 79 / 10
	    	  totalPages = total / size ;
	         
	         //나머지가 있다면, 페이지를 1 증가
	    	  if(total%size > 0) {  // 나머지 9
	    		  totalPages++;
	    	  }
	         
	         //페이지 블록 시작번호를 구하는 공식
	         // 블록시작번호 = 현재페이지 / 블록크기 * 블록크기 + 1 (공식임)
	    	  startPage = currentPage / blockSize * blockSize + 1;
	         
	         //현재페이지 % 블록크기 => 0일 때 보정 (예) 10일 경우 start번호가 아닌 11이 나오는데 이때 블록크기를 빼주면 된다.)
	    	  if(currentPage % blockSize == 0) {
	    		  startPage -= blockSize;
	    	  }
	    	  
	         //블록종료번호 = 시작페이지번호 + (블록크기 - 1)
	         //[1][2][3][4][5][다음]
	    	  endPage = startPage + (blockSize - 1);
	         
	         //종료블록번호 > 전체페이지수 => 종료블록번호를 전체페이지수로 보정
	    	  if(endPage > totalPages)  endPage = totalPages;
	      }
 } // end constructor
 
//전체 글의 수가 0인가?
 public boolean hasNoArticles() {
    return this.total == 0;
 }
 
 //데이터가 있나?
 public boolean hasArticles() {
    return this.total > 0;
 }
 
 public void setPagingArea(String pagingArea) {
    this.pagingArea = pagingArea;
 }

 //페이징 블록을 자동화
 public String getPagingArea() {
    return this.pagingArea;
 }
}
