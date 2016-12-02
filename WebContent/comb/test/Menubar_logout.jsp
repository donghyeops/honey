<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html>
<head> 
<title>신동협 서준배 공주식 입니당</title>
	<link rel="stylesheet" type="text/css" href="/honey/comb/css/HoneyStyle.css">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>


<body>
<ul>
<div class="w3-display-container" >
<div class="w3-row">	
	<div class="w3-container w3-half">			
		<div class="w3-left w3-padding w3-margin-right">
			<li><a href="HoneyControl?action=Main"><img src="/honey/comb/img/HoneyComb.png" width=90 height=90></a></li>
		</div>
		<div class="w3-left w3-padding w3-margin-right" style="width:130px">
			<li id="HoneyButton" style="margin: 30px 2% 0px 2%"><a href="HoneyControl?action=ranking">랭킹</a></li>
		</div>
		<div class="w3-left w3-padding w3-margin-right" style="width:130px">
			<li id="HoneyButton" style="margin: 30px 2% 0px 2%"><a href="HoneyControl?action=newvideo">최신영상</a></li>
		</div>
		<div class="w3-display-middle">
		<form action="#" method="post">
				<input type="text" placeholder="키워드 검색" name="sentence">
		</form>	
		</div>	
	</div>
	<div class="w3-container  w3-half">	
		<div class="w3-right w3-padding w3-margin-left " style="width:130px">	
			<li id="HoneyButton" style="margin: 30px 10px 0px 10px"><a onclick="document.getElementById('LogIn').style.display='block'">업로드</a></li>
		</div>
		<div class="w3-right w3-padding w3-margin-left" style="width:130px">		
			<li id="HoneyButton"><a href="HoneyControl?action=hccreate">판작성</a></li>
		</div>
		<div class="w3-right w3-padding w3-margin-left" style="width:130px">		
			<li id="HoneyButton"><a onclick="document.getElementById('LogIn').style.display='block'" class="w3-large ">로그인</a></li>		
		</div>
		<div class="w3-right w3-padding w3-margin-left" style="width:130px">		
			<li id="HoneyButton"><a onclick="document.getElementById('SignUp').style.display='block'" class="w3-large ">회원가입</a></li>	
		</div>	
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
    <form class="w3-container" method="post" action="/honey/HoneyControl">
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
    <form class="w3-container"  method="post" action="/honey/HoneyControl">
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