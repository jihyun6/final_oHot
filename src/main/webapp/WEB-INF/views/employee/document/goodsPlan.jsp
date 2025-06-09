<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
	<h2>아티스트 굿즈 기획서</h2>
	
	 <!-- 상단 영역 컨테이너 -->
		<div style="width: 100%; position: relative; margin-bottom: 20px;">
		  <!-- 기본정보 - 너비 제한 -->
		  <div class="info" style="width: 300px; float: left;">
		    <table>
		      <tr>
		        <th>소속</th><td><input type="text" name="department" class="form-deptNm" disabled /></td>
		      </tr>
		      <tr>
		        <th>기안자</th><td><input type="text" name="drafter" class="form-empNm" disabled /></td>
		      </tr>
		      <tr>
		        <th>기안 일자</th><td><input type="text" class="form-control" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />" /></td>
		      </tr>
		      <tr>
		        <th>문서 번호</th><td></td>
		      </tr>
		    </table>
		  </div>
		
		  <!-- 결재 라인 - 오른쪽에 고정 배치 -->
		  <div style="float: right; display: flex;">
		    <!-- 신청 부분 -->
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
		    
		    <!-- 승인 부분 -->
		    <div id="approval-section">
		      <table class="approvalTbl" style="margin-bottom: 0;">
		       
		      </table>
		    </div>
		   
		    
		  </div>
		</div>
		
	<div class="clear"></div>
	
	  <table>
	    <tr><td colspan="4" class="section-title">기획 내용</td></tr>
	    <tr>
	      <th>아티스트명</th><td colspan="3"><input type="text" name="artistName" style="width: 98%;" /></td>
	    </tr>
	    <tr>
	      <th>굿즈명</th><td><input type="text" name="gdsNm" id="gdsNm" /></td>
	      <th>굿즈 종류</th><td><input type="text" name="gdsType" id="gdsType" placeholder="예: 포토카드, 의류 등" /></td>
	    </tr>
	    <tr>
	      <th>예상 수량</th><td><input type="number" name="expectedProduction" id="expectedProduction" /></td>
	      <th>예상 단가</th><td><input type="number" name="expectedPrice" id="" /></td>
	    </tr>
	    <tr>
	      <th>기획 배경 및 목적</th>
	      <td colspan="3"><textarea name="planDetail" id="planDetail" rows="5" style="width: 98%;"></textarea></td>
	    </tr>
	    <tr>
	      <th>비고</th>
	      <td colspan="3"><textarea name="remarks" rows="3" style="width: 98%;"></textarea></td>
	    </tr>
	  </table>
	
	  <p style="margin-top: 20px;">
	    ※ 해당 굿즈는 회사 정책 및 아티스트 방향성에 따라 기획되었음을 명시하며, 관련 부서의 협조를 요청드립니다.
	  </p>
	  

	  
