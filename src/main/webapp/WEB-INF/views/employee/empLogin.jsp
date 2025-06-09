<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<title>oHoT EMP</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/adminlte/plugins/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="/adminlte/plugins/fontawesome-free/css/all.min.css">
<!-- AdminLTE CSS -->
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css">
</head>
<body class="login-page" style="min-height: 495.6px;">

<c:if test="${not empty param.error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: '로그인 실패',
            text: '${fn:escapeXml(param.error)}',
            confirmButtonText: '확인'
        });
    </script>
</c:if>


<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>oHoT</b> Employee</a>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Sign in to start your session</p>

      <form action="/admin/login" method="post">
      	<input type="hidden" name="redirectURL" value="/emp/login"/>
        <div class="input-group mb-3">
          <input type="email" class="form-control" name="username" placeholder="Email">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="password" placeholder="Password">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                Remember Email
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
          </div>
          <!-- /.col -->
        </div>
        <div class="row">
          <button type="button" onClick="empLogin('Henri@oho.com')" class="col-3 btn btn-secondary m-1">대리</button>
          <button type="button" onClick="empLogin('oho@oho.com')" class="col-3 btn btn-secondary m-1">대표</button>
        </div>
      </form>
	
	
      <p class="mb-1">
        <a href="forgot-password.html">I forgot my Password</a>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<script>
	function empLogin(testId) {
		console.log("체킁");
		const testPswd="java";
		
		const idBox = document.querySelector("input[name=username]");
		const pswdBox = document.querySelector("input[name=password]");
		
		idBox.value = testId;
		pswdBox.value = testPswd;
		
		const loginForm = document.querySelector("form");
		loginForm.submit();
	}
</script>

</body>
</html>