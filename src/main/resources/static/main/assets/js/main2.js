/**
* Template Name: OnePage
* Template URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
* Updated: Aug 07 2024 with Bootstrap v5.3.3
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/

(function() {
	"use strict";

	/**
	 * Apply .scrolled class to the body as the page is scrolled down
	 */


	/**
	 * Mobile nav toggle
	 */
	const mobileNavToggleBtn = document.querySelector('.mobile-nav-toggle');

	function mobileNavToogle() {
		document.querySelector('body').classList.toggle('mobile-nav-active');
		mobileNavToggleBtn.classList.toggle('bi-list');
		mobileNavToggleBtn.classList.toggle('bi-x');
	}

	/**
	 * Hide mobile nav on same-page/hash links
	 */
	document.querySelectorAll('#navmenu a').forEach(navmenu => {
		navmenu.addEventListener('click', () => {
			if (document.querySelector('.mobile-nav-active')) {
				mobileNavToogle();
			}
		});

	});

	/**
	 * Toggle mobile nav dropdowns
	 */
	document.querySelectorAll('.navmenu .toggle-dropdown').forEach(navmenu => {
		navmenu.addEventListener('click', function(e) {
			e.preventDefault();
			this.parentNode.classList.toggle('active');
			this.parentNode.nextElementSibling.classList.toggle('dropdown-active');
			e.stopImmediatePropagation();
		});
	});

	/**
	 * Preloader
	 */
	const preloader = document.querySelector('#preloader');
	if (preloader) {
		window.addEventListener('load', () => {
			preloader.remove();
		});
	}

	/**
	 * Scroll top button
	 */
	let scrollTop = document.querySelector('.scroll-top');

	function toggleScrollTop() {
		if (scrollTop) {
			window.scrollY > 100 ? scrollTop.classList.add('active') : scrollTop.classList.remove('active');
		}
	}
	scrollTop.addEventListener('click', (e) => {
		e.preventDefault();
		window.scrollTo({
			top: 0,
			behavior: 'smooth'
		});
	});

	window.addEventListener('load', toggleScrollTop);
	document.addEventListener('scroll', toggleScrollTop);

	/**
	 * Animation on scroll function and init
	 */
	function aosInit() {
		AOS.init({
			duration: 600,
			easing: 'ease-in-out',
			once: true,
			mirror: false
		});
	}
	window.addEventListener('load', aosInit);

	/**
	 * Initiate Pure Counter
	 */
	new PureCounter();

	/**
	 * Initiate glightbox
	 */
	const glightbox = GLightbox({
		selector: '.glightbox'
	});

	/**
	 * Init swiper sliders
	 */
	function initSwiper() {
		document.querySelectorAll(".init-swiper").forEach(function(swiperElement) {
			let config = JSON.parse(
				swiperElement.querySelector(".swiper-config").innerHTML.trim()
			);

			if (swiperElement.classList.contains("swiper-tab")) {
				initSwiperWithCustomPagination(swiperElement, config);
			} else {
				new Swiper(swiperElement, config);
			}
		});
	}

	window.addEventListener("load", initSwiper);

	/**
	 * Init isotope layout and filters
	 */
	document.querySelectorAll('.isotope-layout').forEach(function(isotopeItem) {
		let layout = isotopeItem.getAttribute('data-layout') ?? 'masonry';
		let filter = isotopeItem.getAttribute('data-default-filter') ?? '*';
		let sort = isotopeItem.getAttribute('data-sort') ?? 'original-order';

		let initIsotope;
		imagesLoaded(isotopeItem.querySelector('.isotope-container'), function() {
			initIsotope = new Isotope(isotopeItem.querySelector('.isotope-container'), {
				itemSelector: '.isotope-item',
				layoutMode: layout,
				filter: filter,
				sortBy: sort
			});
		});

		isotopeItem.querySelectorAll('.isotope-filters li').forEach(function(filters) {
			filters.addEventListener('click', function() {
				isotopeItem.querySelector('.isotope-filters .filter-active').classList.remove('filter-active');
				this.classList.add('filter-active');
				initIsotope.arrange({
					filter: this.getAttribute('data-filter')
				});
				if (typeof aosInit === 'function') {
					aosInit();
				}
			}, false);
		});

	});

	/**
	 * Frequently Asked Questions Toggle
	 */
	document.querySelectorAll('.faq-item h3, .faq-item .faq-toggle').forEach((faqItem) => {
		faqItem.addEventListener('click', () => {
			faqItem.parentNode.classList.toggle('faq-active');
		});
	});

	/**
	 * Correct scrolling position upon page load for URLs containing hash links.
	 */
	window.addEventListener('load', function(e) {
		if (window.location.hash) {
			if (document.querySelector(window.location.hash)) {
				setTimeout(() => {
					let section = document.querySelector(window.location.hash);
					let scrollMarginTop = getComputedStyle(section).scrollMarginTop;
					window.scrollTo({
						top: section.offsetTop - parseInt(scrollMarginTop),
						behavior: 'smooth'
					});
				}, 100);
			}
		}
	});

	/**
	 * Navmenu Scrollspy
	 */
	let navmenulinks = document.querySelectorAll('.navmenu a');

	function navmenuScrollspy() {
		navmenulinks.forEach(navmenulink => {
			if (!navmenulink.hash) return;
			let section = document.querySelector(navmenulink.hash);
			if (!section) return;
			let position = window.scrollY + 200;
			if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
				document.querySelectorAll('.navmenu a.active').forEach(link => link.classList.remove('active'));
				navmenulink.classList.add('active');
			} else {
				navmenulink.classList.remove('active');
			}
		})
	}
	window.addEventListener('load', navmenuScrollspy);
	document.addEventListener('scroll', navmenuScrollspy);

})();



