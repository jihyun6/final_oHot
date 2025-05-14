/**
 * 
 */

function editNicknm() {
	const editNickModal = document.getElementById("editNickModal");
	editNickModal.style.display = "flex";  // 모달을 보이도록 설정
}

function editName() {
	const editNameModal = document.getElementById("editNameModal");
	editNameModal.style.display = "flex";  // 모달을 보이도록 설정
}

function editPswd() {
	const editPswdModal = document.getElementById("editPswdModal");
	editPswdModal.style.display = "flex";  // 모달을 보이도록 설정
}

function editTelno() {
	const editTelnoModal = document.getElementById("editTelnoModal");
	editTelnoModal.style.display = "flex";  // 모달을 보이도록 설정
}


document.getElementById("myLogout").addEventListener("click", function(e){
   e.preventDefault();
   document.getElementById("logoutForm").submit();
});

function memberDelete() {
   Swal.fire({
     title: '정말 탈퇴하시겠습니까?',
     text: '탈퇴 후에는 계정을 복구할 수 없습니다.',
     icon: 'warning',
     showCancelButton: true,
     confirmButtonColor: '#d33',
     cancelButtonColor: '#aaa',
     confirmButtonText: '네, 탈퇴할게요',
     cancelButtonText: '아니요, 취소할게요'
   }).then((result) => {
     if (result.isConfirmed) {
       document.getElementById("deleteForm").submit();
     }
   });
 }

 /////초기 렌더링////
myProfile();

