<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userVO" property="principal.usersVO"/>
</sec:authorize>
<!-- <p>유저 정보</p> -->
<%-- ${userVO} --%>
<!-- <p>문의게시글정보</p> -->
<%-- ${boardPostVO} --%>

<div class="container mt-5">
    <button class="btn btn-outline-secondary rounded-2 px-3 py-1"  onClick="location.href='/oho/inquiryPost'">&lt; 목록</button>
   <div class="row my-3" style="border:solid 2px gray; border-radius:10px;">
       <div class="col">
           <!-- Post content-->
           <article>
               <!-- Post header-->
               <header class="mb-4">
                   <!-- Post title-->
			    <div class="row">
                   <div class="col-10">
	                   <c:if test="${boardPostVO.parentPostNo != 0}">
	                   	  <div class="mt-3">
		                   	  <a href="/oho/inquiryPost/detail?boardNo=${boardPostVO.parentPostNo}">원문 보러가기</a>
	                   	  </div>
	                   </c:if>
	                   <h6 class="fw-bolder pt-5">
	                       ${boardPostVO.inquiryPostVO.inqTypeNm}
	                   </h6>
	                   <h2 class="fw-bolder mb-1 pt-2">
	                       ${boardPostVO.bbsTitle}
	                   </h2>
	                   <br>
	                   <!-- 별로면 지워도 됨! -->
	                   <div class="text-muted fst-italic mb-2">${boardPostVO.bbsChgDt == null ? boardPostVO.bbsRegDt : boardPostVO.bbsChgDt}
	                   		<c:if test="${boardPostVO.bbsChgDt != null }"><small>(수정됨)</small></c:if>
	                   </div>
	                   <a class="badge bg-secondary text-decoration-none link-light" href="#!">${boardPostVO.inquiryPostVO.inqWriter}</a>
                   </div>
                   <c:if test="${userVO.userNo == boardPostVO.inquiryPostVO.memNo}">
                   	<div class="col-2 text-end">
				    	<div class="d-flex justify-content-end gap-2" style="margin-top: 170px;">
				    		<form action="/oho/inquiryPost/createPost" method="get">
				    			<input type="hidden" name="bbsPostNo" value="${boardPostVO.bbsPostNo}" />
				    			<input type="hidden" name="memNo" value="${boardPostVO.inquiryPostVO.memNo}" />
				    			<c:if test="${boardPostVO.inquiryPostVO.ansYn eq '미답변' }">
							    <button class="btn btn-outline-primary rounded-2 px-3 py-1">수정</button>
							    </c:if>
				    		</form>
				    		<form action="/oho/inquiryPost/deletePost" method="get">
				    			<input type="hidden" name="bbsPostNo" value="${boardPostVO.bbsPostNo}" />
							    <button class="btn btn-outline-danger rounded-2 px-3 py-1">삭제</button>
				    		</form>
				    	</div>
                   	</div>
				    </c:if>
				    </div>
		           <hr>
               </header>
               <!-- Post content-->
               <section class="mb-3">
                   <p class="fs-5 mb-4">${boardPostVO.bbsHtmlCn}</p>
               </section>
               <c:if test="${boardPostVO.parentPostNo!=0}">
               <c:choose>
	              <c:when test="${boardPostVO.fileGroupVO != null}">
	              	<strong>첨부파일 (${fn:length(boardPostVO.fileGroupVO.fileDetailVOList)})</strong><br><br>
	              	<c:forEach var="file" items="${boardPostVO.fileGroupVO.fileDetailVOList}">
		          		<img src="/upload${file.fileSaveLocate}" width="200px;" height="200px;" class="mb-2">
	              	</c:forEach>
	              </c:when>
	              	<c:otherwise>
	              		<strong>첨부파일</strong><br>
	              		<p>등록된 첨부파일이 없습니다.</p>
	              	</c:otherwise>
	              </c:choose>
               </c:if>
           </article>
           <!-- Comments section-->
         <c:if test="${boardPostVO.parentPostNo == 0}">
	           	<section>
	               <div class="card bg-light">
	                   <div class="card-body">
	                       <!-- Comment form-->
	                       <!-- Comment with nested comments-->
	                       <div class="d-flex mb-4">
	                           <!-- Parent comment-->
	                           <div class="ms-3">
	                           <c:choose>
	                           		<c:when test="${boardPostVO.inquiryPostVO.ansYn=='미답변'}">
		                           		<h5 class="fw-bolder mb-1">죄송합니다. 아직 등록된 답글이 없습니다.</h5>
	                           		</c:when>
	                           	<c:otherwise>
	                           		<c:if test="${boardPostVO.replyPostVO != null}">
	                           			<c:set var="replyPost" value="${boardPostVO.replyPostVO}" />
	                           			<div class="d-flex flex-row bd-highlight">
		                           		 	<h5 class="fw-bolder mb-1 me-4">등록된 답변</h5>
		                           		 	<a href="/oho/inquiryPost/detail?boardNo=${replyPost.bbsPostNo}">자세히 보기</a>
	                           			</div>
		                               	<div class="d-flex mt-4">
		                                   <div class="ms-3">
		                                   	  <div class="fw-bold">${replyPost.bbsTitle}</div>
		                                       ${replyPost.bbsCn}
		                                   </div>
		                               	</div>
	                           		</c:if>
	                           	</c:otherwise>
	                           </c:choose>
	                           </div>
	                       </div>
	                    </div>
	                </div>
	            </section>
            </c:if>
        </div>
    </div>
    
     <!-- 순수 텍스트만의 게시글 -->
    <div class="d-none">
    	<input type="hidden" id="bbsCn" name="bbsCn" value="${boardPostVO.bbsCn}"/>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>