// 초기 렌더링 //
axios.post("/oho").then(resp => {
	console.log("예~", resp.data);

	const joinArtistGroupList = resp.data.joinArtistGroupList;
	const newArtistGroupList = resp.data.newArtistGroupList;
	const artWithGoodsList = resp.data.artWithGoodsList;
	const goodsList = resp.data.goodsList;
	const dmList = resp.data.dmList;

	// 회원 - 가입한 커뮤니티 시작 //
	if (joinArtistGroupList != null) {
		renderJoinArtistList(joinArtistGroupList);
	}
	// 회원 - 가입한 커뮤니티 끝 //

	if (artWithGoodsList != null) {
		// 회원 - 굿즈 리스트 시작 //
		renderartWithGoodsList(artWithGoodsList);
		renderGoodsList(goodsList);
		// 회원 - 굿즈 리스트 끝 //
	}

	renderDmList(dmList);

	// 새로운 아티스트 시작 //
	getNewArtist(newArtistGroupList);
	// 새로운 아티스트 끝 //
});


document.addEventListener("click", async (e) => {
	const target = e.target.closest(".card-artistNm");
	if (!target) return;

	console.log("확인");

	// 선택 버튼 색상 변경
	document.querySelectorAll(".card-artistNm").forEach(el => el.classList.remove("active"));
	target.classList.add("active");

	const artGroupNo = target.getAttribute("data-group");
	const memNo = userVO.userNo;
	console.log("groupNO", artGroupNo);
	console.log("memNo", memNo);

	let data = {};
	if (artGroupNo == 0) {
		data = {
			memNo: memNo,
			artGroupNo: artGroupNo,
			start: 1,
			end: 15
		}
	} else {
		data = {
			memNo: memNo,
			artGroupNo: artGroupNo,
			start: 1,
			end: 5
		}
	}
	console.log("data 확인", data);

	try {
		const result = await axios.post("/oho/getGoodsList", data);
		console.log("renderGoods -> result : ", result.data);

		// 굿즈리스트 렌더링 함수 호출
		renderGoodsList(result.data);
	} catch (error) {
		console.error("데이터 요청 실패:", error);
	}


})
///// 굿즈샵 그룹명 클릭 시 버튼 색상 변경 시작 /////
const gdsList = document.querySelectorAll(".card-artistNm");

