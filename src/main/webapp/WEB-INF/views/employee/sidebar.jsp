<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-radius-lg fixed-start ms-2  bg-white my-2"
        id="sidenav-main" style="z-index:400;">
        <div class="sidenav-header">
            <i class="fas fa-times p-3 cursor-pointer text-dark opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
                aria-hidden="true" id="iconSidenav"></i>
            <a class="navbar-brand px-4 py-3 m-0"
                href=" https://demos.creative-tim.com/material-dashboard/pages/dashboard " target="_blank">
                <img src="../assets/img/logo-ct-dark.png" class="navbar-brand-img" width="26" height="26"
                    alt="main_logo">
                <span class="ms-1 text-sm text-dark">OHO Ent</span>
            </a>
        </div>
        
        <sec:authorize access="isAuthenticated()">
        	<sec:authentication property="principal.usersVO" var="userVO"/>    
    	</sec:authorize>
        
        <hr class="horizontal dark mt-0 mb-2">
        <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
            <ul class="navbar-nav">
                <!-- <li class="nav-item">
                    <a class="nav-link text-dark" href="/emp/atrzHome">
                        <i class="bi bi-folder2-open"></i>
                        <span class="nav-link-text ms-1">결재 관리</span>
                    </a>
                </li> -->
                <li class="nav-item">
                    <a class="nav-link text-dark" href="/emp/home">
                        <i class="bi bi-calendar-check"></i>
                        <span class="nav-link-text ms-1">부서 일정</span>
                    </a>
                </li>
                
                
                <li class="nav-item">
				  <a class="nav-link text-dark" data-bs-toggle="collapse" href="#submenu1">
				    <i class="bi bi-folder2-open"></i>
				    <span class="nav-link-text ms-1">결재 관리</span>
				  </a>
				  <div class="collapse" id="submenu1">
				    <ul class="nav">
				      <li class="nav-item">
				        <a class="nav-link text-dark" href="/emp/atrzHome">기안서 작성</a>
				      </li>
				      <li class="nav-item">
				        <a class="nav-link text-dark" href="/emp/atrzList">결재 요청 관리</a>
				      </li>
				      <li class="nav-item">
				        <a class="nav-link text-dark" href="/emp/atrzDocBox">결재 문서함</a>
				      </li>
				    </ul>
				  </div>
				</li>
				
				<li class="nav-item">
                    <a class="nav-link text-dark" href="/emp/empProfile">
                        <i class="bi bi-person-gear"></i>
                        <span class="nav-link-text ms-1">Profile</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="sidenav-footer position-absolute w-100 bottom-0 ">
            
        </div>
    </aside>
    
 