<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oHoT EMP</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.8.4/axios.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>

<style>
.approval-table-container {
    max-height: 380px;
    overflow-y: auto;
    border: 1px solid #eee;
    border-radius: 8px;
    padding: 5px;
}

#approvalList tr, #referrerList tr {
    border-bottom: 1px solid #dee2e6;
}

.modal-body table {
    border-collapse: collapse;
    width: 100%;
}

.modal-body table th{
    padding: 0px;
    font-size: 0.9rem; 
}
.modal-body table td {
    border: none;
    padding: 6px;
}

#searchName {
    border: 1px solid #eee;
    border-radius: 4px;
    padding: 5px 5px;
    max-width: 80%;
    margin-bottom: 5px;
    margin-left: 10px;
    margin-right: 15px;
}
.table thead th{
    padding: 0px !important;
}
.document-selection-container .card {
    transition: all 0.3s ease;
    border-radius: 10px;
}
.right-sidebar {
    position: sticky;
    top: 150px;
    height: calc(100vh - 150px);
    overflow-y: auto;
    z-index: 10;
}
.approval-person {
    display: flex;
    align-items: center;
    padding: 10px;
    margin-bottom: 8px;
    border-radius: 4px;
}
.approval-person.highlight{

	border-left: 3px solid #20c997;
    background-color: #f8f9fa;
}

.approval-person img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 12px;
}
.approval-person-info {
    flex: 1;
}
.approval-person-name {
    font-weight: 600;
    margin-bottom: 2px;
}
.approval-person-position {
    font-size: 0.8rem;
    color: #6c757d;
}
.approval-status {
    font-size: 0.75rem;
    padding: 3px 8px;
    border-radius: 12px;
    background-color: #e9ecef;
    font-weight: 600;
}
.status-draft {
    background-color: #e2e3e5;
    color: #055160;
}
.status-pending {
    background-color: #cff4fc;
    color: #41464b;
}