gdsList.forEach(function(item) {
	item.addEventListener("click", async function() {
		console.log("확인");

		// 선택 버튼 색상 변경
		gdsList.forEach(el => el.classList.remove("active"));
		this.classList.add("active");

		///// 굿즈카드 그룹버튼 클릭 시 데이터 비동기 처리 시작 /////
		const artGroupNo = this.getAttribute("data-group");
		const memNo = userVO.userNo;  // userVO는 스코프 내에 있다고 가정
		console.log("groupNO", artGroupNo);
		console.log("memNo", memNo);

		const data = {
			artGroupNo: artGroupNo,
			memNo: memNo
		};
		console.log("data 확인 ", data);

		try {
			const result = await axios.post("/oho/getGoodsList", data);
			console.log("renderGoods -> result : ", result.data);

			// 굿즈리스트 렌더링 함수 호출
			renderGoodsList(result.data, artGroupNo);

		} catch (error) {
			console.error("데이터 요청 실패:", error);
		}
	});
});
///// 굿즈카드 그룹버튼 클릭 시 데이터 비동기 처리 끝 /////

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

//////////////////// 렌더링 함수들 모음 /////////////////

// 디엠렌더
function renderDmList(dmList) {
	const dmListCard = document.getElementById("dmListCard");
	dmHtml = ``;
	dmHtml += `
				<h5 class="text fw-bold mb-4" style="color: black !important;">
					${i18n4.dmTitle}
					<button class="svg-btn" onclick="getDmList()">
						<svg xmlns="http://www.w3.org/2000/svg" width="27" height="27"
							fill="#33C1CF" stroke-width="2.5" class="bi bi-arrow-clockwise"
							viewBox="0 0 16 16" style="margin-left: 10px;">
						  <path fill-rule="evenodd"
								d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z" />
						  <path
								d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466" />
						</svg>
					</button>
				</h5>
				<div id="dmListContainer">
			`;

	dmList.forEach(artGroup => {
		dmHtml += `
					<input type="hidden" value="${artGroup.artGroupNo}" />
					<!-- 그룹 번호 (PK) -->
					<button class="btn-dmlist">
						<!-- 그룹 로고 -->
						<div class="logo-wrap">
							<img src="/upload${artGroup.fileLogoSaveLocate}">
						</div>
						<!-- 그룹 명 -->
						<div class="card-body">
							<h6>${artGroup.artGroupNm}</h6>
						</div>
					</button>
				`;
	})

	dmHtml += `
					</div>
					<!-- DM 리스트 반복 끝 -->
					<br> <br> <br><br> 
					<img src="https://tpc.googlesyndication.com/simgad/17702928538065432889"
							width="60%" style="display: block; margin: 0 auto;" />
			`;

	dmListCard.innerHTML = dmHtml;

}

// 굿즈있는 그룹리스트 렌더
function renderartWithGoodsList(artWithGoodsList) {
	const artWithGoodsListCard = document.getElementById("artWithGoodsListCard");

	let artWithGoodsHtml = ``;
	artWithGoodsHtml += `
   			<div class="container py-5">
   				<div class="d-flex align-items-center gap-3 mb-4">
   				    <h5 class="fw-bold mb-0">
   						${i18n4.merch}
   				    </h5>
   				    <small class="text-muted">
   					    <a href="/shop/home" target="_blank" class="text-decoration-none">
   							${i18n4.goShop} ▶
   					    </a>
   					</small>
   				</div>
   				<!-- 아티스트 그룹 전체 영역 -->
   				<div class="d-flex flex-wrap align-items-start" style="gap: 16px;">
   				  <!-- 버튼 리스트만 감싸는 부분 (여기에 max-height 적용) -->
   				  <div id="artistGroupBtnContainer" class="d-flex flex-wrap align-items-center col-10" style="gap: 16px; max-height: 52px; overflow: hidden; transition: max-height 0.3s; width:90% !important;">
   				    <!-- 전체 + 그룹 버튼들 -->
   				    <button class="card-artistNm active" data-group="0">
   				    	${i18n4.all}
   				    </button>
   			`;

	artWithGoodsList.forEach(artGroup => {
		artWithGoodsHtml += `
	   				<button class="card-artistNm" data-group="${artGroup.artGroupNo}">
	   		          <div class="artistName">${artGroup.artGroupNm}</div>
	   		        </button>
	   			`;
	})

	artWithGoodsHtml += `
			<!-- 더보기 버튼은 항상 보이도록 밖에 둠 -->
			  <button id="toggleMoreBtn" class="btn btn-outline-light border col-1" style="white-space: nowrap;">
			    <span id="toggleIcon" style="color: #f86d72;">
			    	<spring:message code="home.more" />
			    </span>
			  </button>
			</div>
		</div>
	`;

	artWithGoodsListCard.innerHTML = artWithGoodsHtml;
}

