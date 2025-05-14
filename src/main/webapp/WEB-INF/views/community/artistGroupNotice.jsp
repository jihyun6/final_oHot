<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@include file="../header.jsp" %>
    
  <title>${artistGroupInfo.artGroupNm} 공지사항</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    html, body {
      height: 100%;
      font-family: 'Noto Sans KR', 'Spoqa Han Sans Neo', 'Apple SD Gothic Neo', sans-serif;
      color: #333;
      background-color: #fff;
    }
    .notice-title {
      font-size: 1.5rem;
      font-weight: 700;
      margin-top: 2rem;
      margin-bottom: 1.5rem;
      text-align: left;
    }
    .notice-item {
      border-bottom: 1px solid #eee;
      padding: 1rem 0;
    }
    .notice-item .title {
      font-weight: 500;
      font-size: 1.05rem;
      margin-bottom: 0.2rem;
    }
    .notice-item .title a {
      color: #222;
      text-decoration: none;
    }
    .notice-item .title a:hover {
      text-decoration: underline;
    }
    .notice-item .date {
      font-size: 0.85rem;
      color: #999;
    }
    .notice-item .new {
      background-color: #ff69b4;
      color: white;
      font-size: 0.7rem;
      padding: 2px 6px;
      border-radius: 10px;
      margin-right: 6px;
    }
    .btn-go-fan {
      background-color: #ff69b4;
      border-color: #ff69b4;
    }
    .btn-go-fan:hover {
      background-color: #ff4da6;
      border-color: #ff4da6;
    }
    .nav-pills .nav-link {
      font-weight: 500;
      color: #555;
    }
    .nav-pills .nav-link.active {
      background-color: #ff69b4;
      color: #fff;
    }
	#pagination {
	  justify-content: center;
	  gap: 8px;
	}
	
	.pagination .page-item .page-link {
	  border: none;
	  border-radius: 50px;
	  padding: 6px 14px;
	  color: #ff69b4;
	  font-weight: 500;
	  background-color: transparent;
	  transition: background-color 0.2s;
	}
	
	.pagination .page-item .page-link:hover {
	  background-color: #ffe6f0;
	  color: #ff69b4;
	}
	
	.pagination .page-item.active .page-link {
	  background-color: #ff69b4;
	  color: white;
	  font-weight: 600;
	}
	
	/* 헤더 네비 디자인 */
  .weverse-tabs {
    background: linear-gradient(90deg, #0f0f2f, #1a1a40); /* 어두운 배경 */
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    padding: 0.75rem 0;
  }

  .weverse-tabs .nav {
    gap: 1.5rem;
  }

  .weverse-tabs .nav-link {
    color: #ccc;
    font-weight: 500;
    font-size: 0.95rem;
    border: none;
    background: transparent;
    border-radius: 2rem;
    padding: 0.4rem 1.2rem;
    transition: all 0.3s ease;
  }

  .weverse-tabs .nav-link:hover {
    color: #fff;
    background-color: rgba(255, 192, 203, 0.1); /* 연한 핑크 호버 효과 */
  }

  .weverse-tabs .nav-link.active {
    background-color: #ff69b4; /* 핫핑크 배경 */
    color: #fff;
    font-weight: 700;
    border-radius: 999px;
    box-shadow: 0 0 10px rgba(255, 105, 180, 0.3);
  }

  @media (max-width: 576px) {
    .weverse-tabs .nav {
      flex-wrap: nowrap;
      overflow-x: auto;
      -webkit-overflow-scrolling: touch;
    }

    .weverse-tabs .nav-link {
      white-space: nowrap;
    }
  }
  </style>
</head>
<body class="d-flex flex-column min-vh-100">
  <!-- 탭 메뉴 -->
 <div class="weverse-tabs d-flex justify-content-center" style="margin-top: 0; padding-top: 1;">
    <ul class="nav nav-pills nav-fill">
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${artistGroupInfo.artGroupNo}">
          Fan
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${artistGroupInfo.artGroupNo}">
          Artist
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${artistGroupInfo.artGroupNo}">
          Media
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${artistGroupInfo.artGroupNo}">
          Live
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/shop/artistGroup?artGroupNo=${artistGroupInfo.artGroupNo}"
           target="_blank">
          Shop
        </a>
      </li>
    </ul>
  </div>


  <%
    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String currentTime = sdf.format(now);
    request.setAttribute("currentTime", currentTime);
  %>

  <!-- 본문 내용 -->
  <main class="flex-grow-1">
    <div class="container px-5 py-5" style="max-width: 100%;">
      <a href="/oho/community/fanBoardList?artGroupNo=${artistGroupInfo.artGroupNo}"
         class="btn rounded-pill px-4 py-2 fw-semibold text-white mb-4"
         style="background-color: #ff69b4; border-color: #ff69b4;">
         ${artistGroupInfo.artGroupNm} 커뮤니티로 가기 →
      </a>

      <div class="notice-title">${artistGroupInfo.artGroupNm} 커뮤니티 공지사항</div>
	  <c:choose>
		<c:when test="${fn:length(noticeList.content) > 0}">
	      <div class="notice-list ">
	        <c:forEach var="item" items="${noticeList.content}">
	          <c:choose>
	            <c:when test="${item.bbsRegDt2 eq currentTime}">
	              <div class="notice-item">
	                <div class="title">
	                  <span class="new">new</span>
	                  <a href="/oho/community/noticeDetail?bbsPostNo=${item.bbsPostNo}">${item.bbsTitle}</a>
	                </div>
	                <div class="date">${item.bbsRegDt2}</div>
	              </div>
	            </c:when>
	            <c:otherwise>
	              <div class="notice-item">
	                <div class="title">
	                  <a href="/oho/community/noticeDetail?bbsPostNo=${item.bbsPostNo}">${item.bbsTitle}</a>
	                </div>
	                <div class="date">${item.bbsRegDt2}</div>
	              </div>
	            </c:otherwise>
	          </c:choose>
	        </c:forEach>
	      </div>
	    </c:when>
	    <c:otherwise>
			 <div class="notice-item text-muted">등록된 공지사항이 없습니다</div>
		</c:otherwise>
      </c:choose>
    </div>
  </main>

  <!-- 하단 고정 페이지네이션 -->
  <footer class="py-3 mt-auto">
    <div class="container d-flex justify-content-center">
      <nav>
        <ul class="pagination" id="pagination">
          <!-- JS에서 페이지네이션 버튼 렌더링 -->
        </ul>
      </nav>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript" src="/js/jquery.min.js"></script>
  <script type="text/javascript">
  $(function(){
	  pagenation();
  })
  
  function pagenation(){
	  let totalPages = ${noticeList.totalPages != null ? noticeList.totalPages : 0};
	  let blockSize = ${noticeList.blockSize != null ? noticeList.blockSize : 10};
	  let startPage = ${noticeList.startPage != null ? noticeList.startPage : 1};
	  let endPage = ${noticeList.endPage != null ? noticeList.endPage : 1};
	  let currentPage = ${noticeList.currentPage != null ? noticeList.currentPage : 1};
	  let artGroupNo = ${artistGroupInfo.artGroupNo};

	  
	  console.log("dfdf",blockSize);
	  let str = "";
	  
	  str +=`<li class="page-item \${currentPage === 1 ? 'disabled' : ''}"><a class="page-link" href="/oho/community/notice?artGroupNo=\${artGroupNo}&currentPage=\${currentPage-1}">&lt</a></li>`;
	  
	  for(let i=startPage; i<=endPage; i++){
		  let active = (i === currentPage) ? "active" : "";
		  str+=`<li class="page-item \${active}"><a class="page-link" href="/oho/community/notice?artGroupNo=\${artGroupNo}&currentPage=\${i}">\${i == 0 ? 1 : i}</a></li>`;
	  }
	  str+=`<li class="page-item \${currentPage === totalPages ? 'disabled' : ''}"><a class="page-link" href="/oho/community/notice?artGroupNo=\${artGroupNo}&currentPage=\${currentPage+1}">&gt</a></li>`;
	  $("#pagination").html(str);
  }
  
  </script>
  <%@include file="../footer.jsp" %> 
  	<!-- Scroll Top -->
	<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
</body>
</html>
