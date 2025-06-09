/**
 * 
 */

// 만 12세 이상 가입 처리
		const birthInput = document.getElementById("memBirth");
		const today = new Date();
		const ageLimit = new Date(today.getFullYear() - 12, today.getMonth(),
				today.getDate());

		const maxDate = ageLimit.toISOString().split('T')[0];
		console.log("maxDate : ", maxDate);
		birthInput.max = maxDate;
		
		// 핸드폰 자동으로 "-"" 입력 / 중복검사 활성화
		const phoneInput = document.getElementById("memTelno");
		

		phoneInput.addEventListener("input", function (e) {
			let value = e.target.value.replace(/[^0-9]/g, ""); // 숫자만 추출

			// 자동 하이픈 처리
			if (value.length < 4) {
			e.target.value = value;
			} else if (value.length < 8) {
			e.target.value = value.slice(0, 3) + "-" + value.slice(3);
			} else {
			e.target.value = value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7, 11);
			}

		});

		// 핸드폰 중복 검사
		function phoneDuplCheck() {

			// 1. 입력값 형식 검사
			const phonePattern = /^010-\d{4}-\d{4}$/;

			console.log("document", phoneInput.value)

			// 1-1. 형식에 일치 할 경우
			if (phonePattern.test(phoneInput.value)) {
				console.log("phoneInput ", phoneInput.value.replace(/-/g, ""));
					console.log("i18n2.telno", i18n2.telno);

				axios.post("/phoneDuplCheck", { memTelno : phoneInput.value.replace(/-/g, "") }).then(resp => {
					console.log("phoneDuplCheck", resp.data);
					
					if(resp.data == "duplicate") { // 중복됨
						duplicated(i18n2.telno);
					} else if(resp.data == "fail") { // 실패
						duplFail(i18n2.telno);
					} else { // 성공!
						duplSuccess(i18n2.telno);
					
					}
				})
			} else { //1-2. 형식에 불일치할 경우
				valiFail(i18n2.telno);
			}
		}

		// 닉네임 중복 검사
		function nickDuplCheck() {

			// 1. 입력값 형식 검사
			const memNicknm = document.getElementById("memNicknm");

			// 1-1. 형식에 일치 할 경우
			if (memNicknm.value.length > 0 && memNicknm.value.length <= 20) {

				axios.post("/nickDuplCheck", { memNicknm : memNicknm.value }).then(resp => {
					console.log("nickDuplCheck : ",resp.data);
					
					if(resp.data == "duplicate") { // 중복됨
						duplicated(i18n2.nicknm);
					} else if(resp.data == "fail") { // 실패
						duplFail();
					} else { // 성공!
						duplSuccess(i18n2.nicknm);
					}
				})
			} else { //1-2. 형식에 불일치할 경우
				valiFail(i18n2.nicknm);
			}
		}
		
		// 이름 입력 + 생년월일 입력 + 중복검사 2개 완료 후 가입 완료 버튼 보이기
		let lastNmEntered = false;
		let firstNmEntered = false;
		let birthEntered = false;
		let phoneChecked = false;
		let nickChecked = false;
		
		const joinBtn = document.getElementById("joinBtn");
		
		// 성 입력 감지
		document.querySelector("input[name='memLastName']").addEventListener("input", function(e) {
			lastNmEntered = e.target.value.trim().length > 0;
		    updateJoinButton();
		});
		// 이름 입력 감지
		document.querySelector("input[name='memFirstName']").addEventListener("input", function(e) {
			firstNmEntered = e.target.value.trim().length > 0;
		    updateJoinButton();
		});

		// 생년월일 입력 감지
		document.querySelector("input[name='memBirth']").addEventListener("change", function(e) {
		    birthEntered = !!e.target.value;
		    updateJoinButton();
		});

		
		// alert 모음
		function valiFail(type) {
			Swal.fire({
				icon: 'warning',
				title: i18n2.valiFailTitle1 + type + i18n2.valiFailTitle2,
				text: i18n2.valiFailText,
				confirmButtonText: i18n2.confirm
			});
		}
		function duplicated(type) {
			console.log("type : ", type);
			Swal.fire({
				icon: 'warning',
				title: i18n2.duplicatedTitle1 + type + i18n2.duplicatedTitle2,
				text: i18n2.duplicatedText1 + type + i18n2.duplicatedText2,
				confirmButtonText: i18n2.confirm
			});
		}
		function duplFail() {
			Swal.fire({
				icon: 'error',
				title: i18n2.duplFailTitle,
				text: i18n2.duplFailText,
				confirmButtonText: i18n2.confirm
			});
		}
		function duplSuccess(type) {
			console.log("type : ", type);
			Swal.fire({
				icon: 'success',
				title: i18n2.duplSuccessTitle1 + type + i18n2.duplSuccessTitle2,
				confirmButtonText: i18n2.confirm
			});
			
			if (type === i18n2.telno) {
		        phoneChecked = true;
		    } else if (type === i18n2.nicknm) {
		        nickChecked = true;
		    }
			
			updateJoinButton();
			
		}
		
		// 버튼 보여줄 조건 확인 함수
		function updateJoinButton() {
		    if (lastNmEntered && firstNmEntered && birthEntered && phoneChecked && nickChecked) {
		        joinBtn.style.visibility = "visible";
		        phoneInput.value = phoneInput.value.replace(/-/g, "")
		    } else {
		        joinBtn.style.visibility = "hidden";
		    }
		}
		
		
	// 엔터 막기
	const inputTags = document.querySelectorAll(".input50");
	if (inputTags) {
		inputTags.forEach(input => {
			input.addEventListener("keydown", function (e) {
				if (e.key === "Enter") {
					e.preventDefault(); // 기본 Enter 동작 막기
				}
			});
		});
	}
	