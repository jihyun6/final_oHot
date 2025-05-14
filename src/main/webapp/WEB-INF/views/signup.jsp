<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<title>oHoT</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="/login/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/login/css/util.css">
<link rel="stylesheet" type="text/css" href="/login/css/main.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<!-- header.jsp 시작 -->
	<%@ include file="header.jsp"%>
	
<c:if test="${param.error eq 'true'}">
	<script>
	    Swal.fire({
	        icon: 'error',
	        title: <spring:message code="alert.signupFail.title" />,
	        text: <spring:message code="alert.signupFail.text" />,
	        confirmButtonText: <spring:message code="alert.confirm" />
	    });
	</script>
</c:if>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<%-- ${userVO} --%>
<%-- ${userVO.userMail} --%>
<%-- ${userVO.userPswd} --%>
${memEmail}
	<div class="limiter">
		<div id="formDiv" class="container-login100">
			<div class="wrap-sign100">
				<form class="sign100-form" action="/signupAccess" method="post">
					<input type="hidden" name="memEmail" value="${memEmail}" />
					<input type="hidden" name="memPswd" value="${memPswd}" />
					<input type="hidden" name="snsMemYn" value="${snsMemYn}" />
					<span class="text-center login100-form-title">
						oHoT - <spring:message code="oho.account" />
					</span>
					<h2><spring:message code="account.title" /></h2>
					<span><spring:message code="account.text" /></span> <br> <br>
					<!-- 이름(성) -->
					<div class="wrap-input100">
						<label for="memLastName"><spring:message code="signup.lastnm" /></label>
						<div class="input-with-btn">
							<input class="input50" type="text" name="memLastName"
								placeholder="<spring:message code="signup.lastnm.ex" />">
							<div style="width: 90px;"></div>
						</div>
					</div>
					<!-- 이름(이름) -->
					<div class="wrap-input100">
						<label for="memFirstName"><spring:message code="signup.firstnm" /></label>
						<div class="input-with-btn">
							<input class="input50" type="text" name="memFirstName"
								placeholder="<spring:message code="signup.firstnm.ex" />">
							<div style="width: 90px;"></div>
						</div>
					</div>

					<!-- 생년월일 -->
					<div class="wrap-input100">
						<label for="memBirth"><spring:message code="signup.birth" />
							&nbsp;&nbsp;<small style="color: #aaa;"><spring:message code="signup.birth.text" /></small>
						</label>
						<div class="input-with-btn">
							<input type="date" id="memBirth" name="memBirth" class="input50">
							<div style="width: 90px;"></div>
							<!-- 동일하게 맞추기 -->
						</div>
					</div>

					<!-- 핸드폰번호 -->
					<div class="wrap-input100">
						<label for="memTelno"><spring:message code="signup.telno" /></label>
						<div class="input-with-btn">
							<input class="input50" type="text" name="memTelno" id="memTelno" 
									maxlength="13" placeholder="010-0000-0000">
							<button type="button" class="btn-getstarted" id="checkPhoneBtn" onClick="phoneDuplCheck()" style="display: block">
								<spring:message code="signup.dupl.btn" />
							</button>
						</div>
					</div>

					<!-- 닉네임 -->
					<div class="wrap-input100">
						<label for="nickname"><spring:message code="signup.nicknm" /></label>
						<div class="input-with-btn">
							<input id="memNicknm" class="input50" type="text" name="memNicknm"
								placeholder="<spring:message code="signup.nicknm.text" />" maxlength="20">
							<button id="checkNickBtn" type="button" class="btn-getstarted"
										 onClick="nickDuplCheck()" style="visibility: visible">
										 <spring:message code="signup.dupl.btn" />
							</button>
						</div>
					</div>

					<div class="container-login100-form-btn">
						<button id="joinBtn" class="login100-form-btn" style="visibility: hidden">
							<spring:message code="signup.complete" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
	const i18n2 = {
		telno: "<spring:message code='signup.telno'/>",
		nicknm: "<spring:message code='signup.nicknm'/>",
		nicknmText: "<spring:message code='signup.nicknm.text'/>",
		valiFailTitle1: "<spring:message code='alert.valiFail.title1'/>",
		valiFailTitle2: "<spring:message code='alert.valiFail.title2'/>",
		valiFailText: "<spring:message code='alert.valiFail.text'/>",
		duplicatedTitle1: "<spring:message code='alert.duplicated.title1'/>",
		duplicatedTitle2: "<spring:message code='alert.duplicated.title2'/>",
		duplicatedText1: "<spring:message code='alert.duplicated.text1'/>",
		duplicatedText2: "<spring:message code='alert.duplicated.text2'/>",
		duplFailTitle: "<spring:message code='alert.duplFail.title'/>",
		duplFailText: "<spring:message code='alert.duplFail.text'/>",
		duplSuccessTitle1: "<spring:message code='alert.duplSuccess.title1'/>",
		duplSuccessTitle2: "<spring:message code='alert.duplSuccess.title2'/>",
		confirm: "<spring:message code='alert.confirm' />"
	}
	</script>

	<%@ include file="footer.jsp"%>
	<script src="/login/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="/login/vendor/bootstrap/js/popper.js"></script>
	<script src="/login/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="/login/vendor/select2/select2.min.js"></script>
	<script src="/login/vendor/tilt/tilt.jquery.min.js"></script>
	<script src="/login/js/main.js"></script>
	<script src="/login/js/signup.js"></script>
</body>
</html>