// 굿즈 렌더
function renderGoodsList(goodsList) {
	const goodsCard = document.getElementById("goodsCard");
	let goodsHtml = ``;

	goodsHtml += `
   			<div class="container">
   				<div class="swiper mySwiper">
   					<div id="goodsListContainer" class="swiper-wrapper">
   		`;

	goodsList.forEach(goods => {
		const goodsFile = goods.fileGroupVO.fileDetailVOList[0];
		goodsHtml += `
   				<div class="swiper-slide">
   			`;

		if (goods.commCodeGrpNo == 'GD02') {
			goodsHtml += `
   					<!-- 티켓 상품일 경우 -->
   					<form action="/shop/ticket/ticketDetail" method="get">
   						<input type="hidden" name="gdsNo" value="${goods.gdsNo}">
   						<button class="card-goods">
   							<img src="/upload${goods.ticketVO.tkFileSaveLocate}" class="bg-img" />
   						</button>
   						<div class="goods-name">
   							<h6>${goods.gdsNm}</h6>
   						</div>
   					`
			const formattedPrice = goods.unitPrice.toLocaleString();
			goodsHtml += `
   						<h5>
   							₩ ${formattedPrice}
   						</h5>
   					</form>
   				`;
		} else {
			goodsHtml += `
   					<form action="/shop/artistGroup/${goods.artGroupNo}/detail/${goods.gdsNo}">
   						<button class="card-goods">
   							<img src="/upload${goodsFile.fileSaveLocate}" class="bg-img" />
   						</button>
   						<div class="goods-name">
   							<h6>${goods.gdsNm}</h6>
   						</div>
   				`;
			const formattedPrice = goods.unitPrice.toLocaleString();
			console.log("formattedPrice : ", formattedPrice);
			goodsHtml += `
   						<h5>
   							₩ ${formattedPrice}
   							<fmt:formatNumber value="${goods.unitPrice}" type="number" />
   						</h5>
   					</form>
   				</div>
   				`;
		}
	});

	goodsHtml += `
   					</div>
   					<div class="swiper-pagination" style="--swiper-theme-color:#F86D72 !important;"></div>
   				</div>
   				<!-- 굿즈 리스트 (캐러셀) 끝 -->
   			</div>
   		`;

	goodsCard.innerHTML = goodsHtml;

	mySwiper();
}

