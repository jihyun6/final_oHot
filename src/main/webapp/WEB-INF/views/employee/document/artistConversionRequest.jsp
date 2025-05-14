<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
	<h2>일반회원 아티스트 전환 요청서</h2>
	
	<!-- 상단 영역 -->
	<div style="width: 100%; position: relative; margin-bottom: 20px;">
	  <div class="info" style="width: 300px; float: left;">
	    <table>
	      <tr>
	        <th>소속</th><td><input type="text" name="department" class="form-deptNm" disabled /></td>
	      </tr>
	      <tr>
	        <th>기안자</th><td><input type="text" name="drafter" class="form-empNm" disabled /></td>
	      </tr>
	      <tr>
	        <th>기안 일자</th>
	        <td><input type="text" class="form-control" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />" /></td>
	      </tr>
	      <tr>
	        <th>문서 번호</th><td></td>
	      </tr>
	    </table>
	  </div>
	
	  <!-- 결재 라인 -->
	  <div style="float: right; display: flex;">
	    <div id="request-section">
	      <table style="margin-bottom: 0;">
	        <tr>
	          <th rowspan="3" class="vertical-text">신 청</th>
	          <td id="drafter-position" style="height:25px; width: 80px;"></td>
	        </tr>
	        <tr>
	          <td id="drafter-name" style="height:60px;"></td>
	        </tr>
	        <tr>
	          <td style="height:25px;"></td>
	        </tr>
	      </table>
	    </div>
	    
	    <div id="approval-section">
	      <table class="approvalTbl" style="margin-bottom: 0;">
	        <!-- 결재라인 동적 생성 -->
	        
	      </table>
	    </div>
	    
	  </div>
	</div>
	
	<div class="clear"></div>
	
	<!-- 전환 대상 정보 -->
	<table>
	  <tr><td colspan="4" class="section-title">전환 대상 정보</td></tr>
	  <tr>
	    <th>회원 이메일</th><td><input type="text" name="memEmail" id="memEmail" /></td>
	    <th>회원명</th><td><input type="text" name="memFullName" id="memFullName" /></td>
	  </tr>
	</table>
	
	<!-- 전환 사유 및 검토 -->
	<table>
	  <tr><td colspan="4" class="section-title">전환 사유 및 참고 사항</td></tr>
	  <tr>
	    <th>전환 사유</th>
	    <td colspan="3"><textarea name="reason" id="reason" rows="5" placeholder="예: 공식 데뷔 예정으로 인한 권한 변경 요청 등"></textarea></td>
	  </tr>
	  <tr>
	    <th>비고</th>
	    <td colspan="3"><textarea name="remarks" id="remarks" rows="2"></textarea></td>
	  </tr>
	</table>
	
	<p style="margin-top: 20px;">
	  ※ 본 요청은 OHOT 플랫폼 운영 정책 및 활동 기준에 따라 아티스트 활동 자격을 검토하여 전환 승인 요청드립니다.
	</p>