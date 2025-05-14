<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
</head>
<body>
<!-- header.jsp 시작 -->
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class="content-header" style='background-color: #696969'>
      <div class="container-fluid">
        <div class="row mb-2" >
          <div class="col-sm-6">
            <h1 class="m-0" style="color: white;">${NickName[0].memNicknm}</h1>
            <div style="color: #D3D3D3;">${Email[0].memEmail}</div>
            <div style="color: #C0C0C0;">
				<sec:authorize access="isAuthenticated()">
				<form action="/logout" method="post">
					<button style='background-color: #696969'>로그아웃</button>
				</form>
			</sec:authorize>	
			</div>            
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    
    
    <div class="container-fluid">
        <div class="row">
			          <div class="col-md-3">
			  <!-- About Me Box -->
			  <br><br><br><br><br>
			  <div class="card card-primary">
			    <!-- /.card-header -->
			    <div class="card-body" style="background-color: #f5f5f5; border-radius: 10px;">
			      <!-- 카테고리 제목 -->
			      <strong><i class="fas fa-cogs mr-1"></i> <h3 style="color: #4CAF50;">내 계정 설정</h3></strong>
			      <hr>
			      
			      <!-- 카테고리 항목들 -->
			      <ul class="nav nav-pills flex-column">
			        <li class="nav-item">
			          <a class="nav-link" href="#" style="color: #444; font-size: 18px;">
			            <i class="fas fa-book mr-2"></i> 공지사항
			          </a>
			        </li>
			        <li class="nav-item">
			          <a class="nav-link" href="#" style="color: #444; font-size: 18px;">
			            <i class="fas fa-map-marker-alt mr-2"></i> FAQ
			          </a>
			        </li>
			        <li class="nav-item">
			          <a class="nav-link" href="#" style="color: #444; font-size: 18px;">
			            <i class="fas fa-pencil-alt mr-2"></i> 알림 설정
			          </a>
			        </li>
			      </ul>
			    </div>
			    <!-- /.card-body -->
			  </div>
			  <!-- /.card -->
			</div>
			<!-- /.col -->
         
          <div class="col-md-9">
            <br><h1>내 정보</h1><br>
            <div class="card">
              <div class="card-header p-2">
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="activity">
                    <!-- Post -->
                    <div class="post">
                      <div class="user-block">
                        <span class="username">
                          <h3>이메일</h3>
                        </span>
                    </div>
                    <div class="post clearfix">
                      <div class="user-block">
                        <span class="username">
                         <input type="hidden" id="memNo" name="memNo" value="${Email[0].memNo}" />
                         <button id="changeEmail" style="color: black; font-size: 30px; background: none; border: none;" onclick="editEmail()">${Email[0].memEmail}</button>
                        </span>
                      </div>
                      
                      <form id="emailForm" class="form-horizontal" style="display:none;">
		                <div class="input-group input-group-sm mb-0">
		                  <input type="email" class="form-control" style= "font-size:30px" id="emailInput" value="${Email[0].memEmail}">
		                  <div class="input-group-append">
		                    <button type="button" class="btn btn-primary" onclick="saveEmail()">저장</button>
		                    <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
		                  </div>
		                </div>
		              </form>
                    </div>
                  </div>
                 
                 
                 <div class="post">
                      <div class="user-block">
                        <span class="username">
                          <h3>닉네임</h3>
                        </span>
                    </div>
                    <div class="post clearfix">
                      <div class="user-block">
                        <span class="username">
                          <button id="changeNick" style="color: black; font-size: 30px; background: none; border: none;" onclick="editNicknm()">${NickName[0].memNicknm}</button>
                        </span>
                      </div>
                       <form id="nickForm" class="form-horizontal" style="display:none;">
		                <div class="input-group input-group-sm mb-0">
		                  <input type="nick" class="form-control" style= "font-size:30px" id="nickInput" value="${NickName[0].memNicknm}">
		                  <div class="input-group-append">
		                    <button type="button" class="btn btn-primary" onclick="savenick()">저장</button>
		                    <button type="button" class="btn btn-secondary" onclick="cancleNick()">취소</button>
		                  </div>
		                </div>
		              </form>
                    </div>
                  </div>
                  
                  
                  <div class="post">
                      <div class="user-block">
                        <span class="username">
                          <h3>이름</h3>
                        </span>
                    </div>
                    <div class="post clearfix">
                      <div class="user-block">
                        <span class="username">
                          <a href="#" style="color: black; font-size: 30px; background: none; border: none;" >${name[0].memLastName}</a>
                        </span>
                      </div>
                      <form class="form-horizontal">
                        <div class="input-group input-group-sm mb-0">
                          <div class="input-group-append">
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                 
                 <div class="post">
                      <div class="user-block">
                        <span class="username">
                          <h3>생년월일</h3>
                        </span>
                    </div>
                    <div class="post clearfix">
                      <div class="user-block">
                        <span class="username">
                          <a href="#" style="color: black; font-size: 30px; background: none; border: none;" >${birth[0].memBirth}</a>
                        </span>
                      </div>
                      <form class="form-horizontal">
                        <div class="input-group input-group-sm mb-0">
                          <div class="input-group-append">
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                  
                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>

