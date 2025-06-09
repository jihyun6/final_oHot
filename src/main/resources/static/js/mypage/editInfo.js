
/* 마이페이지 변경 비동기 */
function editAccess({type, info1, info2}) {
 		console.log("type 데이터 봅시다. ", type);
 		console.log("info1 데이터 봅시다. ", info1);
 		console.log("info2 데이터 봅시다. ", info2);
 		
 		const data = {
 				type : type
 				, info1 : info1
				, info2 : info2
 		}
 		
 		axios.put("/oho/mypage/editInfo", data).then(resp => {
 			console.log("변경 됐나? ", resp.data);
 			if(resp.data == "success") {
 				editSuccess();
 			}else{
 				editFail();
 			}
 		})
 	}
 
// alert 시작

function valiFail(type) { // 유효성 검증 실패
			Swal.fire({
				icon: 'warning',
				title: i18n5.valiFailTitle1 + type + i18n5.valiFailTitle2,
				text: i18n5.valiFailText,
				confirmButtonText: i18n5.confirm
			});
		}
		
function duplicated(type) { // 중복되는 정보
	console.log("type : ", type);
	Swal.fire({
		icon: 'warning',
		title: i18n5.duplicatedTitle1 + type + i18n5.duplicatedTitle2,
		text: i18n5.duplicatedText1 + type + i18n5.duplicatedText2,
		confirmButtonText: i18n5.confirm
	});
}
function duplFail() { // 중복검사 시 에러 났을 경우
	Swal.fire({
		icon: 'error',
		title: i18n5.duplFailTitle,
		text: i18n5.duplFailText,
		confirmButtonText: i18n5.confirm
	});
}
function duplSuccess(type) { // 중복 검사 성공
	console.log("type : ", type);
	Swal.fire({
		icon: 'success',
		title: i18n5.duplSuccessTitle1 + type + i18n5.duplSuccessTitle2,
		confirmButtonText: i18n5.confirm
	});
	
}   

function editSuccess() { // 수정 성공
	Swal.fire({
		icon: 'success',
		title: i18n5.editSuccess,
		confirmButtonText: i18n5.confirm
	}).then(() => {
		// 확인 버튼 누른 후 실행
		location.href = "/oho/mypage";
	});
}
function editFail() { // 수정 실패
	Swal.fire({
		icon: 'error',
		title: i18n5.editFailTitle,
		text: i18n5.editFailText,
		confirmButtonText: i18n5.confirm
	});
}