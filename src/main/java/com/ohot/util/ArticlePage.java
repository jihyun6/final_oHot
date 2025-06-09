package com.ohot.util;


import java.util.List;

import lombok.Data;

//페이징 관련 정보 + 게시글 정보
//new ArticlePage<Item2VO>(total, currentPage, size, content);
@Data
public class ArticlePage<T> {
	//전체글 수
	private int total;
	// 현재 페이지 번호
	private int currentPage;
	// 전체 페이지수 
	private int totalPages;
	// 블록의 크기
	private int blockSize = 5;
	// 블록의 시작 페이지 번호
	private int startPage;
	//블록의 종료 페이지 번호
	private int endPage;
	//검색어
	private String keyword = "";
	//요청URL
	private String url = "";
	//select 결과 데이터
	private List<T> content;
	//페이징 처리
	private String pagingArea = "";
	
	//생성자(Constructor) : 페이징 정보를 생성
	//					    79				1		  10			          select결과10행
	public ArticlePage(int total, int currentPage, int size, String keyword, List<T> content) {
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
			//7 = 79 / 10
			totalPages = total / size;//7
			
			//나머지가 있다면, 페이지를 1 증가
			if(total % size > 0) {//나머지 9
				totalPages++; //8페이지
			}
			
			//페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 블록크기 * 블록크기 + 1
			startPage = currentPage / this.blockSize * this.blockSize + 1;	//
			
			//현재페이지 % 블록크기 => 0일 때 보정
			if(currentPage % this.blockSize == 0) {
				startPage -= this.blockSize;
			}
			
			//블록종료번호 = 시작페이지번호 + (블록크기 - 1)
			//[1][2][3][4][5][다음]
			endPage = startPage + (this.blockSize - 1);
			
			//종료블록번호 > 전체페이지수 => 종료블록번호에 전체페이지수로 보정
			if(endPage > totalPages) {
				endPage = totalPages;
			}
		}
	}//end constructor
	
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






