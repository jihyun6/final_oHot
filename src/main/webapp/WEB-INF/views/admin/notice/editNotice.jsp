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
	  max-width: 1300px;
	  margin: 50px auto;
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
	.post-image {
	max-width: 100%;
	max-height: 500px;
	height: auto;
	object-fit: cover; /* 필요시 이미지 잘라내기 */
	}
	.post-container {
  width: calc(100% - 100px); /* 좌우 여백 50px씩 */
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

${artGroupNotice }
<div class="wrapper">
    <%@ include file="../adminHeader.jsp" %>
    <%@ include file="../adminSidebar.jsp"%>
	<form action="/admin/notice/editNoticePost" method="post" enctype="multipart/form-data">
	<input type="hidden" name="bbsPostNo" value="${artGroupNotice.bbsPostNo }">
	<input type="hidden" id="fileGroupNo" name="fileGroupNo" value="${artGroupNotice.fileGroupNo }"  class="form-control" />
	<div class="post-container">
	  <div class="post-title">
	    <input type="text" name="bbsTitle" value="${artGroupNotice.bbsTitle}">
	  </div>
	  <div class="post-date">${artGroupNotice.bbsRegDate}</div>
	
	  <div class="post-content">
	      <textarea class="form-control" rows="10" id="post-content" name="bbsCn"  required="">${artGroupNotice.bbsCn }</textarea>
		  <b class="text-danger fw-bold">&emsp; * 수정시 사진 전체를 새로 업로드 하는 것으로 기존 이미지는 삭제됩니다 * &emsp;</b>
		  
		  <input type="file" id="uploadFile" name="uploadFile" class="form-control"  onchange="readFileExpln(this)" multiple/>
		  
		
			  <div class="mt-3" id="oldImg" style="width:100%; height: 600px; overflow-y: auto; overflow-x:hidden;">
				<c:forEach var="fileDetail" items="${artGroupNotice.fileGroupVO.fileDetailVOList}">
					<img alt="경로확인" src="/upload/${fileDetail.fileSaveLocate }" style="width: 100%;" id="explnImg">
				</c:forEach>
			  </div>
		  </div>
	  
	  <div class="back-btn text-end">
	    <a href="/admin/notice/noticeList" class="btn btn-outline-secondary">목록</a>
	    <button type="submit" class="btn btn-outline-primary">저장</button>
	    <a onclick="history.back()" class="btn btn-outline-danger">취소</a>
	  </div>
	</div>
	</form>
<%@ include file="../adminFooter.jsp" %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

function readFileExpln(input){
	// 사용자가 파일을 선택할 때 기존 미리보기 초기화
    $("#oldImg").empty();
    console.log("input : ",input);
    
    if (input.files) {
    	console.log(input.files)
    	Array.from(input.files).forEach(file=>{
    		var reader= new FileReader();
   	         reader.onload = (function(selectedFile) {
	        	 return function(e){
		        	 console.log(e);
		        	 let img = document.createElement("img");
		             img.setAttribute("src", e.target.result);
		             img.style.objectFit = "cover";
		             img.style.border = "1px solid #ddd";
		             img.style.borderRadius = "5px";
		             img.style.width="100%"
		            
		        	 document.querySelector("#oldImg").appendChild(img);
		             
   	        	 };
   	         })(file);
   	         
   	         reader.readAsDataURL(file);
    	});
    }
};

</script>
</body>
</html>