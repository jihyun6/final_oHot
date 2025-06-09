<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
alert("${alertMessage}");

let error = "${referer}";
if(error != 'error'){
	location.href = error;
}else {
	location.href = "/shop/home";
}
</script>
<body>
</body>
</html>