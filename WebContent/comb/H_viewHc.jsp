<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.Mgr_bean" import="java.util.ArrayList"%>
<jsp:useBean id="HC" class="honey.Mgr_bean" scope="request"></jsp:useBean>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::<%=HC.getHc_title()%></title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
#list {text-align : center;}

body {
        background: linear-gradient( to bottom, #EDCA35, #FFEDA0 );
      }
h1 {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
</head>
<body>

<div id="list">
<h1><a href="HoneyControl?action=Main"><img src="/honey/comb/img/HoneyComb.png" width=150 height=150></a><br><br><%=HC.getHc_title()%></h1> <br><br>

<!-- 벌꿀 즐겨찾기부분 -->
<form method="post" action="/honey/HoneyControl">
	<input type="hidden" name="hc_id" value="<%=HC.getHc_id()%>">
	<input type="hidden" name="from" value="Viewer?hc_id=<%=HC.getHc_id() %>">
	<input type="hidden" name="action" value="addFavoritehc">
	<input type="submit" value="내 계정에 담기">
</form>
<!--  -->

<%-- 편집 버튼 부분 --%>
<form action="/honey/Editor" method="post">
	<input type="hidden" name="type" value="edit">
	<input type="hidden" name="hc_id" value=<%=HC.getHc_id()%>>
	비밀번호<input type="password" name="input_pwd">
	<input type="submit" value="편집">
</form>

<br><br>

<%
		if (HC.getURLs().size() == 0) {
			out.println("존재하지 않는 페이지 입니다.");
		}
		ArrayList<String> URLs = HC.getURLs(); 
		for(String url : URLs) {
		%>
			<%=url%>
			<br><br>
		<%} %>
</div>
</body>
</html>