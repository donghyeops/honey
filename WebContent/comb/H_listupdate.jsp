<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="honey" class="honey.HoneyBean" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::게시글수정</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>


<body>
<div class="w3-display-topmiddle w3-center w3-card-8 w3-round-xlarge w3-sand " style="margin: 200px 0px 50px 0px; width: 75%; max-width:1200px; min-width:400px; padding-bottom: 0%">
<form method="post" action="/honey/HoneyControl" style="margin: 70px 70px 0px 70px">
  <ul class="w3-navbar w3-center w3-yellow w3-round-jumbo w3-margin">
    <li style="width:30%"><a href="#" class="w3-padding-16"><b>리스트 제목</b></a></li>
    <li style="width:70%"><input type="text" name="list_title" class="w3-input w3-light-grey w3-padding-16" placeholder="Input Title.."></li>
  </ul>
  <ul class="w3-navbar w3-center w3-yellow w3-round-jumbo w3-margin">
    <li style="width:30%"><a href="#" class="w3-padding-16"><b>리스트 내용</b></a></li>
    <li style="width:70%"><input type="text" name="list_contents" class="w3-input w3-light-grey w3-padding-16" placeholder="Input Contents"></li>
  </ul>
  <%--
  <ul class="w3-navbar w3-center w3-yellow w3-round-jumbo w3-margin">
  	<li style="width:40%"><textarea class="w3-textarea w3-light-grey w3-padding-16" name="list_contents" placeholder="Input Contents.."></textarea></li>
  </ul> --%>
  <%--
<table>
<tr>
	<td>리스트 번호</td>
	<td><%=honey.getList_n() %>
	</td>
</tr>
<tr>
	<td>리스트 제목</td>
	<td><input type="text" name="list_title" value=<%=honey.getList_title() %>></td>
</tr>
<tr>
	<td>리스트 내용</td>
	<td><input type="text" name="list_contents" value=<%=honey.getList_contents() %>></td>
</tr>
<tr>
	<td>벌꿀 아이디</td>
	<td><input type="text" name="hc_id" value=<%=honey.getHc_id() %>></td>
</tr>
<tr>
	<td>벌꿀 비밀번호</td>
	<td><input type="password" name="hc_pwd"></td>
</tr>
</table>
 --%>
<input type="hidden" name="list_n" value=<%=honey.getList_n() %>>
<input type="hidden" name="action" value="list_update">
<div style="margin: 50px 0px 0px 0px"></div>
<input class="w3-btn w3-round-jumbo w3-green " style="width:50%; height:50px" type="submit" value="수정하기">
<%--<input type="submit" value="수정하기"> --%>
</form>
<div style="margin: 70px 0px 0px 0px"></div>
</div>
		<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>

<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div>

</body>
</html>