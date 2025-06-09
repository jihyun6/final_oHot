<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>오류가 발생했습니다</title>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            text-align: center;
            padding-top: 100px;
        }
        .error-container {
            background-color: #fff;
            display: inline-block;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 50px;
            color: #d9534f;
            margin: 0 0 10px;
        }
        h2 {
            font-size: 24px;
            color: #5a5a5a;
        }
        p {
            margin-top: 20px;
            font-size: 16px;
            color: #777;
        }
        a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link {
	      border:none;
	      padding: 10px 20px;
	      background: #007bff;
	      color: #fff;
	      text-decoration: none;
	      border-radius: 8px;
	    }
	    .back-link:hover {
	      background: #0056b3;
	    }
    </style>
</head>
<body>
 <div class="error-container">
    <h1>에러 발생 😢</h1>
    <h2>죄송합니다. 예상치 못한 오류가 발생했습니다.</h2>
    <p>잠시 후 다시 시도해 주세요.</p>
        <button onclick="history.back()" class="back-link">이전 페이지로 돌아가기</button>
    <p style="margin-top:30px; font-size:14px;">
        오류 상태 코드: <strong><%= request.getAttribute("javax.servlet.error.status_code") %></strong><br>
        요청 URL: <strong><%= request.getAttribute("javax.servlet.error.request_uri") %></strong>
    </p>
</div>
</body>
</html>