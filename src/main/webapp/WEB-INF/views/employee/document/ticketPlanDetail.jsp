<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	
	  
	<!-- 공연 정보 -->
	<table>
	  <tr><td colspan="4" class="section-title">공연 기본 정보</td></tr>
	  <tr>
	    <th>공연명</th><td colspan="3">${approvedConcertPlanVODetail.gdsNm}</td>
	  </tr>
	  <tr>
	    <th>공연 분류</th><td>${approvedConcertPlanVODetail.tkCtgr}</td>
	    <th>공연 장소</th><td>${approvedConcertPlanVODetail.tkLctn}</td>
	  </tr>
	  <tr>
	    <th>아티스트명</th><td>${approvedConcertPlanVODetail.playerNm}</td>
	    <th>주최/주관</th><td>${approvedConcertPlanVODetail.hostOrg}</td>
	  </tr>
	  <tr>
	    <th>예상 관객 수</th><td>${approvedConcertPlanVODetail.expectedAudience} 명</td>
	    <th>예상 예산</th><td><fmt:formatNumber value="${approvedConcertPlanVODetail.expectedBudget}" pattern="#,###" /> 원</td>
	  </tr>
	</table>
	
	<!-- 기획 개요 -->
	<table>
		  <tr><td colspan="4" class="section-title">기획 개요 및 세부 내용</td></tr>
		  <tr>
		    <th>내용</th>
		    <td colspan="3">
		      <%-- <div class="content-box" style="min-height: 160px;white-space: pre-wrap;">
		        ${approvedConcertPlanVODetail.background}
		      </div> --%>
		      <div class="content-box" style="min-height: 160px;white-space: pre-wrap; font-family: 'monospace';">
  				<c:out value="${approvedConcertPlanVODetail.background}" />
			  </div>
		    </td>
		  </tr>
	
		  <tr>
		    <th>협업 요청사항</th>
		    <td colspan="3">
		      <div class="content-box" style="min-height: 80px;white-space: pre-wrap; font-family: 'monospace';">
		        ${approvedConcertPlanVODetail.requests}
		      </div>
		    </td>
		  </tr>
	
		  <tr>
		    <th>비고</th>
		    <td colspan="3">
		      <div class="content-box" style="min-height: 80px;white-space: pre-wrap; font-family: 'monospace';">
		        ${approvedConcertPlanVODetail.remarks}
		      </div>
		    </td>
		  </tr>
		</table>
	
	<p style="margin-top: 20px;">
	  ※ 본 공연은 회사 정책, 아티스트 일정, 현장 여건 등을 고려하여 기획된 사항으로 승인 요청드립니다.
	</p>	