<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <form id="redirectForm" action="/shop/ordersPost" method="post">
        <input type="hidden" name="gdsType" value="${gdsType}" />
        <input type="hidden" name="artGroupNo" value="${artGroupNo}" />
    </form>

    <script type="text/javascript">
        document.getElementById('redirectForm').submit();
    </script>
</body>
</html>