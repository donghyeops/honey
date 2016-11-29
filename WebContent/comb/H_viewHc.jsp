<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.Mgr_bean" import="java.util.ArrayList"%>
<jsp:useBean id="HC" class="honey.Mgr_bean" scope="request"></jsp:useBean>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::<%=HC.getHc_title()%></title>
<style type="text/css">
#list {text-align : center;}
</style>
</head>
<body>

<div id="list">
<h1><a href="HoneyControlB?action=Main"><img src="/honey/comb/img/HoneyComb.png" width=90 height=90></a><br>Honeycomb<br><%=HC.getHc_title()%></h1> <br><hr><br>

<!-- 벌꿀 즐겨찾기부분 -->
<form method="post" action="/honey/HoneyControlB">
	<input type="hidden" name="hc_id" value="<%=HC.getHc_id()%>">
	<input type="hidden" name="from" value="Viewer?hc_id=<%=HC.getHc_id() %>">
	<input type="hidden" name="action" value="addFavoritehc">
	<input type="submit" value="추가하기">
</form>
<!--  -->

<%-- 편집 버튼 부분 --%>
<form action="/honey/Editor" method="post">
	<input type="hidden" name="type" value="edit">
	<input type="hidden" name="hc_id" value=<%=HC.getHc_id()%>>
	비밀번호<input type="password" name="input_pwd">
	<input type="submit" value="편집">
</form>

<br><hr><br>

<%
		if (HC.getURLs().size() == 0) {
			out.println("존재하지 않는 페이지 입니다.");
		}
		ArrayList<String> URLs = HC.getURLs(); 
		for(String url : URLs) {
		%>
			<%=url%>
			<br>
		<%} %>
</div>
</body>
</html>