<script type="text/javascript">

// 이메일 수정 모드로 전환
function editEmail() {
    document.getElementById("changeEmail").style.display = "none"; // 기존 이메일 버튼 숨기기
    document.getElementById("emailForm").style.display = "block"; // 이메일 입력 폼 표시
  }
  
//이메일 수정 취소
function cancelEdit() {
  document.getElementById("changeEmail").style.display = "block"; // 기존 이메일 버튼 표시
  document.getElementById("emailForm").style.display = "none"; // 이메일 입력 폼 숨기기
}

// 이메일 저장
function saveEmail() {
  var newEmail = document.getElementById("emailInput").value; // 입력된 이메일 값 가져오기
  let memNo = document.querySelector("#memNo").value;//로그인 한 회원번호
  //newEmail :  karina22@naver.com
  console.log("newEmail : ", newEmail);
  console.log("memNo : ", memNo);

  //서버로 이메일 수정요청
  fetch('/oho/mypage/updateEmail', {
	  method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({"memNo":memNo,"memEmail":newEmail})
    })
    .then(response => response.json())
    .then(data => {
    	//map.put("success", "success");
      if (data.success) {
        // 이메일 수정이 성공하면, 화면에 수정된 이메일을 표시
        document.getElementById("changeEmail").innerText = newEmail;
        console.log("data.success",data.success);
        cancelEdit(); // 수정 폼 숨기기
      } else {
        alert("이메일 수정에 실패했습니다.");
      }
    })
    .catch(error => {
      console.error('Error:', error);
      alert("이메일 수정에 실패했습니다.");
    });
}//end saveEmail

//========================================================

//닉네임 수정 모드로 전환
function editNicknm() {
    document.getElementById("changeNick").style.display = "none"; // 기존 닉네임 버튼 숨기기
    document.getElementById("nickForm").style.display = "block"; // 닉네임 입력 폼 표시
  }
  
//닉네임 수정 취소
function cancleNick() {
  document.getElementById("changeNick").style.display = "block"; // 기존 이메일 버튼 표시
  document.getElementById("nickForm").style.display = "none"; // 닉네임 입력 폼 숨기기
}

// 닉네임 저장
function savenick() {
  var newNick = document.getElementById("nickInput").value; // 입력된 이메일 값 가져오기
  let memNo = document.querySelector("#memNo").value;//로그인 한 회원번호
  //newEmail :  karina22@naver.com
  console.log("newNick : ", newNick);
  console.log("memNo : ", memNo);

  //서버로 닉네임 수정요청
  fetch('/oho/mypage/updateNick', {
	  method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({"memNo":memNo,"memNicknm":newNick})
    })
    .then(response => response.json())
    .then(data => {
    	//map.put("success", "success");
      if (data.success) {
        // 닉네임 수정이 성공하면, 화면에 수정된 닉네임을 표시
        document.getElementById("changeNick").innerText = newNick;
        console.log("data.success",data.success);
        cancleNick(); // 수정 폼 숨기기
      } else {
        alert("닉네임 수정에 실패했습니다.");
      }
    })
    .catch(error => {
      console.error('Error:', error);
      alert("닉네임 수정에 실패했습니다.");
    });
}//end saveEmail
</script>
</html>