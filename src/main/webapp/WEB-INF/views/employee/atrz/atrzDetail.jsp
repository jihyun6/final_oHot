<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oHoT EMP</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.8.4/axios.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>

<style>
.approval-table-container {
    max-height: 380px;
    overflow-y: auto;
    border: 1px solid #eee;
    border-radius: 8px;
    padding: 5px;
}

#approvalList tr, #referrerList tr {
    border-bottom: 1px solid #dee2e6;
}

.modal-body table {
    border-collapse: collapse;
    width: 100%;
}

.modal-body table th{
    padding: 0px;
    font-size: 0.9rem; 
}
.modal-body table td {
    border: none;
    padding: 6px;
}

#searchName {
    border: 1px solid #eee;
    border-radius: 4px;
    padding: 5px 5px;
    max-width: 80%;
    margin-bottom: 5px;
    margin-left: 10px;
    margin-right: 15px;
}
.table thead th{
    padding: 0px !important;
}
.document-selection-container .card {
    transition: all 0.3s ease;
    border-radius: 10px;
}
.right-sidebar {
    position: sticky;
    top: 150px;
    height: calc(100vh - 150px);
    overflow-y: auto;
    z-index: 10;
}
.approval-person {
    display: flex;
    align-items: center;
    padding: 10px;
    margin-bottom: 8px;
    border-radius: 4px;
}
.approval-person.highlight{

	border-left: 3px solid #20c997;
    background-color: #f8f9fa;
}

.approval-person img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 12px;
}
.approval-person-info {
    flex: 1;
}
.approval-person-name {
    font-weight: 600;
    margin-bottom: 2px;
}
.approval-person-position {
    font-size: 0.8rem;
    color: #6c757d;
}
.approval-status {
    font-size: 0.75rem;
    padding: 3px 8px;
    border-radius: 12px;
    background-color: #e9ecef;
    font-weight: 600;
}
.status-draft {
    background-color: #e2e3e5;
    color: #055160;
}
.status-pending {
    background-color: #cff4fc;
    color: #41464b;
}

.action-buttons {
    display: flex;
    gap: 8px;
    margin-top: 12px;
}
#request-section td, #approval-section td{
	text-align: center;
}
td{
	text-align: left;
}
.modal-dialog {
  max-width: 600px !important;
}
.modal-title {
  font-size: 1.5rem;
  font-weight: bold;
}
.modal-body .form-label {
  font-size: 1.1rem;
  font-weight: 600;
}

.modal-body .form-control {
  font-size: 1rem;
  padding: 10px;
  border: 2px;
}

.modal-body textarea {
  min-height: 150px;
}

.modal-footer .btn {
  font-size: 1rem;
  padding: 8px 20px;
}
.modal-body .form-control {
  font-size: 1rem;
  padding: 10px;
  border: 1px solid #ced4da; 
  border-radius: 5px; 
  box-shadow: none; 
}

.modal-body .form-control:focus {
  border-color: #86b7fe; 
  box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25); 
  outline: none; 
}
.content-box {
    width: 100%;
    padding: 0;
    margin: 0;
    border: 1px solid #ccc;
    font-family: inherit;
    white-space: normal;
    word-break: break-word;
    text-align: left;
  }
  
