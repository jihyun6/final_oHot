<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <!-- 로고클릭시 홈으로 이동 경로 넣어야함 -->
    <a href="/admin/home" class="brand-link">
        <span class="brand-text font-weight-light">oHoT 관리자 홈</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
               <!--  <li class="nav-item">
                    <a href="/admin/artist/artistList" class="nav-link">
                        <i class="nav-icon fas fa-users"></i>
                       <p>예시항목</p>
                    </a>
                </li> -->
                <!-- 추가 메뉴 항목들 -->

                <li class="nav-item">
                    <a href="/admin/member/memberList" class="nav-link">
                        <i class="nav-icon fas fa-user-cog"></i>
                       <p>회원 관리</p>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a href="/admin/artistGroup/artistGroupList" class="nav-link">
                        <i class="nav-icon fas fa-star"></i>
                       <p>아티스트 그룹 관리</p>
                    </a>
                </li>
               
				  <li class="nav-item">
                    <a href="/admin/media" class="nav-link">
                        <i class="fab fa-youtube" style="margin-left: 4px; margin-right: 7px"></i>
                       <p> 미디어 | 라이브 관리</p>
                    </a>
                </li> 
                
                <li class="nav-item">
                    <a href="/admin/shop/adGoodsList" class="nav-link">
                        <i class="nav-icon fas fa-gift"></i>
                       <p>굿즈 관리</p>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a href="/admin/shop/adTicketList" class="nav-link">
                        <i class="nav-icon fas fa-ticket-alt"></i>
                       <p>공연/티켓 관리</p>
                    </a>
                </li>
                                
				<li class="nav-item">
				  <a class="nav-link" data-toggle="collapse" href="#submenu1" role="button"  aria-controls="submenu1">
				    <i class="nav-icon fas fa-comments"></i>
				    커뮤니티 관리
				  </a>
				  <div class="collapse" id="submenu1">
				    <ul class="nav flex-column ml-3">
				      <li class="nav-item">
				        <a class="nav-link" href="/admin/community/postList">
				          <i class="nav-icon fas fa-clipboard-list"></i>게시글 관리
				        </a>
				      </li>
				      <li class="nav-item">
				        <a class="nav-link" href="/admin/community/replyList">
				          <i class="nav-icon far fa-comment-dots"></i>댓글 관리
				        </a>
				      </li>
				      <li class="nav-item" >
	                    <a class="nav-link"  href="/admin/notice/noticeList" >
	                        <i class="nav-icon fas fa-bullhorn"></i>공지사항 관리
	                    </a>
                	  </li>
				    </ul>
				  </div>
				</li>
				
				<!-- 문의게시판관리 -->
              <li class="nav-item">
                  <a href="/admin/inquiryPost" class="nav-link">
                      <i class="fas fa-question-circle nav-icon"></i>
                     <p>문의글 관리</p>
                  </a>
              </li>

			 <!-- 통계 -->				
              <li class="nav-item">
                  <a href="/admin/stats/subscription" class="nav-link">
                      <i class="fas fa-chart-bar nav-icon"></i>
                     <p>상품 통계</p>
                  </a>
              </li>
				
				
				
<!-- 	            <li class="nav-item"> -->
<!-- 	            <a href="#" class="nav-link"> -->
<!-- 	              <i class="nav-icon fas fa-chart-bar"></i> -->
<!-- 	              <p> -->
<!-- 	                통계관리 -->
<!-- 	                <i class="fas fa-angle-left right" style="display: none;"></i> -->
<!-- 	              </p> -->
<!-- 	            </a> -->
	           
<!-- 	            <ul class="nav nav-treeview" style="display: none;"> -->
<!-- 	             <li class="nav-item"> -->
<!-- 	                <a href="/admin/stats/goodsStatistics" class="nav-link"> -->
<!-- 	                  <i class="far fa-circle nav-icon"></i> -->
<!-- 	                  <p>굿즈통계</p> -->
<!-- 	                </a> -->
<!-- 	              </li> -->
	              
	             
<!-- 	             <li class="nav-item"> -->
<!-- 	                <a href="/admin/stats/subscription" class="nav-link"> -->
<!-- 	                  <i class="far fa-circle nav-icon"></i> -->
<!-- 	                  <p>커뮤니티통계</p> -->
<!-- 	                </a> -->
<!-- 	              </li> -->
	              
	              
<!-- 	            </ul> -->
<!-- 	          </li> -->
	          <!-- 통계 끝 -->
	          	<li class="nav-item">
                    <a href="/admin/reportmanage/reportList" class="nav-link">
                        <i class="fas fa-exclamation-triangle nav-icon"></i>
                       <p>신고관리</p>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
