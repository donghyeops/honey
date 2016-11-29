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
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
<form type="post" action="/honey/HoneyControlB">
	<table border="1">
		<tr>
		<td>아이디</td>
		<td><%=member.getMember_id() %></td>
		<td></td>
		</tr>
		<tr>
		<td>변경할비밀번호</td>
		<td><input type="password" name="member_pwd1"></td>
		</tr>
		<tr>
		<td>변경할 비밀번호 확인</td>
		<td><input type="password" name="member_pwd2"></td>
		</tr>
		<tr>
		<td>닉네임</td>
		<td><input type="text" name="member_name" value="<%=member.getMember_name() %>"></td>
		</tr>
		<tr>
		<td>이메일</td>
		<td><input type="text" name="member_mail" value="<%=member.getMember_name() %>"></td>
		</tr>
	</table>
	<input type="hidden" name="action" value="updatemember">
	<input type="submit" value="변경하기">
</form>
</div>
		<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>



</body>
</html>