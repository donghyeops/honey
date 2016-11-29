<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.HoneyBean"%>
<jsp:useBean id="fvhoney" class="java.util.ArrayList" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::몰래가져온 꿀통</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
<!-- 꿀통 추가 -->
<div>
<form method="post" action="/honey/HoneyControlB">
<table border="1">
	<tr>
		<td>추가할 hc_id</td>
		<td><input type="text" name="hc_id"></td>
	</tr>
</table>
	<input type="hidden" name="from" value="HoneyControlB?action=favoritehoneycomb">
	<input type="hidden" name="action" value="addFavoritehc">
	<input type="submit" value="추가하기">
</form>
</div>
<!-- 추가 끝 -->



<!-- 벌꿀표시 -->
<div>
<table border="1">
		<tr>
			<td>벌꿀아이디</td>
			<td>벌꿀제목</td>
			<td>링크</td>
			<td>제작자아이디</td>
		</tr>
		<%	out.println(fvhoney.size());
			for(int i=0;i<fvhoney.size();i++){
				HoneyBean event =(HoneyBean)fvhoney.get(i);
		%>
		<tr>
			<td><%=event.getHc_id() %></td>
			<td><%=event.getHc_title() %></td>
			<td><a href="Viewer?hc_id=<%=event.getHc_id()%>">가자!</a></td>
			<td><%=event.getMember_id() %>
			</td>
		</tr>
		<%} %> 
	</table>


</div>
<!-- 벌꾸표시끝 -->
</div>
<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>



</body>
</html>