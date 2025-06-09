
const artGroupNo  = document.getElementById("artGroupNo").value;
console.log("artGroupNo : ", artGroupNo);
	
axios.get("/oho/groupProfile/"+artGroupNo).then(resp => {
	console.log("getArtistList -> result : ", resp.data);
	
	const artistGroupVO = resp.data;
	const artistList = artistGroupVO.artistVOList;
	const liveList = artistGroupVO.liveList;
	const mediaList = artistGroupVO.mediaList;
	const goodsList = artistGroupVO.goodsVOList;
	
	console.log("artistGroupVO : ", artistGroupVO);
	console.log("goodsList : ", goodsList);
	
	// 그룹 소개 시작
	const mainImg = resp.data.fileGroupVO.fileDetailVOList[0].fileSaveLocate;
	const groupInfoCard = document.getElementById("groupInfoCard");
	groupInfoCard.innerHTML = `
		  <img class="card-img" src="/upload${mainImg}" alt="Card image">
		  <div class="card-img-overlay">
		    <p class="display-1">${artistGroupVO.artGroupNm}</p>
			<p>🌟데뷔한 지 ${artistGroupVO.debutDDay}</p>
		    <p class="font-weight-normal ">${artistGroupVO.artGroupExpln}</p>
		  </div>
		`;
	// 그룹 소개 끝
		
	// 멤버 소개 시작
	const artistInfoCard = document.getElementById("artistInfoCard");
	let artHtml = ``;
	artHtml += `
				<h4 class="text fw-bold mb-4">
					${gp_i18n.groupProfile}
				</h4>
				<div id="artistContainer">
		`;

	artistList.forEach(artist => {
		const artistImg = artist.fileGroupVO.fileDetailVOList[0].fileSaveLocate;
	artHtml +=  
				`	<button class="btn-artist" data-artno="${artist.artNo}">
							<img src="/upload${artistImg}">
							<h6>${artist.artActNm }</h6>
						</button>
					`;
	});
	artHtml += `</div>`;
	artistInfoCard.innerHTML = artHtml;
	
	// 이벤트 위임을 사용하여 btn-artist 클릭 시 모달 띄우기
	artistInfoCard.addEventListener("click", () => {
		console.log("뜨나요?")
		const btnArtist = event.target.closest(".btn-artist");
		if (btnArtist) {
	        const artistNo = btnArtist.getAttribute("data-artno");
	        console.log("클릭된 아티스트 번호:", artistNo);
	        artistProfile(artistNo); // artistProfile 호출
	    }
	});
	// 모달 띄우는 함수 예시
	function artistProfile(artistNo) {
	    // 모달 관련 코드 (예: artistNo에 맞는 정보를 모달에 출력)
	    const modal = document.getElementById("profileModal"); // 모달 요소 선택
	    const modalContent = modal.querySelector(".modal-content");
		console.log("artistList : ", artistList);

		let modalHtml = ``;
		modalHtml += `<button class="close-btn" onclick="closeModal()">×</button>`;
		artistList.forEach(artist => {
			if(artist.artNo == artistNo) {
				const artImage = artist.fileGroupVO.fileDetailVOList[0].fileSaveLocate;
				modalHtml += `
					<img class="profile-img" src="/upload${artImage}" />
				    <h2 class="profile-name">${artist.artActNm}</h2>
				    <p class="profile-birth">${artist.artBirth}</p>
				    <p class="profile-desc">
				      ${artist.artExpln}
				    </p>
				`;
			}
		})
	    modalContent.innerHTML = modalHtml;
	    modal.style.display = "block"; // 모달 표시
		document.body.style.overflow = "hidden"; // 배경 스크롤 막기

	    // 모달 닫기 버튼에 이벤트 추가
	    const closeModal = modal.querySelector(".close-btn");
	    closeModal.addEventListener('click', function() {
	        modal.style.display = "none";
			document.body.style.overflow = "auto"; // 배경 스크롤 허용
	    });
	}
	
	// 멤버 소개 끝
	
	// 라이브 리스트 시작 (라이브가 있을 경우에만 노출)
	/*if(liveList[0] != null) {
		const liveListCard = document.getElementById("liveListCard");
		let liveHtml = ``;
		liveHtml += `
				<div class="container py-5">
					<h4 class="text fw-bold mb-4">
						${gp_i18n.groupLive}
					</h4>
					<div id="liveContainer">
			`;
			
		liveList.forEach(live => {
			const liveThumNail = live.thumNailPath;
			liveHtml += `
							<a class="liveThumNail btn px-1 py-1 text-start" href="/oho/community/media/post?postNo=${live.mediaPostNo}&artGroupNo=${artistGroupVO.artGroupNo}">
		                    	<img src="https://img.youtube.com/vi/${liveThumNail}/maxresdefault.jpg" 
		                        	 class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
	                  		</a>
				`;
		})
		
		liveHtml += `
					</div>
				</div>
			`;
			
		liveListCard.innerHTML = liveHtml;
	}*/
	// 라이브 리스트 끝
	
	// 미디어 리스트 시작
	if(mediaList[0] != null) {
		const mediaListCard = document.getElementById("mediaListCard");
		let mediaHtml = ``;
		mediaHtml += `
				<div class="container py-5">
					<h4 class="text fw-bold mb-4">
					${gp_i18n.groupMedia}
					</h4>
					<div id="mediaContainer">
			`
		mediaList.forEach(media => {
				const mediaThumNail = media.thumNailPath;
				mediaHtml += `
						<a class="mediaThumNail btn px-1 py-1 text-start" href="javascript:void(0)" onClick="memberCheck( { type:'media', memberShipYn:'N', mediaPostNo:${media.mediaPostNo} })">
                            <img src="https://img.youtube.com/vi/${mediaThumNail}/maxresdefault.jpg" 
                                 class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
                         	<h5 class="card-title text-truncate-2">${media.mediaPostTitle}</h5>
		                 	<p class="card-text"><small style="color:#999;">${media.formatRegDt}</small></p>
                        </a>
					`
		})
		
		mediaHtml +=	`
				 </div>
			</div>
	
		`;
		
		mediaListCard.innerHTML = mediaHtml;
		
		setTimeout(() => {
			
			
		}, 0)
		
	}
	// 미디어 리스트 끝
	
	// 굿즈&티켓 리스트 시작
	if(goodsList[0] != null) {
		const goodsListCard = document.getElementById("goodsListCard");
		let goodsHtml = ``;
		
		goodsHtml += `
				<div class="container py-5">
					<h4 class="text fw-bold mb-4">
						${gp_i18n.groupMerch}
					</h4>
					<div id="goodsContainer">
			`;
			
		goodsList.forEach(goods => {
			const goodsImg = goods.fileGroupVO.fileDetailVOList[0].fileSaveLocate;
			const formattedPrice = goods.unitPrice.toLocaleString();
			if(goods.commCodeGrpNo=='GD02') {
				goodsHtml += `
					<a class="goodsImg btn px-1 py-1 text-start" href="/shop/ticket/ticketDetail?gdsNo=${goods.gdsNo}">
	                	<img src="/upload${goods.ticketVO.tkFileSaveLocate}" class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
	                	<h6 class="card-title text-truncate-2 mb-2">${goods.gdsNm}</h6>
	                	<h6 class="card-title text-truncate-2 mb-5">₩ ${formattedPrice}</h6>
	                </a>
				`;
			}else {
				goodsHtml += `
					<a class="goodsImg btn px-1 py-1 text-start" href="/shop/artistGroup/${goods.artGroupNo}/detail/${goods.gdsNo}">
		            	<img src="/upload${goodsImg}" class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
		            	<h6 class="card-title text-truncate-2  mb-2">${goods.gdsNm}</h6>
		            	<h6 class="card-title text-truncate-2 mb-5">₩ ${formattedPrice}</h6>
		            </a>
				`;
			}
		})
		
		goodsHtml += `
					</div>
				</div>
		`;
		
		goodsListCard.innerHTML = goodsHtml;
	}
	// 굿즈&티켓 리스트 끝
});