#download  {
	display: inline-flex;
    align-items: center;
    gap: 8px;
    background-color: #e53935;
    color: white;
    padding: 8px 16px;
    font-size: 15px;
    font-weight: bold;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    transition: background-color 0.2s;
}
</style>
</head>
<body>
    
    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.usersVO" var="userVO"/>    
    </sec:authorize>

    <!-- 사이드바 -->
    <%@ include file="../sidebar.jsp"%>

    <!-- 컨텐츠 -->
    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
        <!-- 헤더 -->
        <%@ include file="../header.jsp"%>
        <div class="container-fluid px-4">
           <form id="atrzForm"> 
            <!-- 문서작성 & 결재선 -->
            <div class="row">
                <!-- 왼쪽: 기안문서 설정 및 작성 영역 -->
                <div class="col-md-9 mb-4">
                    <!-- 문서 선택 셀렉트 -->
                    <div class="mb-4 document-selection-container">
                        <div class="card shadow-sm border-0">
                            <div class="card-body p-3">
                                <div class="row g-3 align-items-center">
                                   
                                    <div class="col-md-3">
                                        <label for="formTypeSelect" class="form-label small text-muted mb-1">문서 종류</label>
                                        <div class="form-control-plaintext fw-semibold text-dark" id="formTypeSelect">
                                            <c:choose>
											  <c:when test="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].docFmNo == 2}">
											    공연 기획 승인서
											  </c:when>
											  <c:when test="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].docFmNo == 3}">
											    일반회원 아티스트 전환 요청서
											  </c:when>
											  <c:otherwise>
											    아티스트 굿즈 기획서
											  </c:otherwise>
											</c:choose>
                                        </div>
                                    </div>
                                    <div class="col-md-7">
                                        <label for="approvalTitle" class="form-label small text-muted mb-1">기안 제목</label>
                                        <div class="form-control-plaintext text-dark">
					                        ${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftTtl }
					                    </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-check form-switch mt-4">
                                            <input class="form-check-input" type="checkbox" id="emrgYn" name="emrgYn" value="Y"
                                            	${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].emrgYn == 'Y'? 'checked' : ''} disabled>
                                            <label class="form-check-label text-danger" for="emrgYn">
                                                <i class="bi bi-exclamation-circle me-1"></i>긴급 문서
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                   <button type="button" id="download">
		           	 <img src="https://cdn-icons-png.flaticon.com/512/337/337946.png" alt="PDF" style="width: 20px; height: 20px;">PDF 다운로드
		           </button>
                    <!-- 기안문서 작성 부분 -->
                    <div class="card shadow-sm">
                        <div class="card-body">
	                        <div id="formTemplate" class="text-center p-5 text-muted border border-2 rounded" style="min-height: 500px;">
	                        	<c:choose>
								  <c:when test="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].docFmNo == 2}">
								    <h2>공연 기획 승인서</h2>
								  </c:when>
								  <c:when test="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].docFmNo == 3}">
								    <h2>일반회원 아티스트 전환 요청서</h2>
								  </c:when>
								  <c:otherwise>
								    <h2>아티스트 굿즈 기획서</h2>
								  </c:otherwise>
								</c:choose>
                			    <input type="hidden" name="atrzDocNo" id="atrzDocNo"  value="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].atrzDocNo}" />
                		    
                		  <!-- 상단 영역 컨테이너 -->
                			<div class="top-section">
                			  <!-- 기본정보 - 너비 제한 -->
                			 <div class="info" style="width: 300px; float: left;">
                			    <table>
                			      <tr>
                			        <th>소속</th><td>${atrzDocVODetail.deptNm}</td>
                			      </tr>
                			      <tr>
                			        <th>기안자</th><td>${atrzDocVODetail.employeeVOList[0].empNm}</td>
                			      </tr>
                			      <tr>
                			        <th>기안 일자</th><td>${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftYmd}</td>
                			      </tr>
                			      <tr>
                			        <th>문서 번호</th><td style="width: 200px;">${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].atrzDocNo}</td>
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
                			          <td id="drafter-position" style="height:25px; width: 80px;">${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftJbgdCd}</td>
                			        </tr>
                			        <tr>
                			          <td id="drafter-name" style="height:60px;">
                			          	<c:choose>
                			          		<c:when test="${not empty atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftStampFileSaveLocate}">
                			          			<div class="stamp">
	                			          			<img alt="도장" src="/upload${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftStampFileSaveLocate}">
	                			          			<div class="name">${atrzDocVODetail.employeeVOList[0].empNm}</div>
                			          			</div>
                			          		</c:when>
                			          		<c:otherwise>
	                			          		<div class="stamp">
                			          				<img alt="기본도장" src="/images/approval.png">
		            			          			<div class="name">${atrzDocVODetail.employeeVOList[0].empNm}</div>
		        			          			</div>
                			          		</c:otherwise>
                			          	</c:choose>
                			          </td>
                			        </tr>
                			        <tr>
                			          <td class="date" style="height:25px;width: 120px; text-align: center;">${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftYmd}</td>
                			        </tr>
                			      </table>
                			    </div>
                			    
                			    <!-- 승인 부분 -->
                			    <div id="approval-section">
                			      <table class="approvalTbl" style="margin-bottom: 0;">
		                		  	<tr>
			          			    	<th rowspan="3" class="vertical-text">승 인</th>
		                			    <c:forEach var="dept" items="${atrzLineVOList}">
								            <c:forEach var="emp" items="${dept.employeeVOList}">
								                <c:forEach var="line" items="${emp.atrzLineVOList}">
								                    <td style="height:25px; width: 80px;">${line.aprvrJbgdCd}</td>
								                </c:forEach>
								            </c:forEach>
								        </c:forEach>
			          			    </tr>
			          			    <tr>
						          		<c:forEach var="dept" items="${atrzLineVOList}">
										    <c:forEach var="emp" items="${dept.employeeVOList}">
										    	<c:forEach var="line" items="${emp.atrzLineVOList}">
										    	<input type="hidden" name="empNo"  value="${emp.empNo }" />
										    	<input type="hidden" name="atrzSn" value="${line.atrzSn }" />
										    		<td style="height:71px;">
												    	<c:choose>
									                    	<c:when test="${not empty line.aprvrStampFileSaveLocate and '결재 승인'.equals(line.atrzLnSttsCd)}">
										                 		<div class="stamp">
											                 		<img alt="도장" src="/upload${line.aprvrStampFileSaveLocate}">
											                 		<div class="name">${emp.empNm}</div>
										                 		</div>
									                   		</c:when>
									                    	<c:when test="${empty line.aprvrStampFileSaveLocate and '결재 승인'.equals(line.atrzLnSttsCd)}">
											                 	<div class="stamp">
										                 			<img alt="기본도장" src="/images/approval.png">
												             		<div class="name">${emp.empNm}</div>
												         		</div>
									                    	</c:when>
								                    		<c:when test="${'결재 반려'.equals(line.atrzLnSttsCd)}">
																<div style="color: red; font-weight: bold; text-align: center;">
															    	결재 반려
															    </div>
															    	<div class="name">${emp.empNm}</div>
														 	</c:when>
								                         	<c:otherwise>
								                         		<div>${emp.empNm}</div>
								                          	</c:otherwise>
								                    	</c:choose>
								                    </td>
										        </c:forEach>
										        <%-- <td style="height:60px;">${emp.empNm}</td> --%>
										    </c:forEach>
										</c:forEach>
	          			    	    </tr>
	          			    	    <tr>
				          				<c:forEach var="dept" items="${atrzLineVOList}">
								            <c:forEach var="emp" items="${dept.employeeVOList}">
								                <c:forEach var="line" items="${emp.atrzLineVOList}">
								                    <td style="height:25px;width: 120px; text-align: center;">
								                        <c:choose>
								                            <c:when test="${not empty line.atrzDt}">
								                                ${line.atrzYmd}
								                            </c:when>
								                            <c:otherwise>
								                                &nbsp;
								                            </c:otherwise>
								                        </c:choose>
								                    </td>
								                </c:forEach>
								            </c:forEach>
								        </c:forEach>
         			    	        </tr>
                			      </table>
                			    </div>
                			    
                		
                			  </div>
                			</div>
                		
                		  <!-- 간격 조정을 위한 clear 추가 -->
                		  <div class="clear"></div>
                		
                		  <!-- 최종승인 정보 -->
                		  <c:choose>
						  	<c:when test="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].docFmNo == 2}">
								<jsp:include page="/WEB-INF/views/employee/document/ticketPlanDetail.jsp" />
							</c:when>
							<c:when test="${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].docFmNo == 3}">
								<jsp:include page="/WEB-INF/views/employee/document/artistConversionRequestDetail.jsp" />
							</c:when>
						  </c:choose>
                		 
                		 
	                        </div>
                        </div>
                    </div>
                </div>

                <!-- 오른쪽: 결재선 -->
				<div class="col-md-3 mb-4 right-sidebar">
				    <div class="card shadow-sm">
				        <div class="card-header d-flex justify-content-between align-items-center">
				            <h6 class="text-muted">결재선</h6>
				        </div>
				        <div class="card-body">
				            <!-- 결재자 목록 -->
				            <div class="approval-person-list mb-3">
				
				                <!-- 기안자 -->
				                <div class="approval-person <c:if test="${userVO.userNo eq atrzDocVODetail.employeeVOList[0].empNo }"> highlight</c:if>">
				                    <c:choose>
				                        <c:when test="${not empty atrzDocVODetail.employeeVOList[0].profileSaveLocate}">
				                            <img src="/upload${atrzDocVODetail.employeeVOList[0].profileSaveLocate}" alt="프로필" class="profile-img">
				                        </c:when>
				                        <c:otherwise>
				                            <img src="/images/defaultProfile.jpg" alt="기본 프로필" class="profile-img">
				                        </c:otherwise>
				                    </c:choose>
				                    <div class="approval-person-info">
				                        <div class="approval-person-name">${atrzDocVODetail.employeeVOList[0].empNm }</div>
				                        <div class="approval-person-position">${atrzDocVODetail.deptNm} | ${atrzDocVODetail.employeeVOList[0].position}</div>
				                        <div class="approval-status">
							                ${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].atrzLnSttsCd}
							                <c:if test="${not empty atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftDt}">
							                    | ${atrzDocVODetail.employeeVOList[0].atrzDocVOList[0].drftDt}
							                </c:if>
							            </div>
				                    </div>
				                    <!-- <span class="approval-status status-draft">기안</span> -->
				                </div> 
				
								<c:forEach var="dept" items="${atrzLineVOList}">
								    <c:forEach var="emp" items="${dept.employeeVOList}">
								        <c:forEach var="line" items="${emp.atrzLineVOList}">
								        	<div class="approval-person
					                        	<c:if test="${userVO.userNo eq emp.empNo }"> highlight</c:if> ">
											    
											    <c:choose>
								                    <c:when test="${not empty emp.profileSaveLocate}">
								                        <img src="/upload${emp.profileSaveLocate}" alt="프로필" class="profile-img">
								                    </c:when>
								                    <c:otherwise>
								                        <img src="/images/defaultProfile.jpg" alt="기본 프로필" class="profile-img">
								                    </c:otherwise>
							                    </c:choose>
							                    
							                    <div class="approval-person-info">
							                         <div class="approval-person-name">${emp.empNm}</div>
							                         <div class="approval-person-position">${dept.deptNm} | ${emp.jbgdCd}</div>
							                         <div class="approval-status">
							                             ${line.atrzLnSttsCd}
							                             <c:if test="${not empty line.atrzDt}">
							                                 | ${line.atrzDt}
							                             </c:if>
							                         </div>
							                     </div>
							                     
							                    <!-- 의견 처리 -->
						                        <c:if test="${line.atrzDt != null}">
						                            <div class="approval-opinion">
						                                <c:choose>
						                                	<c:when test="${not empty line.rjctRsn}">
						                                        <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#openOpinionModal" 
						                                                onclick="openOpinionModal('${emp.empNm}', '${line.atrzDt }','${line.rjctRsn}')">
						                                            반려 사유
						                                        </button>
						                                    </c:when>
						                                    <c:when test="${not empty line.atrzOpnn}">
						                                    	<button type="button" class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#openOpinionModal"
						                                                onclick="openOpinionModal('${emp.empNm}', '${line.atrzDt }', '${line.atrzOpnn}')">
						                                            결재 의견
						                                        </button>
						                                    </c:when>
						                                    <c:otherwise>
						                                        <button type="button" class="btn btn-sm btn-outline-secondary">
						                                            의견 없음
						                                        </button>
						                                    </c:otherwise>
						                                </c:choose>
						                            </div>
						                        </c:if>
						                        
				                        	</div>
								        </c:forEach>
								    </c:forEach>
								</c:forEach>
								
								<c:if test="${canApprove }">
							        <!-- 버튼 영역 -->
						            <div class="action-buttons">
						                <button type="button" class="btn btn-outline-secondary flex-grow-1" data-bs-toggle="modal"
						                    data-bs-target="#rejectModal" id="rejectBtn">반려</button>
						                <button type="button" class="btn btn-info flex-grow-1" data-bs-toggle="modal"
						                	data-bs-target="#opinionModal" id="opinionBtn">승인</button>
						            </div>
					            </c:if>
					            
				            </div>
				        </div>
				    </div>
				</div>
            </div>
           </form> 
        </div>

        <!-- 승인 모달 -->
        <div class="modal fade" id="opinionModal" tabindex="-1" aria-labelledby="approvalModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		    <div class="modal-content p-4">
		      <div class="modal-header">
		        <h5 class="modal-title" id="approvalModalLabel">결재 의견 작성</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		
		      <form id="approvalForm">
		        <div class="modal-body">
		          <input type="hidden" name="atrzSn" id="approvalAtrzSn">
		
		          <div class="mb-3">
		            <label class="form-label">작성자 명 <span style="color:red;">*</span></label>
		            <input type="text" class="form-control" id="approvalWriter" value="${userVO.employeeVO.empNm } ${userVO.employeeVO.position}(${userVO.employeeVO.departmentVO.deptNm })"  readonly>
		          </div>
		
		          <div class="mb-3">
		            <label class="form-label">작성 일자 <span style="color:red;">*</span></label>
		            <input type="text" class="form-control" id="atrzDt" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />" readonly>
		          </div>
		
		          <div class="mb-3">
		            <label class="form-label">내용</label>
		            <textarea class="form-control" id="atrzOpnn" name="atrzOpnn" rows="5" placeholder="결재 의견을 작성해주세요. (1000자 미만)"></textarea>
		          </div>
		        </div>
		
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		          <button type="button" class="btn btn-info" onclick="submitApproval('승인')">승인</button>
		        </div>
		      </form>
		
		    </div>
		  </div>
		</div>
		
		<!-- 반려 모달 -->
		<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
		    <div class="modal-content p-4">
		      <div class="modal-header">
		        <h5 class="modal-title" id="rejectModalLabel">반려 사유 작성</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		
		      <form id="rejectForm">
		        <div class="modal-body">
		          <input type="hidden" name="atrzSn" id="rejectAtrzSn">
		
		          <div class="mb-3">
		            <label class="form-label">작성자 명 <span style="color:red;">*</span></label>
		            <input type="text" class="form-control" id="rejectWriter" value="${userVO.employeeVO.empNm } ${userVO.employeeVO.position}(${userVO.employeeVO.departmentVO.deptNm })"  readonly>
		          </div>
		
		          <div class="mb-3">
		            <label class="form-label">작성 일자 <span style="color:red;">*</span></label>
		            <input type="text" class="form-control" id="rejectDate" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />" readonly>
		          </div>
		
		          <div class="mb-3">
		            <label class="form-label">내용 <span style="color:red;">*</span></label>
		            <textarea class="form-control" id="rjctRsn" name="rjctRsn" rows="5" placeholder="결재 의견을 작성해주세요. (1000자 미만)" required></textarea>
		          </div>
		        </div>
		
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		          <button type="button" class="btn btn-danger" onclick="submitApproval('반려')">반려</button>
		        </div>
		      </form>
		
		    </div>
		  </div>
		</div>
		
		
		<!-- 공통 의견 상세 모달 -->
		<div class="modal fade" id="openOpinionModal" tabindex="-1" aria-labelledby="openOpinionModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		    <div class="modal-content p-4">
		      <div class="modal-header">
		        <h5 class="modal-title" id="opinionDetailModalLabel">의견 상세 보기</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		
		      <div class="modal-body">
		        <div class="mb-3">
		          <label class="form-label">작성자 명</label>
		          <input type="text" class="form-control" id="detailWriter" readonly>
		        </div>
		        <div class="mb-3">
		          <label class="form-label">작성 일자</label>
		          <input type="text" class="form-control" id="detailAtrzDate" readonly>
		        </div>
		        <div class="mb-3">
		          <label class="form-label">내용</label>
		          <textarea class="form-control" id="detailContent" rows="6" readonly></textarea>
		        </div>
		      </div>
		
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
        
        <!-- 풋터 -->
        <%@ include file="../footer.jsp"%>
    </main>
    <script>
    const userInfo = {
        empNm : "${userVO.employeeVO.empNm}",
        deptNm : "${userVO.employeeVO.departmentVO.deptNm}",
        position : "${userVO.employeeVO.position}",
        empNo : ${userVO.userNo},
    	jbgdCd : "${userVO.employeeVO.jbgdCd}",
    	aprvrStampFileGroupNo : ${userVO.employeeVO.stampFileGroupNo}
    };
    
    function openOpinionModal(writer, atrzDt, content){
    	document.getElementById('detailWriter').value = writer;
        document.getElementById('detailAtrzDate').value = atrzDt;
        document.getElementById('detailContent').value = content;
       
    }
    
    function submitApproval(approvalType){
    	
	    const atrzDocNo = document.querySelector("#atrzDocNo").value;
	    const atrzEmpNo = userInfo.empNo;
    	const aprvrStampFileGroupNo = userInfo.aprvrStampFileGroupNo;
	    
    	let data = {};
    	let atrzSn = null;
    	
    	const empNos = document.querySelectorAll("input[name='empNo']");
    	const atrzSns = document.querySelectorAll("input[name='atrzSn']");
    	
    	for(let i=0; i<empNos.length; i++){
    		if(parseInt(empNos[i].value) === atrzEmpNo){
    			atrzSn = parseInt(atrzSns[i].value);
    			break;
    		}
    	}
    	
    	if(atrzSn === null){
    		Swal.fire("오류", "현재 결재자의 정보를 찾을 수 없습니다.", "error");
    		return;
    	}
    	
    	
	    if(approvalType.includes('승인')){
		    let atrzOpnn = document.querySelector("#atrzOpnn").value;
	    	
	    	data = {
	    		atrzOpnn : atrzOpnn,
	    		atrzDocNo : atrzDocNo,
	    		atrzEmpNo : atrzEmpNo,
	    		atrzLnSttsCd : 'APPROVED',
	    		aprvrStampFileGroupNo : aprvrStampFileGroupNo,
	    		atrzSn : atrzSn
	    	}
	    	
	    	
    	}else{
    		
	    	let rjctRsn = document.querySelector("#rjctRsn").value;
	    	
	    	data = {
	    		rjctRsn : rjctRsn,
	    		atrzDocNo : atrzDocNo,
	    		atrzEmpNo : atrzEmpNo,
	    		atrzLnSttsCd : 'REJECTED',
	    		aprvrStampFileGroupNo : aprvrStampFileGroupNo,
	    		atrzSn : atrzSn
	    	}
    	}
    	
	    fetch('/emp/atrzLineUpdate',{
	    	method : "POST",
			headers : {
				"Content-Type" : "application/json"
			},
			body : JSON.stringify(data)
	    }).then(resp => resp.text())
		  .then(data =>{
			console.log("승인업뎃 data", data);
			
			if(data.includes("success")){
				Swal.fire({
	    			 title : "성공",
	    			 text : "처리되었습니다.",
	    			 icon : "success",
	    			 timer : 1000
	    			  
	    		  }).then(()=>{
					location.reload();
	    		  });
			}else{
				Swal.fire("오류", "오류가 발생했습니다.", "error");
			}
			

		  })
    	
    }


    document.getElementById("download").addEventListener("click", () => {
    
        const element = document.getElementById("formTemplate");
        console.log("element:::::::",element);
        html2pdf()
          .from(element)
          .set({
            margin: 1,
            filename: "example.pdf",
            html2canvas: { scale: 2 },
            jsPDF: { orientation: "portrait" },
          })
          .save();

      });

    </script>
</body>
</html>