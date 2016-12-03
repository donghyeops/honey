<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="honey.HoneyBean" %>
<jsp:useBean id="member" class="honey.HoneyBean" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::나의정보수정</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand w3-padding-16" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
  <form method="post" action="/honey/HoneyControl"> 
  <ul class="w3-navbar w3-center w3-round-xxlarge w3-margin">
  	<li style="width:100%">
    	<ul class="w3-navbar w3-center">
    		<li class="w3-pale-yellow" style="width:40%">
    			<a href="#" class="w3-padding-16"><b>아이디</b></a>
    		</li>
    		<li class="w3-white" style="width:60%">
    			<a href="#" class="w3-padding-16"><b><%=member.getMember_id() %></b></a>
    		</li>
 	 	</ul>
  	</li>
  	<li style="width:100%">
    	<ul class="w3-navbar  w3-khaki w3-center">
    		<li style="width:40%">
            	<a href="#" class="w3-padding-16"><b>비밀번호</b></a>
            </li>
    		<li style="width:60%">
            	<input type="password" class="w3-input w3-white w3-padding-16" placeholder="Input Password" name="hc_pwd">
            </li>
 		</ul>
  	</li>
  	<li style="width:100%">
    	<ul class="w3-navbar  w3-yellow w3-center">
    		<li style="width:40%">
            	<a href="#" class="w3-padding-16"><b>변경할 비밀번호</b></a>
            </li>
    		<li style="width:60%">
            	<input type="password" class="w3-input w3-white w3-padding-16" placeholder="New password" name="member_pwd1">
            </li>
  		</ul>
    </li>
  	<li style="width:100%">
    	<ul class="w3-navbar  w3-amber w3-center">
    		<li style="width:40%">
            	<a href="#" class="w3-padding-16"><b>변경할 비밀번호 확인</b></a>
            </li>
    		<li style="width:60%"><input type="text" class="w3-input w3-white w3-padding-16" placeholder="Reinput new password" name="member_pwd2">
            </li>
  		</ul>
    </li>
    <li style="width:100%">
    	<ul class="w3-navbar  w3-orange w3-center">
    		<li style="width:40%">
            	<a href="#" class="w3-padding-16"><b>닉네임</b></a>
            </li>
    		<li style="width:60%"><input type="text" class="w3-input w3-white w3-padding-16" name="member_name" value="<%=member.getMember_name() %>">
            </li>
  		</ul>
    </li>
  </ul>
  <input type="hidden" name="action" value="updatemember">
  <input class="w3-btn w3-round-jumbo w3-green w3-margin" type="submit" value="변경하기">
  </form>
</div>
		<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>



</body>
</html>