// 가입한 아티스트 렌더
function renderJoinArtistList(joinArtistGroupList) {
	const joinArtistCard = document.getElementById("joinArtistCard");

	let joinHtml = ``;
	joinHtml += `
			<div class="grayBackground">
				<div class="container py-5">
					<h5 class="text fw-bold mb-4">
						${i18n4.myCommunity}
					</h5>
					<div class="d-flex flex-wrap justify-content-start join-artist-group-list" style="gap: 35px;">
			`;

	joinArtistGroupList.forEach(artGroup => {
		const groupFile = artGroup.fileGroupVO.fileDetailVOList[0];
		joinHtml += `
				<form action="/oho/community/fanBoardList" method="get">
					<input type="hidden" name="artGroupNo" value="${artGroup.artGroupNo}" />
					<button class="card-artist">
						<!-- 그룹 대표 이미지 -->
						<img src="/upload${groupFile.fileSaveLocate}" class="bg-img">
						<!-- 그룹 로고 -->
						<div class="logo-wrap">
							<img src="/upload${artGroup.fileLogoSaveLocate}">
						</div>
						<!-- 그룹 명 -->
						<div class="card-body">
							<h6>${artGroup.artGroupNm}</h6>
						</div>
					</button>
				</form>
			`;
	})

	joinHtml += `
				</div>
					<div class="text-center mt-4">
					  <button id="loadMyCommunity" class="btn btn-outline-dark">
				    	${i18n4.more}
					  </button>
					</div>
					<!-- 닫기 버튼 -->
					<div class="text-center mt-4">
					  <button id="closeMyCommunity" class="btn btn-outline-dark" style="display : none;">
					  	${i18n4.close}
					  </button>
					</div>
				</div>
			</div>
		`;

	joinArtistCard.innerHTML = joinHtml;

	setTimeout(() => {
		let currentMyCommunityPage = 1;
		const loadMyCommunity = document.getElementById("loadMyCommunity");
		const joinGroupListContainer = document.querySelector(".join-artist-group-list"); // 리스트 넣을 곳
		loadMyCommunity.addEventListener("click", () => {
			console.log("클릭");
			currentMyCommunityPage++;
			console.log("currentMyCommunityPage : ", currentMyCommunityPage);

			axios.get("/oho/getJoinArtistGroupList", {
				params: {
					currentPage: currentMyCommunityPage
				}
			}).then(resp => {
				console.log("resp", resp.data);
				let html = ``;
				resp.data.forEach(group => {
					html += `
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
				})
				joinGroupListContainer.insertAdjacentHTML("beforeend", html);
			})

		}, 0); // DOM 변경 직후 실행
	});
}

//////////////////// 렌더링 함수들 모음 끝 /////////////////

function getDmList() {

	axios.get("/oho/getDMList").then(resp => {
		console.log("getDMList : ", resp.data);

		renderDmList(resp.data);
	})
}

function getNewArtist(newArtistGroupList) {
	const newArtistCard = document.getElementById("newArtistCard");
	newArtHtml = ``;
	newArtHtml += `
			<h5 class="text fw-bold mb-4">
				${i18n4.newArtTitle}
			</h5>
			<div class="d-flex flex-wrap justify-content-start new-artist-group-list" style="gap: 35px;">
		`;

	newArtistGroupList.forEach(artGroup => {
		const groupFile = artGroup.fileGroupVO.fileDetailVOList[0];
		newArtHtml += `
				<!-- 모든 그룹 출력 시작 -->
				<form action="/oho/groupProfile" method="get">
					<input type="hidden" name="artGroupNo" value="${artGroup.artGroupNo}" />
					<!-- 그룹 번호 (PK) -->
					<button class="card-artist">
						<!-- 그룹 대표 이미지 -->
						<img src="/upload${groupFile.fileSaveLocate}" class="bg-img">
						<!-- 그룹 로고 -->
						<div class="logo-wrap">
							<img src="/upload${artGroup.fileLogoSaveLocate}">
						</div>
						<!-- 그룹 명 -->
						<div class="card-body">
							<h6>${artGroup.artGroupNm}</h6>
						</div>
					</button>
				</form>
				<!-- 모든 그룹 출력 끝 -->
			`;
	});

	newArtHtml += `
			</div>
			<!-- 더보기 버튼 -->
			<div class="text-center mt-4">
			  <button id="loadMoreBtn" class="btn btn-outline-dark">
		    	${i18n4.more}
			  </button>
			</div>
			<!-- 닫기 버튼 -->
			<div class="text-center mt-4">
			  <button id="closeBtn" class="btn btn-outline-dark" style="visibility : hidden;">
		    	${i18n4.close}
			  </button>
			</div>
		`;

	newArtistCard.innerHTML = newArtHtml;

}

function mySwiper() {
	swiper = new Swiper(".mySwiper", {
		slidesPerView: 4.2,
		grabCursor: true,
		freeMode: true,
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		navigation: false,
	});
}



