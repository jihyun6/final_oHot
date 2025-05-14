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
        max-width: 820px;
        margin: 50px auto;
        padding: 30px;
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
	
  .artist-selector {
    max-width: 400px; /* 폭 제한 */
    margin: 0 auto; /* 가운데 정렬 */
  }

  .artist-selector label {
    font-size: 1.1rem;
    color: #333;
    margin-bottom: 6px;
  }

  .artist-selector select {
    width: 100%;
    padding: 8px 16px;
    font-size: 0.95rem;
    border: 1.5px solid #ced4da;
    border-radius: 1.5rem;
    background-color: #fff;
    transition: all 0.3s ease;
  }

  .artist-selector select:focus {
    border-color: #0d6efd;
    box-shadow: 0 0 0 0.15rem rgba(13,110,253,0.15);
    outline: none;
  }
    .post-title input[type="text"] {
    width: 100%;
    padding: 0.5rem 1rem;
    font-size: 1rem;
    border: 1px solid #ced4da;
    border-radius: 0.5rem;
  }
    </style>
</head>
<body>
<c:set var="title" value="공지사항 관리"></c:set>
<div class="wrapper">
    <%@ include file="../adminHeader.jsp" %>
    <%@ include file="../adminSidebar.jsp"%>
<form action="/admin/notice/addNoticePost" method="post" enctype="multipart/form-data">
<div class="artist-selector mt-4">
  <label for="categoryArtGroupNo" class="form-label fw-semibold">🎤 아티스트 그룹 선택</label>
  <div class="d-flex align-items-center" style="gap: 10px;">
	  <select id="categoryArtGroupNo" name="artGroupNo" class="form-select" style="width: 80%;">
		  <c:forEach var="item" items="${artGroupList }">
		    <option value="${item.artGroupNo }">${item.artGroupNm }</option>	
		  </c:forEach>					
	  </select>
	  <button type="button" class="btn btn-secondary" onClick="testBtn()">시연용</button>
  </div>
</div>
<div class="post-container">
  <div class="col-md-2 form-group gap-5 mb-1">

  </div>
  <div class="post-title">
	<input type="text" name="bbsTitle" required placeholder="제목을 입력하세요">
  </div>

  <div class="post-content">
      <textarea class="form-control" rows="10" id="post-content" name="bbsCn"  required></textarea>
	  <b class="text-danger fw-bold">&emsp; * 수정시 사진 전체를 새로 업로드 하는 것으로 기존 이미지는 삭제됩니다 * &emsp;</b>
	  
	  <input type="file" id="uploadFile" name="uploadFile" class="form-control"  onchange="readFileExpln(this)" multiple/>
	  
	
		  <div class="mt-3" id="oldImg" style="width:100%; height: 600px; overflow-y: auto; overflow-x:hidden;">

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



// 시연용 버튼 시작
function testBtn() {
	// 아티스트 그룹 '에스파' 선택
	document.getElementById("categoryArtGroupNo").value=1;
	document.getElementById("categoryArtGroupNo").dispatchEvent(new Event("change")); // 강제로 select 박스에 change 이벤트를 발생함 -> 안그럼 내부값만 변경됨
	
	// 제목 입력
	document.querySelector("input[name='bbsTitle']").value="[알림] ‘2025 SMTOWN : THE CULTURE, THE FUTURE’ 발매 기념 ‘특전 증정 EVENT’ 안내 2025.05.07";
	
	// 내용 입력
	let content = ``;
	content += `▶ 응모 기간 : 2025년 6월 7일 (월) ~ 2025년 7월 8일 (금) 23:59 (KST)\n\n`;
	content += `aespa 공식 팬클럽 “MY”에서는 특전 증정 EVENT 진행처(음반사)의 공지로 안내 드리고 있으니 기타 문의 사항은 안내 공지 내 음반사 문의처를 통해 확인해 주시기 바랍니다.\n\n`;
	content += `감사합니다.\n\n`;
	content += `* 애플뮤직\n`;
	content += `🔗 http://www.applemusic.co.kr/board/board.html?code=applemusic_board2&type=v&num1=998076&num2=00000&lock=`;
	
	document.querySelector("textarea[name='bbsCn']").value=content;
}
// 시연용 버튼 끝

</script>
</body>
</html>