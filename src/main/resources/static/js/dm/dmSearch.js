/**
 *  검색에 관한 js
 */

 
 const dmsearchIcon = document.getElementById("dmsearchIcon");
 const dmsearchBox = document.getElementById("dmsearchBox");
 const dmsearchInput = document.getElementById("dmsearchInput");
 const dmsearchResults = document.getElementById("dmsearchResults");
 
 // 검색 아이콘 클릭 시 입력창 보여주기
 dmsearchIcon.addEventListener("click", () => {
   dmsearchIcon.style.display = "none";
   dmsearchBox.style.display = "block";
   dmsearchInput.focus();
 });
 
 
 let dmdebounceTimer;
 
 // 검색 입력 시 드롭다운 결과 표시
 dmsearchInput.addEventListener("input", function () {
   const keyword = this.value.trim();
   //console.log("검색된 키워드1 : ", keyword);
   
   // 이전 타이머 제거
   clearTimeout(dmdebounceTimer);
   
   // 새 타이머 등록 (예: 300ms 후 실행)
	 dmdebounceTimer = setTimeout(() => {
	   if (keyword.length < 1) {
	     dmsearchResults.style.display = "none";
	     dmsearchResults.innerHTML = "";
	     return;
	   }
	   
   axios.get("/oho/searchArtGroupList?keyword="+keyword).then(resp => {
		  //console.log("검색 아티스트 그룹 : ", resp.data);
		  const data = resp.data;
		  
		  if(data.length === 0) { 
			  dmsearchResults.innerHTML = `<div class='dropdown-item text-muted'>${i18n.notFound}</div>`; 
			 } else {
				 dmsearchResults.innerHTML = data.map(group => 
					 `
			          <a onclick="dmsearchFilter(${group.artGroupNo})" class="dropdown-item">
			          <div>
			            <div class="fw-bold">${group.artGroupNm}</div>
			          </div>
			        </a>
					 `
				 ).join("");;
			 }
			 dmsearchResults.style.display = "block";
	  	}).catch(err => {
	      console.error("검색 중 오류 발생:", err);
	      dmsearchResults.innerHTML = `<div class='dropdown-item text-danger'>${i18n.searchFail}</div>`;
	      dmsearchResults.style.display = "block";
	    });
		
	}, 300); // 입력 멈추고 300ms 뒤에 실행	
 });
 
 // Enter 키 입력 시 POST 요청 보내기
dmsearchInput.addEventListener("keydown", function(e) {
	//console.log("이벤트 먹음 enterkey");
	if (e.key === "Enter") {
		const keyword = this.value.trim();
		if (keyword.length < 1) return;

		axios.post("/oho/dm/dmsearchFilter?artGroupNo=0&dmSrhKeyword=" +keyword).then(resp => {
			const dmfilteredList =resp.data;
			//console.log(JSON.stringify(dmfilteredList));
			clearSrhDm();
			commonArtListDm(dmfilteredList);
		}).catch(error => {
			console.error("POST 요청 중 오류 발생:", error);
		});
	}
});

function clearSrhDm() {

	// 입력창 숨기기
	dmsearchBox.style.display = "none";
	// 검색 아이콘 다시 표시
	dmsearchIcon.style.display = "inline-block";
	// 입력창 초기화
	dmsearchInput.value = "";
	// 검색 결과 닫기
	dmsearchResults.style.display = "none";
	dmsearchResults.innerHTML = "";

}

//외부 클릭 시 드롭다운 닫기
 document.addEventListener("click", function (e) {
	const searchArea = document.getElementById("dmsearchToggle");
	if (!searchArea.contains(e.target)) {
		clearSrhDm(e);
	}
   
 });
 
 document.getElementById("dmclearSearch").addEventListener("click", () => {
	  document.getElementById("dmsearchInput").value = "";
	  document.getElementById("dmsearchInput").focus();
	  document.getElementById("dmsearchResults").style.display = "none";
	  document.getElementById("dmsearchResults").innerHTML = "";
	});
	
function dmsearchFilter(artGroupNo, dmSrhKeyword){
	//alert("검색시작: "+artGroupNo);
	axios.post("/oho/dm/dmsearchFilter?dmSrhKeyword=&artGroupNo="+artGroupNo).then(resp=>{
		const dmfiltered =resp.data;
		console.log("filtered artGroupList: "+JSON.stringify(dmfiltered));
		
		// 대상 요소가 준비될 때까지 체크
		const waitForVisibleAndRun = () => {
		    const target = document.querySelector('#artistListDm');
		    if (target && window.getComputedStyle(target).display !== 'none') {
		        commonArtListDm(dmfiltered);
		    } else {
		        setTimeout(waitForVisibleAndRun, 100);
		    }
		};

		waitForVisibleAndRun();
		
	});

}