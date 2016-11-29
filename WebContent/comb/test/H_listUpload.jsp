<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.HoneyBean"%>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="./css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<body>

<%if(session.getAttribute("member_id")==null){ %>
<script> alert("로그인 해주십쇼."); location.replace("/honey/HoneyControlB"); </script>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>

<!-- 벌집 리스트 출력 -->
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1600px; height: 1600px; padding: 0% 0px 0% 0px">
	<h2>아무 벌집 업로드</h2>  
		<div class="w3-btn-group " style="width: 80%; margin: 0px 15% 20px 15%">
		<button class="w3-btn w3-white w3-xlarge w3-round-large" style="width:90%%"></button>
		<a onclick="document.getElementById('Upload').style.display='block'" class="w3-btn-floating-large w3-amber">+</a>
	</div>
	<div id="Upload" class="w3-modal">
    	<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width: 600px">
      		<div class="w3-center">
				<span onclick="document.getElementById('Upload').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    			<form class="w3-container" method="post" action="/honey/HoneyControlB">
      				<div class="w3-section">
        				<label><b>제목</b></label>
        				<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Title" name="list_title" required>
        				<label><b>본문 내용</b></label>
        				<input class="w3-input w3-border" type="text" placeholder="Enter Contents" name="list_contents" required>
        				<label><b>꿀집 아이디</b></label>
        				<input class="w3-input w3-border" type="text" placeholder="Enter Contents" name="hc_id" required>
        				<label><b>꿀집 비밀번호</b></label>
        				<input class="w3-input w3-border" type="password" placeholder="Enter Contents" name="hc_pwd" required>
        				<input type="hidden" name="action" value="list_upload_anyhc">
        				<button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">게시판에 업로드</button>
      				</div>
    			</form>
     		</div>
    	</div>
    </div>
<h2>내 벌집 업로드</h2>
	<%
		for(int i=0; i<eventlist.size(); i++) {
		HoneyBean event = (HoneyBean)eventlist.get(i);
	%>
	<div class="w3-btn-group " style="width: 80%; margin: 0px 15% 20px 15%">
		<button class="w3-btn w3-white w3-xlarge w3-round-large" style="width:90%%"><%=event.getHc_title()%></button>
		<a onclick="document.getElementById('Upload<%=i%>').style.display='block'" class="w3-btn-floating-large w3-amber">+</a>
	</div>
	
	<div id="Upload<%=i%>" class="w3-modal">
    	<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width: 600px">
      		<div class="w3-center">
				<span onclick="document.getElementById('Upload<%=i%>').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    			<form class="w3-container" method="post" action="/honey/HoneyControlB">
      				<div class="w3-section">
        				<label><b>제목</b></label>
        				<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Title" name="list_title" required>
        				<label><b>본문 내용</b></label>
        				<input class="w3-input w3-border" type="text" placeholder="Enter Contents" name="list_contents" required>
        				<input type="hidden" name="action" value="list_upload">
        				<input type="hidden" name="hc_id" value=<%=event.getHc_id() %>>
        				<button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">게시판에 업로드</button>
      				</div>
    			</form>
     		</div>
    	</div>
    </div>
	<%}
	%>	
	
</div>
	

<script>uplist();</script>

</body>
</html>
