<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>oHoT</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="/login/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="/login/css/util.css">
	<link rel="stylesheet" type="text/css" href="/login/css/main.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
<!-- header.jsp 시작 -->
<%@ include file="header.jsp" %>

<c:if test="${param.signup eq 'true'}">

<spring:message var="signupSuccessTitle" code="alert.signupSuccess.title" />
<spring:message var="signupSuccessText" code="alert.signupSuccess.text" />
<spring:message var="confirmText" code="alert.confirm" />
	<script>
	    Swal.fire({
	        icon: 'success',
	        title: '${signupSuccessTitle}',
	        text:  '${signupSuccessText}',
	        confirmButtonText: '${confirmText}'
	    });
	</script>
</c:if>
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

<%-- <c:if test="${not empty param.error}"> --%>
<%--     <div class="error">${param.error}</div> --%>
<%-- </c:if> --%>

<div class="limiter">
		<div  id="formDiv" class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt="" style="will-change: transform; transform: perspective(300px) rotateX(0deg) rotateY(0deg);">
					<img src="/images/banner1.png" alt="IMG">
				</div>
				
					<form class="login100-form validate-form" action="/login" method="post">
						<sec:csrfInput />
						<input type="hidden" name="redirectURL" value="${param.redirectURL}" /> <!-- 리다이렉트 URL을 hidden으로 보냄 -->
						<span class="text-center login100-form-title">
							oHoT - <spring:message code="signin" />
						</span>
						<br>
						<div class="wrap-input100 validate-input" data-validate="Valid email is required: aaa@oho.com">
							<input class="input100" type="text" name="username" autocomplete="email" placeholder="your@email.com">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<i class="fa fa-envelope" aria-hidden="true"></i>
							</span>
						</div>
	
						<div class="wrap-input100 validate-input" data-validate="Password is required" style="position: relative;">
						    <input id="passwordInput" class="input100" type="password" name="password" autocomplete="current-password" placeholder=<spring:message code="password" />>
						    <span class="focus-input100"></span>
						    <span class="symbol-input100">
						        <i class="fa fa-lock" aria-hidden="true"></i>
						    </span>
						    <span onclick="togglePassword(this)" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;">
						        <i id="eyeIcon" class="fa fa-eye-slash" aria-hidden="true"></i>
						    </span>
						</div>

						
						<div class="container-login100-form-btn">
							<button class="login100-form-btn">
								<spring:message code="signin" />
							</button>
						</div>
						
						<div class="text-center p-t-12">
							<span class="txt1">
								<spring:message code="forget" />
							</span>
							<a class="txt2" href="#">
								<spring:message code="forget.password" />
								<spring:message code="forget.pswd" />
							</a>
						</div>
						
						<br/> 
						<div class="text-center txt3">
							- or -
						</div>
						<div class="container-login100-form-btn">
							<a href="/oauth2/authorization/kakao">
								<img src="/images/kakao_login_medium_narrow.png">
							</a>
						</div>
						<div class="d-flex mt-2 ms-5">
							<button class="btn btn-sm btn-secondary ms-2" style="width: 40%;" id="artLogin">
								아티스트
							</button>
						</div>
	
						<div class="text-center p-t-20">
							<a class="txt2" style="cursor: pointer;" onclick="createAccount()">
								<spring:message code="create.account" />
								<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
							</a>
						</div>
					</form>
			</div>
		</div>
	</div>

	<script>
	const i18n3 = {
			signupTitle: "<spring:message code='signup'/>",
			sendCode: "<spring:message code='send.code'/>",
			timer: "<spring:message code='timer'/>",
			enterCode: "<spring:message code='enter.code'/>",
			checkCode: "<spring:message code='check.code'/>",
			pswd: "<spring:message code='password'/>",
			reEnterPswd: "<spring:message code='re.enter.pswd'/>",
			pswdMatchO: "<spring:message code='pswd.match.o'/>",
			pswdMatchX: "<spring:message code='pswd.match.x'/>",
			next: "<spring:message code='next'/>",
			pswdFormatCheck: "<spring:message code='pswd.format.check'/>",
			timeOut: "<spring:message code='timeOut'/>",
			emailFormatCheck: "<spring:message code='email.format.check'/>",
			sending: "<spring:message code='sending.email'/>",
			wait: "<spring:message code='wait'/>",
			pswdVali1: "<spring:message code='pswd.vali.1'/>",
			pswdVali2: "<spring:message code='pswd.vali.2'/>",
			pswdVali3: "<spring:message code='pswd.vali.3'/>",
			pswdVali4: "<spring:message code='pswd.vali.4'/>",
			confirm: "<spring:message code='alert.confirm'/>",
			newMailTitle: "<spring:message code='alert.newMail.title'/>",
			newMailText: "<spring:message code='alert.newMail.text'/>",
			alMailTitle: "<spring:message code='alert.alMail.title'/>",
			alMailText: "<spring:message code='alert.alMail.text'/>",
			sendSuccessTitle: "<spring:message code='alert.sendSuccess.title'/>",
			sendSuccessText: "<spring:message code='alert.sendSuccess.text'/>",
			sendFailTitle: "<spring:message code='alert.sendFail.title'/>",
			sendFailText: "<spring:message code='alert.sendFail.text'/>",
			timeOutTitle: "<spring:message code='alert.timeOut.title'/>",
			timeOutText: "<spring:message code='alert.timeOut.text'/>",
			verifyFailTitle: "<spring:message code='alert.verifyFail.title'/>",
			verifyFailText: "<spring:message code='alert.verifyFail.text'/>",
			verifySuccessTitle: "<spring:message code='alert.verifySuccess.title'/>",
			verifySuccessText: "<spring:message code='alert.verifySuccess.text'/>",
			serverErrorTitle: "<spring:message code='alert.serverError.title'/>",
			serverErrorText: "<spring:message code='alert.serverError.text'/>",
		};
	
	document.getElementById("artLogin").addEventListener("click", ()=>{
		document.querySelector("input[name=username]").value="jh@oho.com";
		document.querySelector("input[name=password]").value="java";
	});
	
	
	</script>
<%@ include file="footer.jsp" %>
<script src="/login/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="/login/vendor/bootstrap/js/popper.js"></script>
<script src="/login/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="/login/vendor/select2/select2.min.js"></script>
<script src="/login/vendor/tilt/tilt.jquery.min.js"></script>
<script>
		$('.js-tilt').tilt({
			scale: 1.1
		})
</script>
<script src="/login/js/main.js"></script>
<script src="/login/js/account.js"></script>
</body>
</html>