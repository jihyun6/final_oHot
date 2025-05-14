<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oHoT EMP</title>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f4f6f9;
	margin: 0;
	padding: 40px;
}

.card {
	width: 900px;
	margin: auto;
	display: flex;
	background: white;
	border-radius: 20px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
	padding: 30px;
}

.card-left {
	width: 250px;
	text-align: center;
	border-right: 1px solid #e0e0e0;
	padding-right: 30px;
}

.card-left img {
	width: 150px;
	height: 180px;
	object-fit: cover;
	border-radius: 10px;
	border: 1px solid #ddd;
}

.card-left h3 {
	margin-top: 15px;
	font-size: 20px;
}

.card-left p {
	margin-top: 5px;
	color: #666;
	font-size: 14px;
}

.card-right {
	flex: 1;
	padding-left: 30px;
}

.card-right h2 {
	margin-bottom: 20px;
	font-size: 20px;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
}

.info-row {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
	font-size: 16px;
	color: #333;
}

.info-row i {
	width: 24px;
	font-size: 18px;
	color: #555;
	margin-right: 10px;
}

.btn-box {
	margin-top: 30px;
	text-align: right;
}

.btn-box button {
	background: #6366f1;
	color: white;
	border: none;
	border-radius: 8px;
	padding: 8px 20px;
	margin-left: 10px;
	font-size: 14px;
	cursor: pointer;
}

.btn-box button.secondary {
	background: #94a3b8;
}

.btn-box button:hover {
	opacity: 0.9;
}
</style>
</head>
<body class="g-sidenav-show  bg-gray-100">

  <sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO" />
  </sec:authorize>
  <!-- 사이드바 -->
  <%@ include file="../sidebar.jsp"%>
  
  <!-- 컨텐츠 -->
  <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
      <!-- 헤더 -->
      <%@ include file="../header.jsp"%>
        <div class="container-fluid py-2">
            <div class="card shadow rounded-4 p-4">
				<div class="row g-4">
					<!-- Left: Profile -->
					<div class="col-md-4 text-center border-end">
						<c:choose>
	                        <c:when test="${not empty userVO.employeeVO.profileSaveLocate}">
	                            <img src="/upload${userVO.employeeVO.profileSaveLocate}" alt="프로필" class="profile-img" style="width: 200px; height: 300px; object-fit: cover;">
	                        </c:when>
	                        <c:otherwise>
	                            <img src="/images/defaultProfile.jpg" alt="기본 프로필" class="profile-img" style="width: 200px; height: 300px; object-fit: cover;">
	                        </c:otherwise>
                    	</c:choose>
						<h5 class="mb-1 fw-bold">${userVO.employeeVO.empNm}</h5>
						<p class="text-muted mb-0">${userVO.employeeVO.departmentVO.deptNm} | ${userVO.employeeVO.position}</p>
					</div>

					<!-- Right: Info -->
					<div class="col-md-8">
						<h5 class="fw-bold border-bottom pb-2 mb-4">사원 기본 정보</h5>

						<div class="mb-3">
							<i class="bi bi-calendar3 me-2"></i> ${userVO.employeeVO.empBrdt}
						</div>
						<div class="mb-3">
							<i class="bi bi-envelope me-2"></i> ${userVO.employeeVO.empEmlAddr}
						</div>
						<div class="mb-3">
							<i class="bi bi-phone me-2"></i> ${userVO.employeeVO.empTelno}
						</div>
						<div class="mb-3">
							<i class="bi bi-geo-alt me-2"></i> ${userVO.employeeVO.empAddr} ${userVO.employeeVO.empDaddr}
						</div>
						<div class="mb-3">
							<i class="bi bi-credit-card me-2"></i> (국민은행) 123456-78-901234
						</div>
						<div class="mb-3">
							<i class="bi bi-door-open me-2"></i> 입사일 · ${userVO.employeeVO.jncmpYmd}
						</div>

						<!-- Button -->
						<div class="text-end mt-4">
							<button class="btn btn-secondary me-2">수정</button>
							<button class="btn btn-primary">비밀번호 변경</button>
						</div>
					</div>
				</div>
			</div>
        </div>





        <!-- 풋터 -->
        <%@ include file="../footer.jsp"%>
    </main>   

</body>
</html>