<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" import="honey.Mgr_bean" import="honey.HoneyBean" %>
<jsp:useBean id="HC_id" class="honey.Mgr_bean" scope="request"/>
<jsp:useBean id="HC_title" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="LIST_title" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="LIST_contents" class="java.util.ArrayList" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 동일한 꿀통 아이디 -->
<table border="1">
<tr><td>해당 꿀통</td>
<%
	if (HC_id.getURLs().size() == 0) {
		%><tr>일치하는 꿀통이 없습니다.</tr><%
	}else{
	ArrayList<String> URLs = HC_id.getURLs(); 
	%>
	<tr><td><%=HC_id.getHc_title() %></td>
	</tr>
	<%
	for(String url : URLs) {
	%>	
	<tr>
		<td><%=url%></td>	
	</tr>
	<%}
	}%>
</table>

<!-- 일치하는 꿀통 제목 -->

<table border="1">
<tr>
	<td>일치하는 꿀통 제목</td>
</tr>
<tr>
	<td>제목</td>
	<td>작성자</td>
</tr>
<%
			for(int i=0;i<HC_title.size();i++){
				HoneyBean HBtitle =(HoneyBean)HC_title.get(i);
		%>
<tr>
	<td>
	<a href="Viewer?hc_id=<%=HBtitle.getHc_id()%>"><%= HBtitle.getHc_title()%></a>
	</td>
	<td><%= HBtitle.getMember_id()%></td>
</tr>
<%} %>

</table>


<!-- 일치하는 게시판 제목 -->
<table border="1">
<tr>
	<td>일치하는 게시판 제목</td>
</tr>
<tr>
	<td>제목</td>
	<td>작성자</td>
	<td>작성일</td>
</tr>
<%
			for(int i=0;i<LIST_title.size();i++){
				HoneyBean list_t =(HoneyBean)LIST_title.get(i);
		%>
<tr>
	<td>
	
	<a href="HoneyControlB?action=viewlist&from=newvideo&list_n=<%=list_t.getList_n() %>">
  			<%=list_t.getList_title() %>
	</a>
	
	</td>
	<td><%= list_t.getMember_id()%></td>
	<td><%= list_t.getList_time()%></td>
	
</tr>
<%} %>

</table>

<!-- 일치하는 게시판 내용 -->
<table border="1">
<tr>
	<td>일치하는 게시판 내용</td>
</tr>
<tr>
	<td>제목</td>
	<td>작성자</td>
	<td>작성일</td>
</tr>
<%
			for(int i=0;i<LIST_contents.size();i++){
				HoneyBean list_c =(HoneyBean)LIST_contents.get(i);
		%>
<tr>
	<td>
	<a href="HoneyControlB?action=viewlist&from=newvideo&list_n=<%=list_c.getList_n() %>">
  			<%=list_c.getList_title() %>
	</a>
	</td>
	<td><%= list_c.getMember_id()%></td>
	<td><%= list_c.getList_time()%></td>
</tr>
<%} %>

</table>

</body>
</html>