/**
 *  검색에 관한 js
 */

 
 const searchIcon = document.getElementById("searchIcon");
 const searchBox = document.getElementById("searchBox");
 const searchInput = document.getElementById("searchInput");
 const searchResults = document.getElementById("searchResults");
 
 // 검색 아이콘 클릭 시 입력창 보여주기
 searchIcon.addEventListener("click", () => {
   searchIcon.style.display = "none";
   searchBox.style.display = "block";
   searchInput.focus();
 });
 
 
 let debounceTimer;
 
 // 검색 입력 시 드롭다운 결과 표시
 searchInput.addEventListener("input", function () {
   const keyword = this.value.trim();
   console.log("검색된 키워드1 : ", keyword);
   
   // 이전 타이머 제거
   clearTimeout(debounceTimer);
   
   // 새 타이머 등록 (예: 300ms 후 실행)
	 debounceTimer = setTimeout(() => {
	   if (keyword.length < 1) {
	     searchResults.style.display = "none";
	     searchResults.innerHTML = "";
	     return;
	   }
	   
   axios.get("/oho/searchArtGroupList?keyword="+keyword).then(resp => {
		  console.log("검색 아티스트 그룹 : ", resp.data);
		  const data = resp.data;
		  
		  if(data.length === 0) { 
			  searchResults.innerHTML = `<div class='dropdown-item text-muted'>${i18n.notFound}</div>`; 
			 } else {
				 searchResults.innerHTML = data.map(group => 
					 `
			          <a href="/oho/groupProfile?artGroupNo=${group.artGroupNo}" class="dropdown-item">
			          <img src="/upload${group.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
			          <div>
			            <div class="fw-bold">${group.artGroupNm}</div>
			          </div>
			        </a>
					 `
				 ).join("");;
			 }
			 searchResults.style.display = "block";
	  	}).catch(err => {
	      console.error("검색 중 오류 발생:", err);
	      searchResults.innerHTML = `<div class='dropdown-item text-danger'>${i18n.searchFail}</div>`;
	      searchResults.style.display = "block";
	    });
		
	}, 300); // 입력 멈추고 300ms 뒤에 실행	
 });
 
//외부 클릭 시 드롭다운 닫기
 document.addEventListener("click", function (e) {
   const searchArea = document.getElementById("searchToggle");
   if (!searchArea.contains(e.target)) {
   // 입력창 숨기기
    searchBox.style.display = "none";
    // 검색 아이콘 다시 표시
    searchIcon.style.display = "inline-block";
    // 입력창 초기화
    searchInput.value = "";
    // 검색 결과 닫기
    searchResults.style.display = "none";
    searchResults.innerHTML = "";
   }
 });
 
 document.getElementById("clearSearch").addEventListener("click", () => {
	  document.getElementById("searchInput").value = "";
	  document.getElementById("searchInput").focus();
	  document.getElementById("searchResults").style.display = "none";
	  document.getElementById("searchResults").innerHTML = "";
	});