.action-buttons {
    display: flex;
    gap: 8px;
    margin-top: 12px;
} 
</style>
</head>
<body>
    
    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.usersVO" var="userVO"/>    
    </sec:authorize>

    <!-- 사이드바 -->
    <%@ include file="../sidebar.jsp"%>

    <!-- 컨텐츠 -->
    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
        <!-- 헤더 -->
        <%@ include file="../header.jsp"%>
        <div class="container-fluid px-4">
           <h4 class="fw-bold mb-3">기안서 작성</h4>
           <form id="atrzForm"> 
            <!-- 문서작성 & 결재선 -->
            <div class="row">
                <!-- 왼쪽: 기안문서 설정 및 작성 영역 -->
                <div class="col-md-9 mb-4">
                    <!-- 문서 선택 셀렉트 -->
                    <div class="mb-4 document-selection-container">
                        <div class="card shadow-sm border-0">
                            <div class="card-body p-3">
                            	<div class="d-flex align-items">
	                                <h6 class="text-muted mb-3"><i class="bi bi-file-earmark-text me-2"></i>기안 문서 설정</h6>
	                                <button type="button" id="testBtn" class="btn btn-secondary ms-5">시안 버튼</button>
                            	</div>
                                <div class="row g-3 align-items-center">
                                   
                                    <div class="col-md-3">
                                        <label for="formTypeSelect" class="form-label small text-muted mb-1">문서 종류</label>
                                        <select class="form-select form-select-sm custom-select" id="formTypeSelect" name="docFmNo">
                                            <option value="">문서 선택</option>
                                            <option value="1" data-prefix="GDS">아티스트 굿즈 기획서</option>
                                            <option value="2" data-prefix="EVT">공연 기획 승인서</option>
                                            <option value="3" data-prefix="CVS">일반회원 아티스트 전환 요청서</option>
                                        </select>
                                    </div>
                                    <div class="col-md-7">
                                        <label for="approvalTitle" class="form-label small text-muted mb-1">기안 제목</label>
                                        <input type="text" class="form-control form-control-sm" id="drftTtl" name="drftTtl"
                                            placeholder="결재 제목을 입력해주세요. (50자 미만)">
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-check form-switch mt-4">
                                            <input class="form-check-input" type="checkbox" id="emrgYn" name="emrgYn" value="Y">
                                            <label class="form-check-label text-danger" for="emrgYn">
                                                <i class="bi bi-exclamation-circle me-1"></i>긴급 문서
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 기안문서 작성 부분 -->
                    <div class="card shadow-sm">
                        <div class="card-body">
	                        <div id="formTemplate" class="text-center p-5 text-muted border border-2 rounded" style="min-height: 500px;">
	                            <i class="bi bi-file-earmark-text" style="font-size: 2rem;"></i>
	                            <div class="mt-3 fw-semibold">양식을 선택해주세요</div>
	                            <div class="small">위쪽에서 기안할 양식을 선택하면, 여기에 표시됩니다.</div>
	                        </div>
                        </div>
                    </div>
                </div>

                <!-- 오른쪽: 결재선 -->
                <div class="col-md-3 mb-4 right-sidebar">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h6 class="text-muted">결재선</h6>
                        </div>
                        
                        <div class="card-body">
                            <!-- 결재자 목록 -->
                            <div class="approval-person-list mb-3">
									                            
                                <!-- 기안자 -->
                                <div class="approval-person highlight">
                                	<c:choose>
                                		<c:when test="${not empty userVO.employeeVO.profileSaveLocate }">
		                                    <img src="/upload${userVO.employeeVO.profileSaveLocate}" alt="프로필" class="profile-img">
                                		</c:when>
                                		<c:otherwise>
		                            		<img src="/images/defaultProfile.jpg" alt="기본 프로필" class="profile-img">
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="approval-person-info">
                                        <div class="approval-person-name">${userVO.employeeVO.empNm}</div>
                                        <div class="approval-person-position">${userVO.employeeVO.departmentVO.deptNm} | ${userVO.employeeVO.position}</div>
                                    </div>
                                    <span class="approval-status status-draft">기안</span>
                                </div> 
                                
                                <!-- 결재자 -->
                               <!--  <div class="approval-person">
                                    <img src="..." alt="프로필" class="profile-img">
                                    <div class="approval-person-info">
                                        <div class="approval-person-name">구정모 사장</div>
                                        <div class="approval-person-position">대우그룹</div>
                                    </div>
                                    <span class="approval-status status-pending">결재</span>
                                </div> -->
                                
                                
                                 <!-- 추가 참조자 -->
                                <!--<div class="approval-person">
                                    <img src="..." alt="프로필" class="profile-img">
                                    <div class="approval-person-info">
                                        <div class="approval-person-name">전병현 차장</div>
                                        <div class="approval-person-position">경영지원부</div>
                                    </div>
                                    <span class="approval-status" style="background-color: #fff3cd; color: #856404;">참조</span>
                                </div> -->
                            </div>
                            
                            <div id="draftHiddenContainer"></div>

                            <div id="approvalHiddenContainer"></div>
                            
                            <div id="referrerHiddenContainer"></div>

                            <!-- 버튼 영역 -->
                            <div class="action-buttons">
                                <!-- <button type="button" class="btn btn-outline-secondary flex-grow-1" data-bs-toggle="modal"
                                    data-bs-target="#approvalModal" id="approvalBtn">결재선 설정</button> -->
                                <button type="button" class="btn btn-outline-secondary flex-grow-1" id="approvalBtn">결재선 설정</button>
                                <button type="button" class="btn btn-info flex-grow-1" onclick="approvalRequest()">결재 요청</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           </form> 
        </div>

        <!-- 모달 -->
        <div class="modal fade" id="approvalModal" tabindex="-1" aria-labelledby="approvalModalLabel" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
                <div class="modal-content"
                    style="height: 550px; border-radius: 12px; padding: 5px; display: flex; flex-direction: column;">

                    <!-- 헤더 -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="approvalModalLabel">결재 정보</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>

                    <!-- 바디 -->
                    <div class="modal-body" style="flex: 1; display: flex; gap: 10px;">
                        <!-- 좌측: 조직도 -->
                        <div style="width: 30%; border: 1px solid #ddd; border-radius: 8px; padding: 10px;">
                            <div class="input-group input-group-sm mb-2 d-flex align-items-center">
                                <input type="text" id="searchName" placeholder="이름/직책/부서 검색"
                                       class="form-control border-start-0" /><i class="bi bi-search"></i>
                              </div>
                            <div>
                                <button type="button" id="btnExpand" class="btn btn-sm btn-outline-primary">전체 열기</button>
                                <button type="button" id="btnCollapse" class="btn btn-sm btn-outline-secondary">전체 닫기</button>
                            </div> 
                            <div id="jstree" style="flex: 1; overflow-y: auto; max-height: 270px; border-radius: 5px; padding: 5px;"></div>
                        </div>

                        <!-- 중앙: 버튼 -->
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <button type="button" id="btnAdd" class="btn btn-info btn-sm">결재>></button>
                            <button type="button" id="referrerBtnAdd" class="btn btn-secondary btn-sm">참조>></button>
                        </div>

                        <!-- 우측: 결재선 -->
                        <div class="approval-table-container" style="width: 60%; border: 1px solid #ddd; border-radius: 8px; display: flex; flex-direction: column;padding: 10px;">
                            <!-- 결재자 섹션 -->
                            <div>
                                <h6 class="border-bottom">결재자</h6>
                                <table class="table table-sm text-center mb-3">
                                    <thead>
                                        <tr>
                                            <th>타입</th>
                                            <th>이름</th>
                                            <th>직급</th>
                                            <th>부서</th>
                                            <th><i class="bi bi-trash3-fill"></i></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-no="${userVO.userNo }">
                                            <td class="text-black fw-bold">기안</td>
                                            <td>${userVO.employeeVO.empNm}</td>
                                            <td>${userVO.employeeVO.position}</td>
                                            <td>${userVO.employeeVO.departmentVO.deptNm}</td>
                                            <td>-</td>
                                        </tr>
                                    </tbody>
                                    <tbody id="approvalList">
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- 참조자 섹션 -->
                            <div>
                                <h6 class="border-bottom">참조자</h6>
                                <table class="table table-sm text-center mb-0">
                                    <thead>
                                        <tr>
                                            <th>타입</th>
                                            <th>이름</th>
                                            <th>직급</th>
                                            <th>부서</th>
                                            <th><i class="bi bi-trash3-fill"></i></th>
                                        </tr>
                                    </thead>
                                    <tbody id="referrerList">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 푸터 -->
                    <div class="modal-footer m-0 p-0">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal" onclick="saveApprovalLine()">저장</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 풋터 -->
        <%@ include file="../footer.jsp"%>
    </main>
    <script>
    const userInfo = {
        empNm : "${userVO.employeeVO.empNm}",
        deptNm : "${userVO.employeeVO.departmentVO.deptNm}",
        position : "${userVO.employeeVO.position}",
        empNo : ${userVO.userNo},
    	jbgdCd : "${userVO.employeeVO.jbgdCd}",
    	stampFileGroupNo : ${userVO.employeeVO.stampFileGroupNo},
    	profileSaveLocate : "${userVO.employeeVO.profileSaveLocate}"
    };
    
    console.log("userInfo : ", userInfo);
    
    document.addEventListener("DOMContentLoaded", () => {
        
        const select = document.querySelector("#formTypeSelect");
        const approvalBtn = document.querySelector("#approvalBtn");
        
        approvalBtn.addEventListener("click", (e)=>{
        	e.preventDefault();
        	
        	const selectValue = select.value;
        	
        	if(!selectValue){
        		Swal.fire({
                    icon: 'warning',
                    title: '결재양식을 선택해주세요',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#3085d6'
                });
        		return;
        	}
        	
        	// 모달 수동으로 열기
            const modal = new bootstrap.Modal(document.getElementById("approvalModal"));
        	modal.show();
        })
        
        select.addEventListener("change", (e) => {
            const formNo = e.target.value;
            console.log("formNo", formNo);
            if (!formNo){
            	
            	document.querySelector("#formTemplate").innerHTML = "";
            	let div = `
            	
	                <i class="bi bi-file-earmark-text" style="font-size: 2rem;"></i>
	                <div class="mt-3 fw-semibold">양식을 선택해주세요</div>
	                <div class="small">위쪽에서 기안할 양식을 선택하면, 여기에 표시됩니다.</div>            	
            	`;
            	document.querySelector("#formTemplate").innerHTML = div;
            	
            	return
            }
            
            fetch("/emp/atrzHome/form?formNo="+formNo)
                .then(resp => resp.text())
                .then(data => {
                    console.log("폼데이타 : ", data);
                    
                    document.querySelector("#formTemplate").innerHTML = "";
                    document.querySelector("#formTemplate").innerHTML = data;
                    
                    document.querySelector("#approvalList").innerHTML = "";
                    document.querySelector("#referrerList").innerHTML = "";
                    
                   /*  document.querySelector(".approval-person-list").innerHTML= ""; */

                    document.querySelector(".form-deptNm").value = userInfo.deptNm;
                    document.querySelector(".form-empNm").value = userInfo.empNm;
                    //document.querySelector(".form-jbgdCd").value = userInfo.jbgdCd;
                    
                    
                });
        })
    })
    
    $('#approvalModal').on('show.bs.modal', function () {
    	console.log("열렸다11");
    });
        

    $(document).ready(function() {
        // 1. 기본 설정은 여기에
        if ($.jstree && $.jstree.defaults) {
            $.jstree.defaults.core.themes.variant = "large";
        }

        // 2. JSTree 초기화
        $('#jstree').jstree({
            plugins : [ 'search' ],
            core : {
                data : {
                    url : '/emp/treeListAjax',
                    dataType : 'json'
                },
                check_callback : true
            },
        });

        // 3. JSTree 준비 완료 이벤트
        $('#jstree').on('ready.jstree', function(e, data) {
            console.log("트리 준비 완료!", data.instance.get_json());
        });

        // 4. 검색 함수
        $('#searchName').on('input', function() {
            $('#jstree').jstree(true).search($(this).val());
        });

        // 5. 노드 선택 시 처리
        $('#jstree').on('select_node.jstree', function(e, data) {
            const node = data.node;
            const empInfo = node.data;

            if (empInfo) {
                // 예시: 사원 이메일 정보 출력
                console.log("선택한 사원 정보", empInfo);
            }
        });
        
        $('#btnAdd, #referrerBtnAdd').click(function(){
        	
            const isReferrer = $(this).attr('id') === 'referrerBtnAdd';

            console.log("isReferrer", isReferrer);
            const selected = $('#jstree').jstree('get_selected', true)[0];
            
            console.log("selected: ", selected);
            
            if(!selected || selected.icon.includes('folder')) return;

            const emp = selected;
            const data = emp.data || {};
            
            
            const rowHtml = `
                <tr class='approval-row' data-no="\${emp.id}" data-jbgdcd="\${data.jbgdCd}" 
                	data-stampfilegroupno="\${data.stampFileGroupNo}" data-profilesavelocate="\${data.profileSaveLocate ? data.profileSaveLocate : ''}">
                    \${isReferrer? '<td class="text-warning fw-bold">참조</td>' : '<td class="text-info fw-bold">결재</td>'}
                    <td>\${data.empNm || ''}</td>
                    <td>\${data.position || ''}</td>
                    <td>\${data.deptNm || ''}</td>
                    <td>
                        <button type="button" class="removeBtn btn p-0 m-0 border-0">
                            <i class="bi bi-trash3-fill"></i>
                        </button>
                    </td>
                </tr>
                
            `;

            const targetList = isReferrer ? '#referrerList' : '#approvalList';
            
            if(!isReferrer && $(targetList).find('tr').length >= 2){
                
                Swal.fire({
                    toast: true,
                    position: 'center',
                    icon: 'warning',
                    title: '결재자는 최대 2명까지 선택 가능합니다.',
                    showConfirmButton: false,
                    timer: 1500,
                    timerProgressBar: false
                    
                });
                //fetch로 넘어가는거 방지
                return;
            }
            
            // 'tr'에 공백을 안주니까 selectortr로 인식해서 중복검사가 안됐음 ' tr' 공백주기!
            if($(targetList + ' tr').filter(function(){
                return $(this).attr('data-no') == emp.id;
            }).length>0){
                console.log("중복 찾음", ${emp.id});
                
                Swal.fire({
                    toast: true,
                    position: 'center',
                    icon: 'warning',
                    title: '이미 추가된 사원입니다',
                    showConfirmButton: false,
                    timer: 1300,
                    timerProgressBar: false
                    
                });
          
            }else{
                console.log("중복 없음:", emp.id);
                console.log("현재 요소들:", $(targetList).find('tr').length);
                $(targetList).append(rowHtml);
            }
        });
        
        $('#btnExpand').click(() => $('#jstree').jstree('open_all'));
        
        $('#btnCollapse').click(() => $('#jstree').jstree('close_all'));
        $(document).on('click', '.removeBtn', function(){
            $(this).closest('tr').remove();
        });
        
        
    });
    
    function saveApprovalLine(){
    	const approvalList = [];
    	const referrerList = [];
    	
    	// 결재자
    	document.querySelectorAll("#approvalList tr").forEach(items =>{
    		const item = items.querySelectorAll("td");
    		approvalList.push({
    			type : item[0].innerText.trim(),
    			empNm : item[1].innerText.trim(),
    			position : item[2].innerText.trim(),
    			deptNm : item[3].innerText.trim(),
    			empNo : items.dataset.no,
    			jbgdCd : items.dataset.jbgdcd,
    			stampFileGroupNo : items.dataset.stampfilegroupno,
    			profileSaveLocate : items.dataset.profilesavelocate
    			
    		});
    		console.log("stampFileGroupNo확인확인", approvalList.stampFileGroupNo);
    	});
    	
    	// 참조자
    	document.querySelectorAll("#referrerList tr").forEach(items =>{
    		const item = items.querySelectorAll("td");
    		referrerList.push({
    			type : item[0].innerText.trim(),
    			empNm : item[1].innerText.trim(),
    			position : item[2].innerText.trim(),
    			deptNm : item[3].innerText.trim(),
    			empNo : items.dataset.no,
    			jbgdCd : items.dataset.jbgdcd,
    			stampFileGroupNo : items.dataset.stampfilegroupno,
    			profileSaveLocate : items.dataset.profilesavelocate
    			
    		});
    	});
    	
    	// 기안자
    	const drafter = {
    			type : "기안",
    			empNm : userInfo.empNm,
    			position : userInfo.position,
    			deptNm : userInfo.deptNm,
    			empNo : userInfo.empNo,
    			jbgdCd : userInfo.jbgdCd,
    			stampFileGroupNo : userInfo.stampFileGroupNo,
    			profileSaveLocate : userInfo.profileSaveLocate
    			
    	}
    
        const approvals = [drafter, ...approvalList];
        
    	const data = {
    		approvals : approvals,
    		referrers : referrerList
    	};
    	
    	console.log("data: ", data);
    	
    	
    	fetch('/emp/saveApprovalLine',{
    		method : "POST",
    		headers : {
    			"Content-Type" : "application/json"
    		},
    		body : JSON.stringify(data)
    	}).then(resp=>resp.json())
    	  .then(data=>{
    		  
    		  console.log("성공 data", data);
    		  
    		  const approvalDiv = document.querySelector(".approval-person-list");
    		  const approvalTbl = document.querySelector(".approvalTbl");
    		  
    		  approvalDiv.innerHTML = "";
    		  approvalTbl.innerHTML = "";
    		  
    		  let html = "";
    		  
    		  let isFirstApprover = true;
			  
			  const tr1 = document.createElement("tr");
			  const tr2 = document.createElement("tr");
			  const tr3 = document.createElement("tr");
    		  
			  const draftContainer = document.querySelector("#draftHiddenContainer");
			  const apprContainer = document.querySelector("#approvalHiddenContainer");
	    	  
			  draftContainer.innerHTML = "";
			  apprContainer.innerHTML = "";
	    	  
			  let apprCounter = 0;
			  
    		  if(Array.isArray(data.approvalVOList)){
    			  data.approvalVOList.forEach((item,index) =>{
    				  console.log("item 확인 !!!! ", item);
    				  if(item.type === "기안"){
	    				  
    					  // 기안 사원번호
    					  const draftEmpInput = document.createElement("input"); 
	    				  draftEmpInput.type = "hidden";
	    				  draftEmpInput.name = "drfEmpNo";
	    				  draftEmpInput.value = item.empNo;
	    				  draftContainer.appendChild(draftEmpInput);
	    				  
	    				  // 기안 직급코드
	    				  const draftJbgdCdInput = document.createElement("input");
	    				  draftJbgdCdInput.type = "hidden";
	    				  draftJbgdCdInput.name = "drftJbgdCd";
	    				  draftJbgdCdInput.value = item.jbgdCd;
	    				  draftContainer.appendChild(draftJbgdCdInput);		
	    				  
	    				  // 기안 직인파일그룹번호
	    				  const stampFileGroupNoInput = document.createElement("input");
	    				  stampFileGroupNoInput.type = "hidden";
	    				  stampFileGroupNoInput.name = "stampFileGroupNo";
	    				  stampFileGroupNoInput.value = item.stampFileGroupNo;
	    				  draftContainer.appendChild(stampFileGroupNoInput);
    				  
    				  }else if(item.type === "결재"){
    					  
    					  const idx = apprCounter++;
    					  
    					  // 결재 사원번호
    					  const apprEmpInput = document.createElement("input");
    					  apprEmpInput.type = "hidden";
    					  apprEmpInput.name = `approvals[\${idx}].atrzEmpNo`;
    					  apprEmpInput.value = item.empNo;
    					  apprContainer.appendChild(apprEmpInput);
    					  
    					  // 결재 직급코드
    					  const apprJbgdCdInput = document.createElement("input");
    					  apprJbgdCdInput.type = "hidden";
    					  apprJbgdCdInput.name = `approvals[\${idx}].aprvrJbgdCd`;
    					  apprJbgdCdInput.value = item.jbgdCd;
    					  apprContainer.appendChild(apprJbgdCdInput);

                          // 결재 직인파일그룹번호
                          const apprStampFileGroupNoInput = document.createElement("input");
                          apprStampFileGroupNoInput.type = "hidden";
                          apprStampFileGroupNoInput.name = `approvals[\${idx}].aprvrStampFileGroupNo`;
                          apprStampFileGroupNoInput.value = item.stampFileGroupNo;
                          apprContainer.appendChild(apprStampFileGroupNoInput);
    				 
    				  }
    				  
    				  console.log("체킁킁",index);
    				  
    				  const isCurrentUser = item.empNo === userInfo.empNo;
    				  console.log("isCurrentUser", isCurrentUser);
    				  
    				  const statusClass = item.type === "기안" ? "status-draft" : "status-pending";
    				  const typeValue = item.type === "기안" ? "기안" : "결재";
    				  const approvalCalss = `approval-person \${isCurrentUser ? 'highlight' : ''}`;
    				  console.log("approvalCalss", approvalCalss);
    				  
    				  html += `
	    				  <div class="\${approvalCalss}">
		                      <img src="\${item.profileSaveLocate ? '/upload' + item.profileSaveLocate : '/images/defaultProfile.jpg'}" alt="기본 프로필" class="profile-img">
	                          <div class="approval-person-info">
	                              <div class="approval-person-name">\${item.empNm}</div>
	                              <div class="approval-person-position">\${item.deptNm} | \${item.position}</div>
	                          </div>
	                          <span class="approval-status \${statusClass}">\${typeValue}</span>
	                      </div> 
    				  `;
    				  
    				  if(item.type === "기안"){
    					  document.querySelector("#drafter-position").innerText = item.position;
    					  document.querySelector("#drafter-name").innerText = item.empNm;
    				  }else if(item.type === "결재"){
    					  const approvalIndex = index;
    					  console.log("approvalIndex",approvalIndex);
    					  
    					  if(isFirstApprover){
	    					  const th = document.createElement("th");
	    					  th.rowSpan = 3;
	    					  th.className = "vertical-text";
	    					  th.innerText = "승 인";
	    					  tr1.appendChild(th);
	    					  isFirstApprover = false;
    						  
    					  }
    					  
    					  
    					  const td1 = document.createElement("td");
    					  td1.innerText = item.position;
    					  td1.style = "height:25px; width: 80px;";
    					  tr1.appendChild(td1);
    					  
    					  const td2 = document.createElement("td");
    					  td2.innerText = item.empNm;
    					  td2.style= "height:60px;";
    					  tr2.appendChild(td2);
    					  
    					  const td3 = document.createElement("td");
    					  td3.style = "height:25px;";
    					  tr3.appendChild(td3);
    					  
    					  approvalTbl.appendChild(tr1);
    		    		  approvalTbl.appendChild(tr2);
    		    		  approvalTbl.appendChild(tr3);
    		    	
    				  }
    				 
	    		  
    			  });
    			  
    		  }

    		  
    		 const refContainer = document.querySelector("#referrerHiddenContainer");
    		 refContainer.innerHTML = "";
             
             if(Array.isArray(data.referrerVOList)){
               data.referrerVOList.forEach((item,index) =>{
                    console.log("item참조자", item);
                    
                    // 참조 사원번호
                    const refEmpInput = document.createElement("input");
                    refEmpInput.type = "hidden";
                    refEmpInput.name = `referrers[\${index}].refEmpNo`;
                    refEmpInput.value = item.empNo;

                    // 참조 직급코드
                    const refJbgdCdInput = document.createElement("input");
                    refJbgdCdInput.type = "hidden";
                    refJbgdCdInput.name = `referrers[\${index}].refJbgdCd`;
                    refJbgdCdInput.value = item.jbgdCd; 
                    
                    refContainer.appendChild(refEmpInput);
                    refContainer.appendChild(refJbgdCdInput);
                });
             }

    		 approvalDiv.innerHTML = html;
    		  
    		 Swal.fire({
    			 title : "성공",
    			 text : "결재선 설정이 완료되었습니다",
    			 icon : "success",
    			 timer : 1000
    			  
    		  });

    	  })
    	
    }
    
    
    function approvalRequest(){

    	const prefix = document.querySelector("#formTypeSelect").options[document.querySelector("#formTypeSelect").selectedIndex].getAttribute('data-prefix');
    	
    	// 유효성 검사
    	if(!validateForm(prefix)) return;
    	
        const atrzDoc = {
            atrzLineVOList : [],
            atrzRefVOList : []
        };
    	
        const emrgCheckBox = document.querySelector("#emrgYn");
        const emrgValue = emrgCheckBox.checked ? emrgCheckBox.value : "N";

        // atrz_line 결재자 정보
        document.querySelectorAll('#approvalHiddenContainer input[name^="approvals["]')
	        // name="approvals[0].atrzEmpNo"
	        .forEach(input =>{
	            const parts = input.name
	                .replace("approvals[", "")
	                .replace("]", "")
	                .split(".");
	
	            const i = parseInt(parts[0]);
	            const key = parts[1];
	            
	            // 초기화
	            atrzDoc.atrzLineVOList[i] = atrzDoc.atrzLineVOList[i] || {};
	            
	            atrzDoc.atrzLineVOList[i][key] = input.value;
	    });
        
        // atrz_ref 참조자 정보
        document.querySelectorAll('#referrerHiddenContainer input[name^="referrers["]')
	        .forEach(input =>{
	            const parts = input.name
	                .replace("referrers[", "")
	                .replace("]", "")
	                .split(".");
	            
	            const i = parseInt(parts[0]);
	            const key = parts[1];
	
	            // 초기화
	            atrzDoc.atrzRefVOList[i] = atrzDoc.atrzRefVOList[i] || {};
	
	            atrzDoc.atrzRefVOList[i][key] = input.value;
        });

    	const test = {
    		prefix : prefix,
    		docFmNo : document.querySelector('[name="docFmNo"]').value,
            drftTtl : document.querySelector("#drftTtl").value, 
            drftCn : document.querySelector("#drftTtl").value,
            emrgYn : emrgValue,
            drftEmpNo : document.querySelector('[name="drfEmpNo"]').value,
            drftJbgdCd : document.querySelector('[name="drftJbgdCd"]').value,
            drftStampFileGroupNo : document.querySelector('[name="stampFileGroupNo"]').value,

            atrzLineVOList : atrzDoc.atrzLineVOList,
            atrzRefVOList : atrzDoc.atrzRefVOList,

    	}

    	if (prefix === "EVT") {
            test.approvedConcertPlanVO = getConcertFormData();
        } else if (prefix === "CVS") {
            test.approvedConversionRequestVO = getConversionRequestFormData();
        }
    	
    	
        let formData = new FormData();
    	formData.append("test", new Blob([JSON.stringify(test)],{type:"application/json;charset=utf-8"}));

        fetch("/emp/atrzDocPost",{
            method:"post",
            body:formData
        }).then(resp=>{
            console.log("resp : ", resp);

            resp.text().then(data =>{
            	console.log("data", data);
                window.location.href = "/emp/atrzDocDetail?atrzDocNo="+data;
                
            })
        });
    	
    }
    
    function validateForm(prefix) {
        switch (prefix) {
            case "EVT":
                return validateConcertForm();
            case "CVS":
                return validateConversionRequestForm();
            default:
                return true;
        }
    }
    
    function validateConcertForm() {
        const requiredFields = ["#drftTtl", "#gdsNm", "#tkCtgr", "#tkLctn", "#playerNm", "#hostOrg", "#expectedAudience", "#expectedBudget", "#background"];
        for (let selector of requiredFields) {
            if (!document.querySelector(selector).value) {
                Swal.fire("필수 항목을 모두 입력해주세요.");
                return false;
            }
        }
        return true;
    }

    function validateConversionRequestForm() {
        const memEmail = document.querySelector("#memEmail").value;
        const memFullName = document.querySelector("#memFullName").value;
        const reason = document.querySelector("#reason").value;
        const drftTtl = document.querySelector("#drftTtl").value;

        if (!memEmail || !memFullName || !reason || !drftTtl) {
            Swal.fire("필수 항목을 모두 입력해주세요.");
            return false;
        }

        return true;
    }
    
    function getConcertFormData(){
    	return {
    		
    		gdsNm : document.querySelector("#gdsNm").value,
            tkCtgr : document.querySelector("#tkCtgr").value,
            tkLctn : document.querySelector("#tkLctn").value,
            playerNm : document.querySelector("#playerNm").value,
            hostOrg : document.querySelector("#hostOrg").value,
            expectedAudience : document.querySelector("#expectedAudience").value,
            expectedBudget : document.querySelector("#expectedBudget").value,
            background : document.querySelector("#background").value,
            requests : document.querySelector("#requests").value,
            remarks : document.querySelector("#remarks").value
    	};
    }
 
    function getConversionRequestFormData(){
    	return {
    		memEmail : document.querySelector("#memEmail").value,
    		memFullName : document.querySelector("#memFullName").value,
    		reason : document.querySelector("#reason").value,
    		remarks : document.querySelector("#remarks").value
    	};
    }
    
    document.getElementById("testBtn").addEventListener("click", ()=>{
    	const formTypeSelect = document.getElementById("formTypeSelect");
    	const drftTtl = document.querySelector("input[name='drftTtl']");
	    	
   		const memEmail = document.querySelector("input[name='memEmail']");
   		const memFullName = document.querySelector("input[name='memFullName']");
   		const reason = document.querySelector("textarea[name='reason']");
   		
   		drftTtl.value="일반회원의 아티스트 권한 전환 요청 건";
   		memEmail.value="jh@oho.com";
   		memFullName.value="송중호";
   		reason.value="공식 데뷔 예정으로 인한 권한 변경 요청합니다.";
    		
    });

    </script>
</body>
</html>