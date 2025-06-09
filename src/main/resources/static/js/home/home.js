
   ///// 굿즈샵 그룹명 클릭 시 버튼 색상 변경 시작 /////
   const gdsList = $(".card-artistNm");
   gdsList.on("click", function() {
      console.log("확인");

      // 선택 버튼 색상 변경
      $(".card-artistNm").removeClass("active");
      $(this).addClass("active");
   ///// 굿즈샵 그룹명 클릭 시 버튼 색상 변경 끝 /////

   
   ///// 굿즈카드 그룹버튼 클릭 시 데이터 비동기 처리 시작 /////
      const artGroupNo = $(this).data("group");
      const memNo = userVO.userNo;
      console.log("groupNO", artGroupNo);
      console.log("memNo", memNo);
	  
	  let start=1;
	  let end=15;
	  
	  if(artGroupNo != 0 ){
				end = 5;
		  }
      
	  async function renderGoods() {
		const result = await axios.get("/oho/getGoodsList",{ 
		   			params: {
		   				artGroupNo: artGroupNo,
						memNo : memNo,
						start : start,
						end : end
		   			    }
					});
		console.log("renderGoods -> result : ", result.data);
	     // 굿즈리스트 렌더링
		 renderGoodsList(result.data, artGroupNo);
	  }
	  
	  renderGoods();
	  

   })
   ///// 굿즈카드 그룹버튼 클릭 시 데이터 비동기 처리 끝 /////
   
   ///// 굿즈리스트 렌더링 시작 /////
   function renderGoodsList(goodsVOList, artGroupNo) {
   const container = document.getElementById("goodsListContainer");
   container.innerHTML = ""; // 기존 내용 비우기

      goodsVOList.forEach((goods, index) => {
		
		// 5개까지만 출력
		if(artGroupNo != 0) {
			if (index >= 5) return;
		}
		
         console.log("goods : ", goods);
         const gdsNo = goods.gdsNo;
         console.log("gdsNo : ", gdsNo);
         
         if (goods.fileGroupVO?.fileDetailVOList?.length > 0 && goods.fileGroupVO.fileDetailVOList[0] != null) {
            
         let goodsImg = "";
            // 굿즈샵 상세페이지 /shop/artistGroup/{artistGroup}/detail/{gdsNo}
            console.log("굿즈 상품 구분 : ", goods.commCodeGrpNo);
            const form = document.createElement("form");
            // 티켓일 경우
            if(goods.commCodeGrpNo=='GD02') {
				  goodsImg = goods.ticketVO.tkFileSaveLocate;
		 		   console.log("티켓 이미지 : ", goodsImg);
		               form.action = `/shop/ticket/ticketDetail`;
		               form.method = "get";
		 		   form.innerHTML = `
		    	                       <input type="hidden" name="gdsNo" value="${gdsNo}">
		    	                       <button class="card-goods">
		    	                           <img src="/upload${goodsImg}" class="bg-img" />
		    	                         </button>
		    							 `
               
            }else { // 일반 굿즈 상품일 경우
				
			   goodsImg = goods.fileGroupVO.fileDetailVOList[0].fileSaveLocate;
			   console.log("굿즈 이미지 : ", goodsImg);
               form.action = `/shop/artistGroup/` + artGroupNo + `/detail/` + gdsNo;
               form.method = "get";
			   
			   form.innerHTML = `
	                       <input type="hidden" name="gdsNo" value="${gdsNo}">
	                       <button class="card-goods">
	                           <img src="/upload${goodsImg}" class="bg-img" />
	                         </button>
							 `
            }
            const goodsFile = goods.fileGroupVO.fileDetailVOList[0];
            console.log("굿즈 파일이다!!", goodsFile);
            
            const formattedPrice = goods.unitPrice.toLocaleString(); 
               form.innerHTML += `
                      <div class="goods-name"><h6>${goods.gdsNm}</h6></div>
                      <h5>₩${formattedPrice}</h5>
               `;
         // class = swiper-slide인 div만들기
         const divSwiper = document.createElement("div");
         divSwiper.className = "swiper-slide";
         
         // 안에 form 태그 넣기
         divSwiper.append(form);
   
         container.appendChild(divSwiper);
         }
         
      });
      
   
   if (swiper) {
      swiper.update(); // 새로 들어온 슬라이드 감지
   }
   
}
   ///// 굿즈리스트 렌더링 끝 /////
   
   ///// 디엠 리스트 렌더링 시작 /////
   function getDMList() {
         
         axios.get("/oho/getDMList").then(resp => {
            console.log("getDMList : ", resp.data);
            
            renderDMList(resp.data);
         })
      }
      
      function renderDMList(dmList) {
         
         const dmListDiv = document.getElementById("dmListContainer");
         dmListDiv.innerHTML = "";
         
         let str = "";
         dmList.forEach((artGroup) => {
               str += `
                  <input type="hidden" value="${artGroup.artGroupNo}" />
                  <button class="btn-dmlist" onclick="toggleDm(${artGroup.artGroupNo})">
                     <div class="logo-wrap">
                        <img src="/upload${artGroup.fileLogoSaveLocate}">
                     </div>
                     <div class="card-body">
                        <h6>${artGroup.artGroupNm}</h6>
                     </div>
                  </button>
               `;
         });
         dmListDiv.innerHTML = str;
         
      }
   ///// 디엠 리스트 렌더링 끝 /////
   
   
   ///// 더보기 / 닫기 토글 시작 //////
   window.addEventListener('DOMContentLoaded', () => {
   		  const groupBtnContainer = document.getElementById('artistGroupBtnContainer');
   		  const toggleBtn = document.getElementById('toggleMoreBtn');
   		  const toggleIcon = document.getElementById('toggleIcon');

   		  let collapsedHeight = 52;
   		  let expanded = false;

   		  const checkOverflow = () => {
   		    if (groupBtnContainer.scrollHeight > collapsedHeight + 10) {
   		      toggleBtn.style.display = 'inline-block';
   		    } else {
   		      toggleBtn.style.display = 'none';
   		    }
   		  };

   		  checkOverflow();
   		  window.addEventListener('resize', checkOverflow);

   		  toggleBtn.addEventListener('click', () => {
   		    expanded = !expanded;
   		    if (expanded) {
   		      groupBtnContainer.style.maxHeight = groupBtnContainer.scrollHeight + "px";
   		      toggleIcon.innerText = i18n4.close;
   		    } else {
   		      groupBtnContainer.style.maxHeight = collapsedHeight + "px";
   		      toggleIcon.innerText = i18n4.more;
   		    }
   		  });
   		});
   ///// 더보기 / 닫기 토글 끝 //////
   
   //// 더보기 / 닫기 했을 때 비동기 시작 /////
   let currentNewArtistPage = 1;
   	let currentMyCommunityPage = 1;
   	const joinPageSize = 5;
   	const newPageSize = 10;
   	const loadMoreBtn = document.getElementById("loadMoreBtn");
   	const closeBtn = document.getElementById("closeBtn");
   	const loadMyCommunity = document.getElementById("loadMyCommunity");
   	const closeMyCommunity = document.getElementById("closeMyCommunity");
   	const groupListContainer = document.querySelector(".new-artist-group-list"); // 리스트 넣을 곳
   	const joinGroupListContainer = document.querySelector(".join-artist-group-list"); // 리스트 넣을 곳
   	
   	// 새로운 아티스트 버튼을 눌렀을 때 
   	loadMoreBtn.addEventListener("click", () => {
   		currentNewArtistPage++;
   		console.log("currentNewArtistPage : ", currentNewArtistPage);
   		axios.get("/oho/getNewArtistGroupList", { 
   			params: {
   				currentPage: currentNewArtistPage
   			    }
   		}).then(resp => {
   			const boardPage = resp.data;
   			const newArtistGroupList = boardPage.content;
   			
   			console.log("newArtistGroupList : ", newArtistGroupList);
   			
   			newArtistGroupList.forEach(group => {
   				const html = `
   			        <form action="/oho/groupProfile" method="get">
   			          <input type="hidden" name="artGroupNo" value="${group.artGroupNo}" />
   			          <button class="card-artist">
   			            <img src="/upload${group.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" class="bg-img">
   			            <div class="logo-wrap">
   			              <img src="/upload${group.fileLogoSaveLocate}">
   			            </div>
   			            <div class="card-body">
   			              <h6>${group.artGroupNm}</h6>
   			            </div>
   			          </button>
   			        </form>
   			      `;
   			      groupListContainer.insertAdjacentHTML("beforeend", html);
   			});
   			// 마지막 페이지면 더보기 버튼 숨기고 닫기 버튼 노출
   		    if (boardPage.currentPage == boardPage.endPage) {
   		    	  loadMoreBtn.style.display = "none";
   		    	  closeBtn.style.visibility = "visible";

   		    	  closeBtn.onclick = () => {
   		    		  axios.get("/oho/getNewArtistGroupList", {
   		    		      params: { currentPage: 1 }
   		    		    }).then(resp => {
   		    		      const pageData = resp.data.content;
   		    		      
   		    		      groupListContainer.innerHTML = "";

   		    		      // 리스트 앞쪽에 1페이지 항목 다시 삽입
   		    		      pageData.reverse().forEach(group => {
   		    		        const html = `
   		    		          <form action="/oho/groupProfile" method="get">
   		    		            <input type="hidden" name="artGroupNo" value="${group.artGroupNo}" />
   		    		            <button class="card-artist">
   		    		              <img src="/upload${group.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" class="bg-img">
   		    		              <div class="logo-wrap">
   		    		                <img src="/upload${group.fileLogoSaveLocate}">
   		    		              </div>
   		    		              <div class="card-body">
   		    		                <h6>${group.artGroupNm}</h6>
   		    		              </div>
   		    		            </button>
   		    		          </form>
   		    		        `;
   		    		        groupListContainer.insertAdjacentHTML("afterbegin", html);
   		    		      });

   		    		      // 버튼 원상 복구
   		    		      loadMoreBtn.style.display = "inline-block";
   		    	 		  closeBtn.style.visibility = "hidden";

   		    		      // 기존 이벤트 제거하고 다시 연결
   		    		      loadMoreBtn.onclick = null;

   		    		      // 다시 더보기 누르면 2페이지부터 시작되도록 설정
   		    		      currentNewArtistPage = 1;
   		    		    });
   		    	  };
   		    }
   		}).catch(err => {
   			console.error("리스트 로딩 중 오류 발생", err);
   		})
   	})
   	
   	// 가입한 아티스트 그룹 버튼을 눌렀을 때 
   	loadMyCommunity.addEventListener("click", () => {
   		currentMyCommunityPage++;
   		console.log("currentMyCommunityPage : ", currentMyCommunityPage);
   		axios.get("/oho/getJoinArtistGroupList", { 
   			params: {
   			      currentPage: currentMyCommunityPage
   			    }
   		}).then(resp => {
   			const boardPage = resp.data;
   			const joinArtistGroupList = boardPage.content;
   			
   			console.log("joinArtistGroupList : ", joinArtistGroupList);
   			
   			joinArtistGroupList.forEach(group => {
   				const html = `
   			        <form action="/oho/community/fanBoardList" method="get">
   			          <input type="hidden" name="artGroupNo" value="${group.artGroupNo}" />
   			          <button class="card-artist">
   			            <img src="/upload${group.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" class="bg-img">
   			            <div class="logo-wrap">
   			              <img src="/upload${group.fileLogoSaveLocate}">
   			            </div>
   			            <div class="card-body">
   			              <h6>${group.artGroupNm}</h6>
   			            </div>
   			          </button>
   			        </form>
   			      `;
   			      joinGroupListContainer.insertAdjacentHTML("beforeend", html);
   			});
   			// 마지막 페이지면 버튼 숨기기
			if(boardPage.currentPage != boardPage.endPage) {
				closeMyCommunity.style.display = "inline-block";
			}
   		    if (boardPage.currentPage == boardPage.endPage) {
   		    	loadMyCommunity.style.display = "none";
   		    	closeMyCommunity.style.display = "inline-block";
				}

   		    	closeMyCommunity.onclick = () => {
   		    		  axios.get("/oho/getJoinArtistGroupList", {
   		    		      params: { currentPage: 1 }
   		    		    }).then(resp => {
   		    		      const pageData = resp.data.content;
   		    		      
   		    		      joinGroupListContainer.innerHTML = "";

   		    		      // 리스트 앞쪽에 1페이지 항목 다시 삽입
   		    		      pageData.reverse().forEach(group => {
   		    		        const html = `
   		    		          <form action="/oho/community/fanBoardList" method="get">
   		    		            <input type="hidden" name="artGroupNo" value="${group.artGroupNo}" />
   		    		            <button class="card-artist">
   		    		              <img src="/upload${group.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" class="bg-img">
   		    		              <div class="logo-wrap">
   		    		                <img src="/upload${group.fileLogoSaveLocate}">
   		    		              </div>
   		    		              <div class="card-body">
   		    		                <h6>${group.artGroupNm}</h6>
   		    		              </div>
   		    		            </button>
   		    		          </form>
   		    		        `;
   		    		        joinGroupListContainer.insertAdjacentHTML("afterbegin", html);
   		    		      });

   		    		      // 버튼 원상 복구
   		    		      loadMyCommunity.style.display = "inline-block";
   		    		      closeMyCommunity.style.display = "none";

   		    		      // 기존 이벤트 제거하고 다시 연결
   		    		      loadMyCommunity.onclick = null;

   		    		      // 다시 더보기 누르면 2페이지부터 시작되도록 설정
   		    		      currentMyCommunityPage = 1;
   		    		    });
   		    	  };
   		}).catch(err => {
   			console.error("리스트 로딩 중 오류 발생", err);
   		})
   	})
   //// 더보기 / 닫기 했을 때 비동기 끝 /////
   
