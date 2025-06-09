<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


	  <!-- 공연 정보 -->
	  <table>
		  <tr><td colspan="4" class="section-title">전환 대상 정보</td></tr>
		  <tr>
		    <th>회원 이메일</th><td>${approvedConversionRequestVODetail.memEmail }</td>
		    <th>회원명</th><td>${approvedConversionRequestVODetail.memFullName }</td>
		  </tr>
		</table>
		
		<!-- 전환 사유 및 검토 -->
		<table>
		  <tr><td colspan="4" class="section-title">전환 사유 및 참고 사항</td></tr>
		  <tr>
		    <th>전환 사유</th>
		    <td colspan="3">
		    	<div class="content-box" style="min-height: 80px;">
		        	${approvedConversionRequestVODetail.reason}
		      	</div>
		    </td>
		  </tr>
		  <tr>
		    <th>비고</th>
		    <td colspan="3">
		    	<div class="content-box" style="min-height: 80px;">
		        	${approvedConversionRequestVODetail.remarks}
		        </div>
		    </td>
		  </tr>
		</table>
		
		<p style="margin-top: 20px;">
		  ※ 본 요청은 OHOT 플랫폼 운영 정책 및 활동 기준에 따라 아티스트 활동 자격을 검토하여 전환 승인 요청드립니다.
		</p>
		

             