function myProfile() {
	
	 axios.get("/oho/mypage/getMyInfo").then(resp => {
		console.log("결과값 : ", resp.data);
		const memberVO = {
		        memEmail: resp.data.memEmail,
		        memNicknm: resp.data.memNicknm,
		        memLastName: resp.data.memLastName,
		        memFirstName: resp.data.memFirstName,
		        memTelno: resp.data.memTelno
		    };
			
		console.log("memberVO : ", resp.data);
		
		const mypageCard = document.getElementById("mypageCard");
			let mypageHtml = ``;

			mypageHtml = `
				<h2>${mypage_i18n.profile}</h2>
				<br>
				<h5>${mypage_i18n.email}</h5>
				<div class="row mb-4">
				<input class="memberInfo col-11" value="${memberVO.memEmail}" disabled>
				</div>
				<h5>${mypage_i18n.nicknm}</h5>
				<div class="row mb-4">
			    	<input class="memberInfo col-11" value="${memberVO.memNicknm}" disabled />
			   		<button class="changeBtn col-1" onClick="editNicknm()">
			   			${mypage_i18n.editBtn}
			   		</button>
				</div>
				
				<h5>${mypage_i18n.name}</h5>
				<div class="row mb-4">
			    	<input class="memberInfo col-11" value="${memberVO.memLastName} ${memberVO.memFirstName }" disabled />
			    	<button class="changeBtn col-1" onClick="editName()">
			    		${mypage_i18n.editBtn}
			    	</button>
				</div>
				<h5>${mypage_i18n.pswd}</h5>
				<div class="row mb-4">
					<input class="memberInfo col-11" value="●●●●●●●●●" disabled />
					<button class="changeBtn col-1" onClick="editPswd()">
						${mypage_i18n.editBtn}
					</button>
				</div>
				<h5>${mypage_i18n.telno}</h5>
				<div class="row">
			    	<input class="memberInfo col-11" value="${memberVO.memTelno}" disabled />
			    	<button class="changeBtn col-1" onClick="editTelno()">
			    		${mypage_i18n.editBtn}
			    	</button>
				</div>
			`;
			
			mypageCard.innerHTML = mypageHtml;
	});
	
 	
}

 
function myInquiyPost(page) {
   const blockSize = 10;

   const params = {
     page: page,
     blockSize: blockSize,
     start: (page - 1) * blockSize + 1,
     end: page * 5
   }

   console.log("params 체크 : ", params);

   axios.get("/oho/mypage/getMyInquiryPost", { params }).then(resp => {
     console.log("문의함 데이터 : ", resp.data);

     const { content, currentPage, totalPages, startPage, endPage } = resp.data;
     renderInquiryPost(content);
     // DOM이 업데이트된 후에 페이지네이션 렌더링을 위해 setTimeout 사용
     setTimeout(() => {
       renderPagination({currentPage, totalPages, startPage, endPage});
     }, 0);
   })
 }

 function renderInquiryPost(data) {
   const mypageCard = document.getElementById("mypageCard");
   mypageCard.innerHTML = "";

   console.log("renderTable 실행 : ", data);

   let html = ``;
   html += `
   <div class="inquiry-container">
	   <h2>내 문의함</h2>
	   <br>
	   <div class="row mb-2">
	   		<div class="col-2 ms-2"><h5>순번</h5></div>
	   		<div class="col-7"><h5>제목</h5></div>
	   		<div class="col-2"><h5>등록일</h5></div>
	   </div> 
   `;

   if(data.length == 0) {
     html += `
     <a class="inquiryPostBtn">
       등록된 문의글이 없습니다.
     </a>
     `
   } else {
     data.forEach(board => {
       console.log("board : ", board);


       html += `
       <a class="inquiryPostBtn mb-4" href="/oho/inquiryPost/detail?boardNo=${board.bbsPostNo}">
         <div class="row">
           <div class="col-2">${board.rnum}</div>
           <div class="col-7" style="text-align:left;">${board.bbsTitle}</div>
           <div class="col-3">${board.bbsRegYmd}</div>
         </div>
       </a>
       `
     })
   }

   // 페이지네이션 컨테이너를 명확히 구분
   html += `
   </div>
   <div id="pagination-container" class="col-11 d-flex justify-content-center mt-3 ps-5"></div>
   `;
   mypageCard.innerHTML = html;
 }

 function renderPagination(paging) {
   let blockSize = 10;
   console.log("renderPagination실행 data: ", paging);

   const container = document.getElementById("pagination-container");
   
   // 컨테이너가 존재하는지 확인
   if (!container) {
     console.error("페이지네이션 컨테이너를 찾을 수 없습니다.");
     return;
   }
   
   container.innerHTML = "";

   if (!paging || paging.totalPages === 0) {
     return;
   }

   const totalPages = paging.totalPages;
   let startPage = Math.floor((paging.currentPage - 1) / blockSize) * blockSize + 1;
   let endPage = startPage + blockSize - 1;
   
   console.log("totalPages : ", totalPages);
   console.log("startPage : ", startPage);
   console.log("endPage : ", endPage);

   if (endPage > totalPages) {
     endPage = totalPages;
   }

   let html = '<ul class="pagination">';

   const disabledFirst = startPage <= 1 ? 'disabled' : '';
   const disabledLast = endPage >= totalPages ? 'disabled' : '';

   // fn_search 대신 myInquiyPost 함수 호출로 수정
   html += `<li class="page-item ${disabledFirst}">
     <a class="page-link" href="javascript:void(0)" onclick="myInquiyPost(1); return false;"><<</a></li>`;
   html += `<li class="page-item ${disabledFirst}">
     <a class="page-link" href="javascript:void(0)" onclick="myInquiyPost(${paging.currentPage - 1}); return false;"><</a></li>`;

   for (let i = startPage; i <= endPage; i++) {
     const active = i === paging.currentPage ? 'active' : '';
     html += `<li class="page-item ${active}">
       <a class="page-link" href="javascript:void(0)" onclick="myInquiyPost(${i}); return false;">${i}</a></li>`;
   }

   html += `<li class="page-item ${disabledLast}">
     <a class="page-link" href="javascript:void(0)" onclick="myInquiyPost(${paging.currentPage + 1}); return false;">></a></li>`;
   html += `<li class="page-item ${disabledLast}">
     <a class="page-link" href="javascript:void(0)" onclick="myInquiyPost(${totalPages}); return false;">>></a></li>`;

   html += '</ul>';

   container.innerHTML = html;
 }