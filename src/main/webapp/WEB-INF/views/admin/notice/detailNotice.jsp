<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>

    <title>oHoT Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
      body {
        background-color: #fff;
        font-family: 'Helvetica Neue', sans-serif;
      }

	.post-container {
	  max-width: 100%;
	  margin: 50px 40px;
	  padding: 40px;
	  border: 1px solid #eee;
	  border-radius: 10px;
	  background-color: #fff;
	  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	}

      .post-title {
        font-size: 1.8rem;
        font-weight: bold;
        margin-bottom: 10px;
      }

      .post-date {
        color: #888;
        font-size: 0.9rem;
        margin-bottom: 20px;
      }

      .post-content {
        font-size: 1rem;
        line-height: 1.7;
        white-space: pre-line;
      }

      .post-content b {
        color: #d63384;
      }

      .post-content a {
        color: #0d6efd;
        text-decoration: underline;
      }

      .back-btn {
        margin-top: 30px;
      }
      /* 포스트 사진 ( 그리드 지우고 난 후 임 -> 상의 후 아티스트 페이지까지) */
	.post-container {
	  width: calc(100% - 600px); /* 좌우 여백 50px씩 */
	  margin: 50px auto;
	  padding: 40px;
	  border: 1px solid #eee;
	  border-radius: 10px;
	  background-color: #fff;
	  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	}
    </style>
</head>
<body>
<c:set var="title" value="공지사항 관리"></c:set>

<div class="wrapper">   
  <%@ include file="../adminHeader.jsp" %>
  <%@ include file="../adminSidebar.jsp"%>

  <div class="post-container" id="container">
 	<div class="post-title">${artGroupNotice.bbsTitle}</div>
  	  <div class="post-date">${artGroupNotice.bbsRegDate}</div>

	<div class="post-content">


	${artGroupNotice.bbsCn }
		   <c:if test="${not empty artGroupNotice.fileGroupNo }">
		   <div class="mt-3" id="newImg" style="width:100%; height: 750px; overflow-y: auto; overflow-x:hidden;">
		      <c:forEach var="fileDetail" items="${artGroupNotice.fileGroupVO.fileDetailVOList}">
		         <img alt="" src="/upload/${fileDetail.fileSaveLocate }" style="width: 100%;" id="explnImg">
		      </c:forEach>
		   </div>
		   </c:if>
	
	
	  </div>
	  <div class="back-btn text-end">
	    <a href="/admin/notice/noticeList" class="btn btn-outline-secondary">목록</a>
	    <a href="/admin/notice/editNotice?bbsPostNo=${artGroupNotice.bbsPostNo }" class="btn btn-outline-primary">수정</a>
	    <a href="/admin/notice/editDelete?bbsPostNo=${artGroupNotice.bbsPostNo }" class="btn btn-outline-danger">삭제</a>
	  </div>
  </div>
<%@ include file="../adminFooter.jsp" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>