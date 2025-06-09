<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="/images/oHoT_logo.png">

<title>Insert title here</title>

<style type="text/css">
.activeMenu {
  background-color: rgba(255, 255, 255, .1) !important;
  color: #fff !important;
}

.nav-pills .nav-link:not(.active):hover {
    color: gray !important;
}

</style>
<link rel="icon" href="/images/oHoT_logo.png">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/adminlte/plugins/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="/adminlte/plugins/fontawesome-free/css/all.min.css">
<!-- AdminLTE CSS -->
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css">
<!-- 부트스트랩 icheckbox -->
<link rel="styleSheet" href="/adminlte/plugins/icheck-bootstrap/icheck-bootstrap.min.css">

  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- google font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">

<!-- 주요 플러그인(위에서 부터)
	icheck : 체크박스용
	dataTable : 테이블 관련
	responsive : 반응형 디자인 관련
	buttons : 부트스트랩 버튼
	select2 : 드롭다운, 다중선택 관련
	switch : 토글(on/off) 관련
	datarangepicker : 날짜 범위 선택, 캘린더 UI, 게시글 상품 설명
	Summernote : 텍스트 에디터
	-->
  <link rel="stylesheet" href="/adminlte/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/daterangepicker/daterangepicker.css">
  <link rel="stylesheet" href="/adminlte/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <link rel="stylesheet" href="/adminlte/plugins/summernote/summernote-bs4.min.css">
  
</head>
<body class="sidebar-mini" style="height: auto;">
<!-- 네비바 -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="javascript:void(0)" class="nav-link">${title }</a>
        </li>
          	
    </ul>
    
    <!-- 알람 아이콘 -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->
      <!-- 검색 버튼 삭제
      <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" href="#" role="button">
          <i class="fas fa-search"></i>
        </a>
        <div class="navbar-search-block" style="display: none;">
          <form class="form-inline">
            <div class="input-group input-group-sm">
              <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
              <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                  <i class="fas fa-search"></i>
                </button>
                <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
      </li>
	   -->
	   
	  <li class="nav-item">
        <form action="/admin/logout" method="post">
          <a class="nav-link" href="#" role="button" id="logout">
			<i class="fas fa-sign-out-alt"></i>
		  </a>
		</form>
	  </li>

      <!-- Notifications Dropdown Menu -->
      <!--
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#" aria-expanded="false">
          <i class="far fa-bell"></i>
          <!-- 총알림수 
          <span class="badge badge-warning navbar-badge">99</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="left: inherit; right: 0px;">
          <span class="dropdown-item dropdown-header">알림 메시지</span>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
          <!-- 알림 알림 
            <i class="fas fa-envelope mr-2"></i> 4 new messages
            <span class="float-right text-muted text-sm">알림 도착 시간</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-users mr-2"></i> 8 friend requests
            <span class="float-right text-muted text-sm">알림 도착 시간</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-file mr-2"></i> 3 new reports
            <span class="float-right text-muted text-sm">알림 도착 시간</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">알림 모두 보기</a>
        </div>
      </li>
      -->
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
    </ul>
</nav>
<!-- /.navbar -->

<!-- 공통템플릿 js -->
	<!-- jQuery -->
<script src="/adminlte/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/adminlte/dist/js/adminlte.min.js"></script>
<!-- axios  -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>


<!-- 주요 편의 플러그인 -->
<script src="/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/adminlte/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="/adminlte/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="/adminlte/plugins/select2/js/select2.full.min.js"></script>
<script src="/adminlte/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<script src="/adminlte/plugins/moment/moment.min.js"></script>
<script src="/adminlte/plugins/daterangepicker/daterangepicker.js"></script>
<script src="/adminlte/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<script src="/adminlte/plugins/summernote/summernote-bs4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<!-- 플러그인 초기화 코드입니다.
     혹시 초기화 필요한 플러그인이면 아래에 초기화 코드 추가해주세요  -->
<script>
  $(function() {
	  
	//현재 URL 경로 읽어오기(/admin/shop/adGoodsList)
	fullPath = $(location).attr('pathname') + $(location).attr('search');
	$("a[href='" + fullPath + "']").addClass('activeMenu');
	
    // DataTables 초기화
    if ($.fn.DataTable) {
      $('.dataTable').DataTable({
        "responsive": true,
        "autoWidth": false
      });
    }
    
    // Select2 초기화
    if ($.fn.select2) {
      $('.select2').select2();
      
   	// 부트스트랩4 테마가 적용된 Select2 초기화
      $('.select2bs4').select2({
        theme: 'bootstrap4'
      });
    }
    
    // Bootstrap Switch 초기화
    if ($.fn.bootstrapSwitch) {
      $("input[data-bootstrap-switch]").bootstrapSwitch();
    }
    
    // Summernote 초기화
    if ($.fn.summernote) {
      $('.summernote').summernote();
    }
    
    // Date range picker 초기화
    if ($.fn.daterangepicker) {
      $('.daterangepicker-field').daterangepicker();
    }
    
	 // DateTimePicker 초기화 - 개별 날짜 선택기
    if ($.fn.datetimepicker) {
      // 시작일 초기화
      $('#start-date').datetimepicker({
        format: 'YYYY-MM-DD'
      });
      
      // 종료일 초기화
      $('#end-date').datetimepicker({
        format: 'YYYY-MM-DD'
      });
    }
	
    
        const currentPath = window.location.pathname;
        
        // 현재 메뉴가 커뮤니티 게시글 또는 댓글 관리 페이지인 경우
        const isCommunityPage = currentPath.includes("/admin/community/postList") || currentPath.includes("/admin/community/replyList") 
        										|| currentPath.includes("/admin/notice/noticeList") || currentPath.includes("/admin/community/postDetail")
        										|| currentPath.includes("/admin/notice/detailNotice");
        
        if (isCommunityPage) {
          // 아코디언(서브메뉴) 열기
          const submenu = document.getElementById("submenu1");
          if (submenu) submenu.classList.add("show"); // Bootstrap 4에서는 show 클래스 추가로 열림

          // 부모 메뉴 강조
          const parentLink = document.querySelector('a[href="#submenu1"]');
          console.log("parent.ariaExpended=",parentLink);
          if (parentLink) {
            parentLink.classList.add("activeMenu");
            console.log("parent.ariaExpended=",parentLink);
          }
          console.log("parent.ariaExpended=",parentLink);
          // 현재 페이지 하위 메뉴 강조
          const submenuLinks = submenu.querySelectorAll("a.nav-link");
          console.log("sdfsdf",submenuLinks);

          submenuLinks.forEach(link => {
            const href = link.getAttribute("href");
            if (href === currentPath) {
              link.classList.add("activeMenu");
              console.log("parent.ariaExpended=",submenuLinks);
            }
          });
        } else {
          // 일반 단독 메뉴 활성화 처리
          const navLinks = document.querySelectorAll(".nav-link[href]");
          navLinks.forEach(link => {
            const href = link.getAttribute("href");
            if (href === currentPath) {
              link.classList.add("activeMenu");
            }
          });
        }
    	
        //로그아웃 
        let logout = document.getElementById("logout");
        logout.addEventListener('click', function(){
     	   	event.preventDefault();
    		
     		let form = logout.closest('form');
     	   	form.submit();
        })
  });
  
</script>
</body>
</html>