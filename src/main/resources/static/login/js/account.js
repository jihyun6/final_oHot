/*
create your account 클릭 시 해당하는 js
 */

function createAccount() {
				const formDiv = document.getElementById("formDiv");
				formDiv.innerHTML = "";
				
				const accountForm = `
				<div class="wrap-login100" style="padding: 177px 130px 177px 95px;">
					<div class="login100-pic js-tilt" data-tilt="" style="will-change: transform; transform: perspective(300px) rotateX(0deg) rotateY(0deg);">
						<img src="/images/banner1.png" alt="IMG">
					</div>

					<form class="login100-form validate-form" action="/signup" method="post">
					<i class="fa fa-arrow-left" aria-hidden="true" onclick="loginRender()" style="cursor: pointer;"></i>
						<span class="text-center login100-form-title">
							oHoT - ${i18n3.signupTitle}
						</span>
						<br>
						
						<div  id="emailDiv" class="wrap-input100 validate-input" data-validate="Valid email is required: aaa@oho.com">
							<input id="email" class="input100" type="text" name="newEmail" placeholder="your@email.com">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<i class="fa fa-envelope" aria-hidden="true"></i>
							</span>
						</div>
						<button id="valiBtn" type="button" class="btn-getstarted" onclick="emailCheck()">${i18n3.sendCode}</button>
						
						<div id="codeSectionDiv" class="wrap-input100 validate-input" data-validate="Password is required" style="display:none;">
							<input id="authCode" class="input100" placeholder="${i18n3.enterCode}">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</span>
						</div>
						<p id="timer" style="text-align: center; margin: 10px 0; font-weight: bold; color: #f86d72;"></p>
						<button id="verifyCodeBtn" type="button" class="btn-getstarted" style="display:none;">${i18n3.checkCode}</button>
						
						<div id="newPwDiv" class="wrap-input100 validate-input" data-validate="Password is required" style="display:none;">
							<input id="newPw" class="input100" type="password" name="newPassword" autocomplete="current-password" placeholder="${i18n3.pswd}">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</span>
							<span onclick="togglePassword(this)" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;">
						        <i id="eyeIcon" class="fa fa-eye-slash" aria-hidden="true"></i>
						    </span>
						</div>

						<ul id="pwRules" style="display:none;">
						  <li id="rule-length" class="txt1 rule">${i18n3.pswdVali1}</li>
						  <li id="rule-letter" class="txt1 rule">${i18n3.pswdVali2}</li>
						  <li id="rule-number" class="txt1 rule">${i18n3.pswdVali3}</li>
						  <li id="rule-special" class="txt1 rule">${i18n3.pswdVali4}</li>
						</ul>

						
						<div id="pwConfirmDiv" class="wrap-input100 validate-input" data-validate="Password is required" style="display:none;">
							<input id="pwConfirm" class="input100" type="password" autocomplete="current-password" placeholder="${i18n3.reEnterPswd}">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</span>
							<span onclick="togglePassword(this)" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;">
						        <i id="eyeIcon" class="fa fa-eye-slash" aria-hidden="true"></i>
						    </span>
						</div>
						<p id="pwMsg" class="txt1" style="margin-left:29px;"></p>

						<div class="container-login100-form-btn">
							<button id="next" class="login100-form-btn" style="visibility: hidden;">
								${i18n3.next}
							</button>
						</div>
					</form>
				</div>
				`;

				formDiv.innerHTML = accountForm;
				
				// 엔터 막기
				const emailInput = document.getElementById("email");
				const authCode = document.getElementById("authCode");
				const newPw = document.getElementById("newPw");
				const pwConfirm = document.getElementById("pwConfirm");
				if (emailInput) {
					emailInput.addEventListener("keydown", function (e) {
						if (e.key === "Enter") {
							e.preventDefault();
							document.getElementById("valiBtn").click();
						}
					});
				}
				if (authCode) {
					authCode.addEventListener("keydown", function (e) {
						if (e.key === "Enter") {
							e.preventDefault();
							document.getElementById("verifyCodeBtn").click();
						}
					});
				}
				if (newPw) {
					newPw.addEventListener("keydown", function (e) {
						if (e.key === "Enter") {
							e.preventDefault();
						}
					});
				}
				if (pwConfirm) {
					pwConfirm.addEventListener("keydown", function (e) {
						if (e.key === "Enter") {
							e.preventDefault();
						}
					});
				}
				
			}
			
			
			function emailCheck() {
				const email = $("#email").val();
				console.log("loginform : ", email);
			
				// 이메일이 양식에 맞을 경우
				if(email.trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/)){
					
					console.log("email : ", email);
					
					
					// 이메일 중복 체크
					axios.post("/emailCheck", {email}).then(result => {
						console.log("result : ", result.data);
						
						// 중복체크 통과 (새로운 회원)
						if(result.data == "success") {
							
							// 인증 발송 버튼 비활성화
							document.getElementById("valiBtn").disabled = true;
							document.getElementById("valiBtn").style.background = "#333333";
							
							Swal.fire({
							  title: i18n3.sending,
							  html: '<img src="/images/web-5811_256.gif" width="80"><br>'+i18n3.wait,
							  showConfirmButton: false,
							  allowOutsideClick: false
							});

							
							// 1. 인증코드 발송
						 	axios.post("/sendCode", { email }).then(resp => {
								console.log("resp : ", resp);
								
								Swal.close();
								
								// 1-1. 발송 성공 alert
								sendSuccess();
								// 1-2. 인증유효시간 타이머
								startCountdown(180);
								// 1-3. 이메일 입력창 readonly
								$("#email").attr("readonly", true);
								// 1-4. 인증번호 발송 버튼 지우기
								document.getElementById("valiBtn").remove();
								// 1-5. 인증코드 입력창 활성화
								document.getElementById("codeSectionDiv").style.display = "block";
								// 1-6. 인증확인 버튼 활성화
								document.getElementById("verifyCodeBtn").style.display = "block";
								
							}).catch(()=> {
								sendFail();
							});
							
							// 2. 인증번호 확인 여부
							document.getElementById("verifyCodeBtn").addEventListener("click", handleVerifyCode);
							
							async function handleVerifyCode() {
								const email = document.getElementById("email").value;
	  							const code = document.getElementById("authCode").value;
								
								try{
									const resp = await axios.post("/verifyCode", { email, code });
									console.log("verifyCode : ", resp.data);
									
									if (resp.data === "timeOut") {
										timeOut();
										return;
									} else if (resp.data === "fail") {
										verifyFail();
										return;
									}
									// 인증 성공
									verifySuccess();
									
									// 2-1. 인증번호 입력창, 인증확인 버튼 지우기
									document.getElementById("codeSectionDiv").remove();
									document.getElementById("verifyCodeBtn").remove();
									// 2-2. 타이머 지우기
									document.getElementById("timer").remove();
									// 2-3. 비밀번호, 유효성문구, 재입력창 활성화
									document.getElementById("newPwDiv").style.display = "block";
									document.getElementById("pwRules").style.display = "block";
	 								document.getElementById("pwConfirmDiv").style.display = "block";
									// 2-4. 비밀번호 유효성검사
									pwValiCheck();
	 								
	 								// 2-5. 비밀번호 / 재입력 일치 여부 체크
									pwCheck();

								}catch (error) {
									console.error("인증 실패:", error);
									serverError();
								}
							}
							
						}else { // 메일 중복 미통과 (기존 회원)
							alMail(); // 사용 불가 alert
							
							// 인증 발송 버튼 활성화
							document.getElementById("valiBtn").style.background = "#f86d72";
							document.getElementById("valiBtn").disabled = false;
						}
					})
					
				// 이메일이 양식에 맞지 않을 경우
				}else{
					Swal.fire({
			            icon: 'warning',
			            title: 'Oops..',
			            text: i18n3.emailFormatCheck,
			            confirmButtonText: i18n3.confirm
			        });
				}
			}
			
			let isPwValid = false;

			// 비밀번호 유효성 체크
			function pwValiCheck() {
				const newPwInput = document.getElementById("newPw");

				newPwInput.addEventListener("input", function () {
					const pw = this.value;

					const ruleLength = document.getElementById("rule-length");
					const ruleLetter = document.getElementById("rule-letter");
					const ruleNumber = document.getElementById("rule-number");
					const ruleSpecial = document.getElementById("rule-special");

					// 유효성 조건
					const isLengthOk = pw.length >= 8 && pw.length <= 32;
					const hasLetter = /[a-zA-Z]/.test(pw);
					const hasNumber = /[0-9]/.test(pw);
					const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pw);

					// 각각 조건에 따라 색 변경
					isLengthOk ? ruleLength.classList.add("valid") : ruleLength.classList.remove("valid");
					hasLetter ? ruleLetter.classList.add("valid") : ruleLetter.classList.remove("valid");
					hasNumber ? ruleNumber.classList.add("valid") : ruleNumber.classList.remove("valid");
					hasSpecial ? ruleSpecial.classList.add("valid") : ruleSpecial.classList.remove("valid");

					// 유효성 통과 여부 저장
					isPwValid = isLengthOk && hasLetter && hasNumber && hasSpecial;

					// 비밀번호 재입력 체크 다시 실행
					checkPwMatch(); // 아래 함수로 분리
				});
			}

			// 비밀번호/비밀번호 재입력 체크 함수
			function pwCheck() {
				const pwConfirm = document.getElementById("pwConfirm");
				// checkPwMatch 콜백함수로서 참조
				pwConfirm.addEventListener("input", checkPwMatch);
			}

			function checkPwMatch() {
				const newPw = document.getElementById("newPw").value;
				const pwConfirm = document.getElementById("pwConfirm").value;
				const pwMsg = document.getElementById("pwMsg");
				const next = document.getElementById("next");

				if (pwConfirm === "") {
					pwMsg.textContent = "";
					next.style.visibility = "hidden";
					return;
				}

				if (pwConfirm === newPw) {
					if (isPwValid) {
						pwMsg.textContent = i18n3.pswdMatchO;
						pwMsg.style.color = "green";
						next.style.visibility = "visible";
					} else {
						pwMsg.textContent = i18n3.pswdFormatCheck;
						pwMsg.style.color = "red";
						next.style.visibility = "hidden";
					}
				} else {
					pwMsg.textContent = i18n3.pswdMatchX;
					pwMsg.style.color = "red";
					next.style.visibility = "hidden";
				}
			}

			
			// 인증코드 유효시간 카운트 다운
			let timerInterval;

			function startCountdown(durationInSeconds) {
				const display = document.getElementById("timer");
				let time = durationInSeconds;

				clearInterval(timerInterval); // 혹시 이전 타이머가 있으면 제거

				timerInterval = setInterval(() => {
					const minutes = Math.floor(time / 60);
					const seconds = time % 60;
					display.textContent = `${i18n3.timer}: ${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;

					if (--time < 0) {
						clearInterval(timerInterval);
						display.textContent = "⏰"+i18n3.timeOut+"!";
					}
				}, 1000);
			}
			
			
			// 비밀번호 보이기/ 숨기기
			function togglePassword(iconSpan) {
				const input = iconSpan.parentElement.querySelector('input');
				const eyeIcon = iconSpan.querySelector('i');

				if (input.type === "password") {
					input.type = "text";
					eyeIcon.classList.remove("fa-eye-slash");
					eyeIcon.classList.add("fa-eye");
				} else {
					input.type = "password";
					eyeIcon.classList.remove("fa-eye");
					eyeIcon.classList.add("fa-eye-slash");
				}
			}
			
			// login 리렌더링
			function loginRender() {
				window.location.href = "/login";
			}
			
			
			///////////// alert 모음
			
			function newMail() {
				Swal.fire({
		            icon: 'success',
		            title: i18n3.newMailTitle,
		            text: i18n3.newMailText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function alMail() {
				Swal.fire({
		            icon: 'warning',
		            title: i18n3.alMailTitle,
		            text: i18n3.alMailText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function sendSuccess() {
				Swal.fire({
		            icon: 'success',
		            title: i18n3.sendSuccessTitle,
		            text: i18n3.sendSuccessText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function sendFail() {
				Swal.fire({
		            icon: 'error',
		            title: i18n3.sendFailTitle,
		            text: i18n3.sendFailText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function timeOut() {
				Swal.fire({
		            icon: 'error',
		            title: i18n3.timeOutTitle,
		            text: i18n3.timeOutText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function verifyFail() {
				Swal.fire({
		            icon: 'error',
		            title: i18n3.verifyFailTitle,
		            text: i18n3.verifyFailText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function verifySuccess() {
				Swal.fire({
		            icon: 'success',
		            title: i18n3.verifySuccessTitle,
		            text: i18n3.verifySuccessText,
		            confirmButtonText: i18n3.confirm
		        });
			}
			
			function serverError() {
				Swal.fire({
					icon: 'error',
					title: i18n3.serverErrorTitle,
					text: i18n3.serverErrorText,
					confirmButtonText: i18n3.confirm
				});
			}
			
