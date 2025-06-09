<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  <!-- ⬅ 요거 꼭 필요! -->
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../header.jsp" %>
<meta charset="UTF-8">
<title>이상형 월드컵</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Confetti.js -->
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>
<style>
    .profile-img {
        width: 100%;
        aspect-ratio: 1 / 1;
        object-fit: cover;
        border-radius: 50%;
        transition: transform 0.3s ease;
    }

    .profile-img:hover {
        transform: scale(1.05);
    }

    .card-title {
        font-size: 1.2rem;
        font-weight: bold;
        margin-top: 0.5rem;
    }

    .round-title {
        font-size: 1.5rem;
        font-weight: bold;
        text-align: center;
        margin: 2rem 0;
    }
	/* 우승자 */
	.winner-img {
	    width: 300px;
	    aspect-ratio: 1 / 1;
	    object-fit: cover;
	    border-radius: 50%;
	    box-shadow: 0 0 20px rgba(255, 215, 0, 0.8);
	    animation: popIn 0.8s ease;
	}
	
	@keyframes popIn {
	    0% {
	        transform: scale(0.6);
	        opacity: 0;
	    }
	    100% {
	        transform: scale(1);
	        opacity: 1;
	    }
	}
	/* 라운드 이동 시  */
	@keyframes roundZoom {
    0% {
        transform: scale(0.7);
        opacity: 0;
    }
    100% {
        transform: scale(1);
        opacity: 1;
    }
	}
	
	.animate-title {
	    animation: roundZoom 0.8s ease;
	    color: #6c63ff;
	}

</style>
</head>
<body class="bg-light">

<div class="container">
    <div class="round-title" id="roundTitle">16강</div>

    <div class="row justify-content-center" id="matchContainer">
        <!-- 참가자 카드가 여기에 동적으로 들어감 -->
    </div>
</div>

<script type="text/javascript">
	const players = [
	    <c:forEach var="item" items="${players}" varStatus="status">
			<c:if test="${not empty item.fileGroupVO.fileDetailVOList}">
			    {
			        name: "${item.artActNm}",
			        img: "/upload${item.fileGroupVO.fileDetailVOList[0].fileSaveLocate}"
			    }<c:if test="${!status.last}">,</c:if>
			</c:if>
	    </c:forEach>
	];

	
    console.log("players::",players);
    
    let currentIndex = 0;
    let nextRound = [];

    function renderMatch() {
        const container = document.getElementById('matchContainer');
        container.innerHTML = '';

        
        // 2명씩 표시
        for (let i = 0; i < 2; i++) {
            const player = players[currentIndex + i];
            if (player) {
                const col = document.createElement('div');
                col.className = 'col-md-5 mb-4';
                col.innerHTML = `
                    <div class="card text-center shadow">
                        <div class="card-body">
	                        <img class="profile-img mb-3" src="\${player.img}" alt="\${player.name}">
	                        <div class="card-title">\${player.name}</div>
                            <button class="btn btn-primary vote-btn" onclick="vote(\${currentIndex + i})">선택하기</button>
                        </div>
                    </div>
                `;
                container.appendChild(col);
            }
        }
        
          if (currentIndex >= players.length) {
            // 다음 라운드로
            if (nextRound.length === 1) {
                document.getElementById('roundTitle').innerText = `🏆 최종 우승자: ${nextRound[0].name}`;
                container.innerHTML = `
                    <form action="/oho/game/getWinner" method="post" class="text-center">
                        <input type="hidden" name="artActNm" value="\${nextRound[0].name}">
                        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 60vh;">
                            <img class="profile-img mb-3 winner-img" src="\${nextRound[0].img}" alt="\${nextRound[0].name}">
                            <div class="card-title">\${nextRound[0].name}</div>
                            <button type="submit" class="btn btn-secondary vote-btn mt-3">제출하기</button>
                        </div>
                    </form>
                `;
                return;
            }

            players.splice(0, players.length, ...nextRound);
            nextRound = [];
            currentIndex = 0;
            updateRoundTitle(players.length);
            renderMatch();
            return;
        }


    }

    function vote(index) {
        nextRound.push(players[index]);
        currentIndex += 2;
        renderMatch();
    }

    function updateRoundTitle(count) {
        const titleMap = {
            16: '🔥 16강 ROUND 시작!',
            8: '🎯 8강 ROUND 진입!',
            4: '⚡ 4강 진출!',
            2: '🏁 결승전!',
        };
        const displayTitle = titleMap[count] || `${count}강`;

        // 텍스트 업데이트
        const titleElem = document.getElementById('roundTitle');
        titleElem.innerText = displayTitle;
        
        // 애니메이션 클래스 적용
        animateRoundTitle();

        // SweetAlert 연출
        Swal.fire({
            title: displayTitle,
            text: '최고의 인기 아티스트는?!',
            background: '#1e1e2f',
            color: '#fff',
            toast: false,
            position: 'center',
            timer: 2000,
            showConfirmButton: false,
            didOpen: () => {
                confetti({
                    particleCount: 150,
                    spread: 100,
                    origin: { y: 0.5 },
                });
            }
        });
    }
    function animateRoundTitle() {
        const title = document.getElementById('roundTitle');
        title.classList.add('animate-title');
        setTimeout(() => {
            title.classList.remove('animate-title');
        }, 800);
    }
    // 시작
    renderMatch();
</script>
<%@ include file="../footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>