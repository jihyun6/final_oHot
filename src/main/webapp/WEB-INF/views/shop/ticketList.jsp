<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<script type="text/javascript" src="/js/jquery.min.js"></script>
<meta charset="UTF-8">
<title>ticketList</title>

<style>
.card-body p {
    margin-bottom: 2px; /* 문단 간격 줄이기 */
}
.ellipsis-2-lines {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.4em;
    max-height: calc(1.4em * 2); /* 2줄 기준 */
  }
</style> 
</head>
<body>

<div class="container">
	<div class="container mt-2 ">
        <div class="card-header" >
            <nav class="nav nav-pills justify-content-center mb-2">
                <!-- href 연결 다시 해야함 home에 있는 주소로로 -->
                <a class="nav-link ${empty param.tkCtgr ? 'text-danger fw-bold' : ''}" onclick="selectCtgr(this)">전체</a>
                <a class="nav-link " onclick="selectCtgr(this,'콘서트')">콘서트</a>
                <a class="nav-link " onclick="selectCtgr(this,'팬미팅')">팬미팅</a>
                <a class="nav-link " onclick="selectCtgr(this,'기타')">기타</a>
            </nav>
        
        
        <div class="row row-cols-1 row-cols-md-5 " id="ticketContainer">
            <c:forEach var="goodsVO" items="${goodsVOList}" varStatus="stat" end="9">
                <div class="col">
                    <a href="/shop/ticket/ticketDetail?gdsNo=${goodsVO.gdsNo }">
                        <div class="card h-60 w-55" style="width: 150px; margin-bottom: 0;">
                            <div  style="height: 200px; overflow: hidden;">
                                <img src="/upload${goodsVO.ticketVO.tkFileSaveLocate}" alt="포스터" class="card-img-top"  style="width: 100%; height: 100%; object-fit: cover;"  />
                            </div>
                        </div>
                        
                        <div class="card-body body p-1">
                            <h5 class=" fw-bold ellipsis-2-lines" >${goodsVO.gdsNm}</h5>
                            <p class="text-muted small">${goodsVO.ticketVO.tkLctn }</p>
                            <p class="text-muted small">${goodsVO.artGroupNm }</p>
                            <p class="text-muted small">${goodsVO.ticketVO.tkStartYmd } ~ ${goodsVO.ticketVO.tkFinishYmd }
                            </p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="mt-3" style="text-align: center;">
            <a class="btn btn-outline-secondary" style="border-radius: 50px; margin-bottom: 10px;" href="/shop/ticket/ticketList">더보기</a>
        </div>
    </div>
</div>
</div>
<script>
    function selectCtgr(changeTitle,tkCtgr) {
        // alert("ctgr: " + tkCtgr);
        axios.post("/shop/ticket/ticketListPost", {
            tkCtgr: tkCtgr
        }).then(resp => {
            const list = resp.data;
            const container = document.querySelector("#ticketContainer");
            
            // 기존 내용 비우기
            container.innerHTML = ""; 
            document.querySelectorAll('.nav-link').forEach(nav => {
                nav.classList.remove('text-danger', 'fw-bold');
            });

            //카테고리 색상변경
            changeTitle.classList.add('text-danger', 'fw-bold');

            list.slice(0, 10).forEach(g => {
                container.innerHTML += `
                    <div class="col">
                        <a href="/shop/ticket/ticketDetail?gdsNo=\${g.gdsNo}">
                            <div class="card h-60 w-55" style="width: 150px; margin-bottom: 0;">
                                <div  style="height: 200px; overflow: hidden;">
                                    <img src="/upload\${g.ticketVO.tkFileSaveLocate}" alt="포스터" class="card-img-top"  style="width: 100%; height: 100%; object-fit: cover;"  />
                                </div>
                            </div>
                            <div class="card-body body p-1">
                                <h5 class="fw-bold ellipsis-2-lines" ">\${g.gdsNm}</h5>
                                <p class="text-muted small">\${g.ticketVO.tkLctn}</p>
                                <p class="text-muted small">\${g.artGroupNm}</p>
                                <p class="text-muted small">\${g.ticketVO.tkStartYmd} ~ \${g.ticketVO.tkFinishYmd}</p>
                            </div>
                        </a>
                    </div>
                `;
            });
        });
    }

</script>
</body>
</html>