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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <!-- background-color:rgba( 255, 255, 255, 0 );배경투명색 -->
<script  type = "text/javascript">
function myFunction() {
    var x = document.getElementById("demo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else { 
        x.className = x.className.replace(" w3-show", "");
    }
}
function w3_open() {
  document.getElementById("main").style.marginLeft = "25%";
  document.getElementById("mySidenav").style.width = "25%";
  document.getElementById("mySidenav").style.display = "block";
}
function w3_close() {
  document.getElementById("main").style.marginLeft = "0%";
  document.getElementById("mySidenav").style.display = "none";
}
</script>
	
</head>
<body>

<nav class="w3-sidenav w3-white w3-card-2" style="display:none" id="mySidenav">
  <a href="javascript:void(0)" 
  onclick="w3_close()"
  class="w3-closenav w3-large w3-black"><b>Close &times;</b></a>
  <a href="#" class="w3-amber" value="로그인" onclick="document.getElementById('LogIn').style.display='block'"><b>로그인</b></a>
  <a href="HoneyControlB?action=ranking"><b>랭킹</b></a>
  <a href="HoneyControlB?action=newvideo"><b>최신 영상</b></a>
  <a href="HoneyControlB?action=hccreate"><b>꿀통 작성</b></a>
  <a href="#" value="업로드" onclick="document.getElementById('LogIn').style.display='block'"><b>업로드</b></a>
</nav>

<div id="main">
<ul class="w3-navbar w3-yellow w3-card-8">
  <li><a href="/honey/HoneyControlB?action=Main" class=" w3-medium"><img src="/honey/comb/img/HoneyComb.png" width=70px height=70px></a></li>
  <li class="w3-hide-medium w3-hide-large w3-black w3-opennav ">
    <a href="#" class="w3-opennav w3-xlarge" onclick="w3_open()" id="openNav">☰</a>
  </li>
  <li class="w3-hide-small" style="width:100px"><a href="HoneyControlB?action=ranking" class="w3-padding-32" ><b>랭킹</b></a></li>
  <li class="w3-hide-small" style="width:100px"><a href="HoneyControlB?action=newvideo" class="w3-padding-32" ><b>최신 영상</b></a></li>
  <form method="post" action="/honey/Search">
  <li class="w3-hide-small w3-hide-medium" style="padding:12px 0px 12px 0px"><input type="text" name="search" class="w3-light-gray w3-input w3-padding-16" placeholder="키워드 검색" style="width:250px; height:60px"></li>
  <li class="w3-hide-small w3-hide-medium" style="padding:12px 0px 12px 0px"><button type="submit" class="w3-btn w3-amber w3-padding-16" style="height:60px">Go</button></li>
  </form>
  <li class="w3-hide-small w3-right w3-medium" style="width:100px"><a href="#" class="w3-padding-32" value="로그인" onclick="document.getElementById('LogIn').style.display='block'"><b>로그인</b></a></li>
  <li class="w3-hide-small w3-right w3-medium" style="width:100px"><a href="#" class="w3-padding-32" value="업로드" onclick="document.getElementById('LogIn').style.display='block'"><b>업로드</b></a></li>
  <li class="w3-hide-small w3-right w3-medium" style="width:100px"><a href="HoneyControlB?action=hccreate" class="w3-padding-32"><b>꿀통 작성</b></a></li>
  <li class="w3-hide-large w3-hide-small w3-dropdown-click w3-right">
      <a onclick="myFunction()" href="#" class="w3-padding-32" style="width: 10%"><i class="fa fa-search"></i></a>
      <div id="demo" class="w3-dropdown-content w3-white w3-card-4" style="width:50%; right:252px">
      <ul class="w3-navbar">
       <form method="post" action="/honey/Search">
        <li><input type="text" name="search" class="w3-input" placeholder="키워드 검색" ></li>
  <li class="w3-right"><button type="submit" class="w3-btn w3-amber">Go</button></li>
</form>
  </ul>
      </div>
    </li>
</ul>
</div>


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

