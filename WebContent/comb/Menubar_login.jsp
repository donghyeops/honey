<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
  document.getElementById("main").style.marginLeft = "40%";
  document.getElementById("mySidenav").style.width = "40%";
  document.getElementById("mySidenav").style.display = "block";
}
function w3_close() {
  document.getElementById("main").style.marginLeft = "0%";
  document.getElementById("mySidenav").style.display = "none";
}
function w3_Useropen() {
    document.getElementById("UserSidenav").style.display = "block";
}
function w3_Userclose() {
    document.getElementById("UserSidenav").style.display = "none";
}
</script>
	
</head>
<body>

<nav class="w3-sidenav w3-white w3-card-2" style="display:none" id="mySidenav">
  <a href="javascript:void(0)" 
  onclick="w3_close()"
  class="w3-closenav w3-large w3-black"><b>Close &times;</b></a>
  <div class="w3-accordion w3-amber">
    <button onclick="myFunction('User')" class="w3-btn-block w3-left-align"><b><%=session.getAttribute("member_id")%>님</b></button>
    <div id="User" class="w3-accordion-content w3-container">
      <a href="HoneyControl?action=myhoneycomb" class="w3-padding-8"><b>내 꿀통</b></a>
  	  <a href="HoneyControl?action=favoritehoneycomb" class="w3-padding-8"><b>몰래 가져온 꿀통</b></a>
  	  <a href="HoneyControl?action=mylist" class="w3-padding-8"><b>내 게시글</b></a>
  	  <a onclick="document.getElementById('Password').style.display='block'" class="w3-padding-8"><b>정보수정</b></a>
  	  <a href="HoneyControl?action=logout" class="w3-padding-8"><b>로그아웃</b></a>
    </div>
  </div>
  <a href="HoneyControl?action=ranking"><b>랭킹</b></a>
  <a href="HoneyControl?action=newvideo"><b>최신 영상</b></a>
  <a href="HoneyControl?action=hccreate"><b>꿀통 작성</b></a>
  <a href="HoneyControl?action=upload" ><b>업로드</b></a>
</nav>
 
<nav class="w3-sidenav w3-white w3-card-2 w3-animate-right w3-center w3-bold" style="display:none; width:200px; height: 235px; right:0; top:86px" id="UserSidenav">
  <a href="HoneyControl?action=myhoneycomb" class="w3-padding-8"><b>내 꿀통</b></a>
  <a href="HoneyControl?action=favoritehoneycomb" class="w3-padding-8"><b>몰래 가져온 꿀통</b></a>
  <a href="HoneyControl?action=mylist" class="w3-padding-8"><b>내 게시글</b></a>
  <a onclick="document.getElementById('Password').style.display='block'" class="w3-padding-8"><b>정보수정</b></a>
  <a href="HoneyControl?action=logout" class="w3-padding-8"><b>로그아웃</b></a>
  <a href="javascript:void(0)" onclick="w3_Userclose()"
  class="w3-closenav w3-large w3-padding-8">Close &times;</a>
</nav>

<div id="main">
<form method="post" action="/honey/Search" style="margin:0">
<ul class="w3-navbar w3-yellow w3-card-8">
  <li><a href="/honey/HoneyControl?action=Main" class=" w3-medium"><img src="/honey/comb/img/HoneyComb.png" width=70px height=70px></a></li>
  <li class="w3-hide-medium w3-hide-large w3-black w3-opennav ">
    <a href="#" class="w3-opennav w3-xlarge" onclick="w3_open()" id="openNav">☰</a>
  </li>
  <li class="w3-hide-small" style="width:100px"><a href="HoneyControl?action=ranking" class="w3-padding-32" ><b>랭킹</b></a></li>
  <li class="w3-hide-small" style="width:100px"><a href="HoneyControl?action=newvideo" class="w3-padding-32" ><b>최신 영상</b></a></li>
  <li class="w3-hide-small w3-hide-medium" style="padding:12px 0px 12px 0px"><input type="text" name="search" class="w3-light-gray w3-input w3-padding-16" placeholder="키워드 검색" style="width:250px; height:60px"></li>
  <li class="w3-hide-small w3-hide-medium" style="padding:12px 0px 12px 0px"><button type="submit" class="w3-btn w3-amber w3-padding-16" style="height:60px">Go</button></li>
  <li class="w3-hide-small w3-right w3-medium w3-opennav" style="width:100px"><a href="#" class="w3-padding-32" onclick="w3_Useropen()"><b><%=session.getAttribute("member_id")%>님</b></a></li>
  <li class="w3-hide-small w3-right w3-medium" style="width:100px"><a href="HoneyControl?action=upload" class="w3-padding-32"><b>업로드</b></a></li>
  <li class="w3-hide-small w3-right w3-medium" style="width:100px"><a href="HoneyControl?action=hccreate" class="w3-padding-32"><b>꿀통 작성</b></a></li>
  <li class="w3-hide-large w3-hide-small w3-dropdown-click w3-right">
      <a onclick="myFunction()" href="#" class="w3-padding-32" style="width: 10%"><i class="fa fa-search"></i></a>
      <div id="demo" class="w3-dropdown-content w3-white w3-card-4" style="width:50%; right:252px">
      <ul class="w3-navbar">
        <li><input type="text" name="search" class="w3-input" placeholder="키워드 검색" ></li>
  <li class="w3-right"><button type="submit" class="w3-btn w3-amber">Go</button></li>
  </ul>
      </div>
    </li>
</ul>
</form>
</div>

<div id="Password" class="w3-modal">
	<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width:600px">
	<div class="w3-center" src="/honey/comb/img/HoneyPattern.jpg"><br>
      <span onclick="document.getElementById('Password').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    </div>
		<form class="w3-container"  method="post" action="/honey/HoneyControl">
			<div class="w3-section">
			<label><b>비밀번호확인</b></label>
        	<input class="w3-input w3-border w3-margin-bottom" type="password" placeholder="Enter Password" name="member_pwd2" required>
        	<input type="hidden" name="action" value="modmember">
      		<button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">확인</button>
			</div>			
		</form>
	</div>
</div>

</body>
</html>