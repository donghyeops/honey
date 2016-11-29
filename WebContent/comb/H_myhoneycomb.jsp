<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" %>
 <%@ page import="honey.HoneyBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="myhoney" class="java.util.ArrayList" scope="request"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::나의 꿀통들</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>


<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
<!-- 꿀통 추가하기 -->
<div>
<form method="post" action="/honey/HoneyControlB">
<table border="1">
	<tr>
		<td>추가할 꿀통</td>
		<td><input type="text" name="hc_id"></td>
	</tr>
	<tr>
		<td>꿀통 비밀번호</td>
		<td><input type="password" name="hc_pwd"></td>
	</tr>	
</table>
	<input type="hidden" name="action" value="addhc">
	<input type="submit" value="추가하기">
</form>
</div>
<!-- 꿀통추가 끝 -->

<!-- 꿀통 표시 -->
<div>

	<table border="1">
		<tr>
			<td>꿀통아이디</td>
			<td>꿀통제목</td>
			<td>링크</td>
			<td>편집</td>
		</tr>
		<%	out.println(myhoney.size());
			for(int i=0;i<myhoney.size();i++){
				HoneyBean event =(HoneyBean)myhoney.get(i);
		%>
		<tr>
			<td><%=event.getHc_id() %></td>
			<td><%=event.getHc_title() %></td>
			<td><a href="Viewer?hc_id=<%=event.getHc_id()%>">가자!</a></td>
			<td><form action="/honey/Editor" method="post">
					<input type="hidden" name="type" value="edit">
					<input type="hidden" name="hc_id" value=<%=event.getHc_id()%>>
					<input type="hidden" name="input_pwd" value="<%=event.getHc_pwd() %>">
					<input type="submit" value="편집">
				</form>
			</td>
		</tr>
		<%} %> 
	</table>
	

</div>
<!-- 꿀통 표시끝 -->
</div>

	
	
	
<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>

	
	
</body>
</html>


