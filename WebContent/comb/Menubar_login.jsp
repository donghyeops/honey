<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<title>허니::honeycomb</title>
	<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script  type = "text/javascript">
function ranking(){
	var div1 = document.getElementById("rank");
	var div2 = document.getElementById("newv");
	var div3 = document.getElementById("pan");
	var div4 = document.getElementById("upload");
		 div1.style.background="orange";
		 div2.style.background="rgba( 255, 255, 255, 0 )";
		 div3.style.background="rgba( 255, 255, 255, 0 )";
		 div4.style.background="rgba( 255, 255, 255, 0 )";
	}
	function newvideo(){
	var div1 = document.getElementById("rank");
	var div2 = document.getElementById("newv");
	var div3 = document.getElementById("pan");
	var div4 = document.getElementById("upload");
		div1.style.background="rgba( 255, 255, 255, 0 )";
		div2.style.background="orange";
		div3.style.background="rgba( 255, 255, 255, 0 )";
		 div4.style.background="rgba( 255, 255, 255, 0 )";
	}
	function makepan(){
	var div1 = document.getElementById("rank");
	var div2 = document.getElementById("newv");
	var div3 = document.getElementById("pan");
	var div4 = document.getElementById("upload");
		div1.style.background="rgba( 255, 255, 255, 0 )";
		div2.style.background="rgba( 255, 255, 255, 0 )";
		div3.style.background="orange";
		 div4.style.background="rgba( 255, 255, 255, 0 )";
	}
	function uplist(){
		var div1 = document.getElementById("rank");
		var div2 = document.getElementById("newv");
		var div3 = document.getElementById("pan");
		var div4 = document.getElementById("upload");
			div1.style.background="rgba( 255, 255, 255, 0 )";
			div2.style.background="rgba( 255, 255, 255, 0 )";
			div3.style.background="rgba( 255, 255, 255, 0 )";
			 div4.style.background="orange";
		}
	function myFunction() {
	    var x = document.getElementById("myaccount");
	    if (x.className.indexOf("w3-show") == -1) {
	        x.className += " w3-show";
	    } else { 
	        x.className = x.className.replace(" w3-show", "");
	    }
	}
</script>
</head>


<body>
<ul>
<div class="w3-row w3-display-topmiddle" style="margin:0px 0px 0px 0px;height:90px;width:100%">
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
  	<span class="w3-display-middle"><a href="HoneyControlB?action=upload"><button class="w3-btn w3-text-black w3-hover-orange" id="upload" style="background:rgba( 255, 255, 255, 0 )" >업로드</button></a></span>
  </div>
  <!-- 회원  -->
  <div class="w3-display-container w3-left w3-col w3-center" style="height:90px;width:12.5%">
  	<span class="w3-display-middle">	
 		 <div class="w3-dropdown-click">
    		<button onclick="myFunction()" class="w3-btn w3-text-black w3-hover-orange" style="background:rgba( 255, 255, 255, 0 )" ><%=session.getAttribute("member_id")%>님</button>
    			<div id="myaccount" class="w3-dropdown-content w3-border" style="right:0">
    			<a href="HoneyControlB?action=myhoneycomb">내 꿀통</a>
    			<a href="HoneyControlB?action=favoritehoneycomb">몰래 가져온 꿀통 </a>
   				<a href="HoneyControlB?action=mylist">내 게시글</a>
  				<a onclick="document.getElementById('Password').style.display='block'">정보수정</a>	
  				<a href="HoneyControlB?action=logout">로그아웃</a>
    			</div>
  		</div>
  	</span>
  </div>
</div>
</ul>





<div id="Password" class="w3-modal">
	<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width:600px">
	<div class="w3-center" src="/honey/comb/img/HoneyPattern.jpg"><br>
      <span onclick="document.getElementById('Password').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    </div>
		<form class="w3-container"  method="post" action="/honey/HoneyControlB">
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