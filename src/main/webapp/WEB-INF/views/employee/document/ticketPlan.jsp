<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
	 <h2>공연 기획 승인서</h2>
	    
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
		    
		    
		    <!--
		    <div id="approval-section" style="border: 1px solid #999;">
		    	<table style="margin-bottom: 0;">
		    	  <tr>
		    	    <th rowspan="3" class="vertical-text">승 인</th>
		    	    <td id="approval1-position" style="height:25px; width: 80px;"></td>
		    	    <td id="approval2-position" style="height:25px; width: 80px;"></td>
		    	  </tr>
		    	  <tr>
		    	    <td id="approval1-name" style="height:60px;"></td>
		    	    <td id="approval2-name" style="height:60px;"></td>
		    	  </tr>
		    	  <tr>
		    	    <td style="height:25px;"></td>
		    	    <td style="height:25px;"></td> 
		    	  </tr>
		    	</table>
    		 </div>
		    -->
		    
		  </div>
		</div>
	
	  <!-- 간격 조정을 위한 clear 추가 -->
	  <div class="clear"></div>
	
	  <!-- 공연 정보 -->
	  <table>
	    <tr><td colspan="4" class="section-title">공연 기본 정보</td></tr>
	    <tr>
	      <th>공연명</th><td colspan="3"><input type="text" name="gdsNm" id="gdsNm" /></td>
	    </tr>
	    <tr>
	      <th>공연 분류</th>
	        <td>
	            <select name="tkCtgr" id="tkCtgr" style="width: 200px;height: 30px;">
	                <option value="콘서트">콘서트</option>
	                <option value="팬미팅">팬미팅</option>
	                <option value="기타">기타</option>
	            </select>
	        </td>
	      <th>공연 장소</th><td><input type="text" name="tkLctn" id="tkLctn" required /></td>
	    </tr>
	    <tr>
	      <th>아티스트명</th><td><input type="text" name="playerNm" id="playerNm" required /></td>
	      <th>주최/주관</th><td><input type="text" name="hostOrg" id="hostOrg" required /></td>
	    </tr>
	    <tr>
	      <th>예상 관객 수</th><td><input type="number" name="expectedAudience" id="expectedAudience" required /></td>
	      <th>예상 예산</th><td><input type="number" name="expectedBudget" id="expectedBudget" required /></td>
	    </tr>
	  </table>
	
	  <!-- 기획 개요 -->
	  <table>
	    <tr><td colspan="4" class="section-title">기획 개요 및 세부 내용</td></tr>
	    <tr>
	      <th>내용</th>
	      <td colspan="3"><textarea name="background" id="background" rows="10" required></textarea></td>
	    </tr>
	    <tr>
	      <th>협업 요청사항</th>
	      <td colspan="3"><textarea name="requests" id="requests" rows="2" ></textarea></td>
	    </tr>
	    <tr>
	      <th>비고</th>
	      <td colspan="3"><textarea name="remarks" id="remarks" rows="2"></textarea></td>
	    </tr>
	  </table>
	
	  <p style="margin-top: 20px;">
	    ※ 본 공연은 회사 정책, 아티스트 일정, 현장 여건 등을 고려하여 기획된 사항으로 승인 요청드립니다.
	  </p>