<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <script>
    // URL 파라미터 가져오기
    const params = new URLSearchParams(window.location.search);
    const from = params.get("from") || "/";
    
console.log("params : " , params) ;
	// 경로에 따라 분기
    let goTo = "/login"; // 기본 로그인 페이지

    if (from.startsWith("/admin")) {
      goTo = "/admin/login";
    } else if (from.startsWith("/emp")) {
      goTo = "/emp/login";
    } else if (from.startsWith("/shop")) {
      goTo = "/shop"; // 혹은 /login 등 적절한 경로
    } else if (from.startsWith("/oho")) {
      goTo = "/login"; // 일반 로그인
    }

    alert("로그인이 필요합니다!");
    location.href = goTo;
  </script>
</body>
</html>