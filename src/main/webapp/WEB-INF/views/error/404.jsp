<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 - 페이지를 찾을 수 없습니다</title>
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
            font-size: 80px;
            margin: 0;
            color: #d9534f;
        }
        h2 {
            font-size: 24px;
            margin: 10px 0 20px;
            color: #5a5a5a;
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
 <h1>404</h1>
    <h2>죄송합니다, 요청하신 페이지를 찾을 수 없습니다.</h2>
    <button onclick="history.back()" class="back-link">이전 페이지로 돌아가기</button>
</body>
</html>