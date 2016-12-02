<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<title>신동협 서준배 공주식 입니당</title>
	<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">


</head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<body>
<div class="w3-container">
		<ul class="w3-large w3-center">
			<div class="w3-left">
			<li><a href="HoneyControl?action=Main"><img src="/honey/comb/img/HoneyComb.png" width=90 height=90></a></li>
			<li id="HoneyButton" style="margin: 30px 2% 0px 2%"><a href="HoneyControl?action=ranking">랭킹</a></li>
			<li id="HoneyButton" style="margin: 30px 2% 0px 2%"><a href="HoneyControl?action=newvideo">최신영상</a></li>
		</div>
		<div class="w3-right">	
			<li id="HoneyButton" style="margin: 30px 10px 0px 10px"><a href="HoneyControl?action=upload">업로드</a></li>
			<li id="HoneyButton"><a href="HoneyControl?action=hccreate">판작성</a></li>
			
			<li id="HoneyButton">		
				<div class="dropdown">
  					<label>Dropdown</lable>
  					<div class="dropdown-content">
    					<a href="HoneyControl?action=myhoneycomb">내 꿀통</a>
    					<a href="HoneyControl?action=favoritehoneycomb">몰래 가져온 꿀통 </a>
    					<a href="HoneyControl?action=mylist">내 게시글</a>
    					<a onclick="document.getElementById('Password').style.display='block'" class="w3-large ">정보수정</a>	
    					<a href="HoneyControl?action=logout">로그아웃</a>
  					</div>
				</div>
		</div>
		
		<form class="w3-middle" action="#" method="post" style="margin: 30px 10px 0px 10px">
				<input type="text" placeholder="  키워드 검색" name="sentence">
		</form>
		
		</ul>
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