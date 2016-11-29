<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>허니::honeycomb</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="/honey/comb/css/HoneyStyle.css">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
  <!-- background-color:rgba( 255, 255, 255, 0 );배경투명색 -->
<script  type = "text/javascript">
function ranking(){
	var div1 = document.getElementById("rank");
	var div2 = document.getElementById("newv");
	var div3 = document.getElementById("pan");
		 div1.style.background="orange";
		 div2.style.background="rgba( 255, 255, 255, 0 )";
		 div3.style.background="rgba( 255, 255, 255, 0 )";
	}
	function newvideo(){
	var div1 = document.getElementById("rank");
	var div2 = document.getElementById("newv");
	var div3 = document.getElementById("pan");
		div1.style.background="rgba( 255, 255, 255, 0 )";
		div2.style.background="orange";
		div3.style.background="rgba( 255, 255, 255, 0 )";
	}
	function makepan(){
	var div1 = document.getElementById("rank");
	var div2 = document.getElementById("newv");
	var div3 = document.getElementById("pan");
		div1.style.background="rgba( 255, 255, 255, 0 )";
		div2.style.background="rgba( 255, 255, 255, 0 )";
		div3.style.background="orange";
	}
</script>
	
</head>
<body>

<ul>
<div class="w3-row"  style="margin:0px 0px 0px 0px;height:90px">

  <!-- 아이콘 -->
  <div class="w3-display-container w3-left w3-col" style="height:90px;width:12.5%">
  <div class="w3-display-middle"><a href="/honey/HoneyControlB?action=Main"><img src="/honey/comb/img/HoneyComb.png" width=90px height=90px></a></div>
  </div>
   <!-- 검색,랭킹,최신 -->
  <div class="w3-col w3-left " style="width:50%">
    <div class="w3-display-container w3-col w3-center" style="height:45px">
   		<span class="w3-display-middle w3-col">
   		<form action="#" method="post">
			<input  style="width:95%" type="text" placeholder="키워드 검색" name="sentence">
		</form>	
		</span>
    </div>
    <div class="w3-display-container w3-half w3-center" style="height:45px">
     	<span class="w3-display-middle"><a href="HoneyControlB?action=ranking"><button class="w3-btn w3-text-black w3-hover-orange" id="rank" style="background:rgba( 255, 255, 255, 0 )">인기순</button></a></span>
    </div>
    <div class="w3-display-container w3-half w3-center" style="height:45px">
    	<span class="w3-display-middle"><a href="HoneyControlB?action=newvideo"><button class="w3-btn  w3-text-black w3-hover-orange" id="newv" style="background:rgba( 255, 255, 255, 0 )">최신순</button></a></span>
    </div>
  </div>
  <!-- 벌집 작성작성 -->
  <div class="w3-display-container w3-left w3-col w3-center" style="height:90px;width:12.5%">
  	<span class="w3-display-middle"><a href="HoneyControlB?action=hccreate"><button class="w3-btn  w3-text-black w3-hover-orange" id="pan" style="background:rgba( 255, 255, 255, 0 )">꿀통 작성</button></a></span>
  </div>
  <!-- 업로드 -->
  <div class="w3-display-container w3-left w3-col w3-center" style="height:90px;width:12.5%">
  	<span class="w3-display-middle"><input type="button" class="w3-btn w3-text-black w3-hover-orange" style="background:rgba( 255, 255, 255, 0 )" value="업로드" onclick="document.getElementById('LogIn').style.display='block'"></span>
  </div>
  <!-- 로그인 로그아웃  -->
  <div class="w3-left" style="width:12.5%">
  	<div class=" w3-display-container w3-col w3-center" style="height:45px">
  	  <span class="w3-display-middle"><input type="button" class="w3-btn w3-text-black w3-hover-orange" style="background:rgba( 255, 255, 255, 0 )" value="로그인" onclick="document.getElementById('LogIn').style.display='block'"></span>
  	</div>
  	<div class="w3-display-container w3-col w3-center" style="height:45px">
  	  <span class="w3-display-middle"><input type="button" class="w3-btn w3-text-black w3-hover-orange" style="background:rgba( 255, 255, 255, 0 )" value="회원가입" onclick="document.getElementById('SignUp').style.display='block'"></span>
  	</div>
  </div>

</div>
</ul>


 <div id="LogIn" class="w3-modal">
   <div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width:600px">
    <div class="w3-center" src="/honey/comb/img/HoneyPattern.jpg"><br>
      <span onclick="document.getElementById('LogIn').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    </div>
    <!-- 로그인 폼 -->
    <form class="w3-container" method="post" action="/honey/HoneyControlB">
      <div class="w3-section">
        <label><b>아이디</b></label>
        <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter ID" name="member_id" required>
        <label><b>비밀번호</b></label>
        <input class="w3-input w3-border" type="password" placeholder="Enter Password" name="member_pwd" required>
        <input type="hidden" name="action" value="login">
        <button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">로그인</button>
      </div>
    </form>

    <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
      <button onclick="document.getElementById('SignUp').style.display='block'" type="button" class="w3-btn w3-green">회원가입</button>
      <span class="w3-right w3-padding w3-hide-small"><a href="#">비밀번호 찾기</a></span>
    </div>

  </div>
</div>
<div id="SignUp" class="w3-modal">
   <div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width:600px">
    <div class="w3-center" src="/honey/comb/img/HoneyPattern.jpg"><br>
      <span onclick="document.getElementById('SignUp').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    </div>
    
     <!-- 회원가입 폼 -->
    <form class="w3-container"  method="post" action="/honey/HoneyControlB">
      <div class="w3-section">
        <label><b>아이디</b></label>
        <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter ID" name="member_id" required>
        <label><b>비밀번호</b></label>
        <input class="w3-input w3-border w3-margin-bottom" type="password" placeholder="Enter Password" name="member_pwd" required>
        <label><b>비밀번호 재입력</b></label>
        <input class="w3-input w3-border w3-margin-bottom" type="password" placeholder="Enter Password" name="member_pwd2" required>
        <label><b>닉네임 입력</b></label>
        <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Nickname" name="member_name" required>
        <label><b>메일</b></label>
        <input class="w3-input w3-border" type="text" placeholder="Enter mail address" name="member_mail" required>
         <input type="hidden" name="action" value="gojoin">
        <button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">회원가입</button>
      </div>
    </form>

    <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
    </div>

  </div>
</div>

</body>
</html>

