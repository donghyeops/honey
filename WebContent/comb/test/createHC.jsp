<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.Mgr_bean" import="java.util.ArrayList"%>
<jsp:useBean id="HC" class="honey.Mgr_bean" scope="session"></jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="HoneyControl">메인으로</a>
<script type="text/javascript">
// 	function add(url) {
// 		//HC.addURL(url)
// 		//list=HC.getURLs
// 		a=hc.test()
// 		alert(a)
// 	}
</script>

<%
	String mode = (String)request.getAttribute("mode");
	if (mode == null || !mode.equals("edit")) {
		mode = "create";
	}
%>

<hr>
<hr>
<div>
	<table border=1>
		<%
		int i=0;
		ArrayList<String> list = HC.getURLs(); 
		for(String url : list) {
		%>
		<tr>
			<td><%=url%></td>
			<td>
				<form name="del" action="/honey/Creator" method="post">
					<input type="hidden" name="type" value="delUrl">
					<input type="hidden" name="mode" value=<%=mode%>>
					<input type="hidden" name="index" value=<%=i++%>>
					<input type=submit value="제거">
				</form>
			</td>
		</tr>
		<%} %>
	</table>
	
	<br>
	<hr>
	<br>
	
	<form name="url_form" action="/honey/Creator" method="post">
		<fieldset>
			<legend>안녕!! <%=mode%></legend>
			<input type="hidden" name="type" value="addUrl">
			<input type="hidden" name="mode" value=<%=mode%>>
			<input type="text" name="URL">
			<input type="submit" value="추가">
		</fieldset>
	</form>
	<br>
	<form name="url_form3" action="/honey/Creator" method="post">
		<fieldset>
			<input type="hidden" name="type" value="viewHC">
			<input type="hidden" name="mode" value=<%=mode%>>
			제목 <input type="text" name="hc_title"><br>
			비밀번호 <input type="password" name="hc_pwd"><br>
			<input type="submit" value="생성">
		</fieldset>
	</form>
	<br>
	<br>
	<%
		Object result = request.getAttribute("result");
		if (request.getAttribute("result") != null) { %>
	<fieldset>
		<legend>결과 주소</legend>
		<textarea readonly name="result" rows="2" cols="100" onclick="this.select()"><%= (String)result %></textarea>
	</fieldset>
	<% } %>
</div>

</body>
</html>