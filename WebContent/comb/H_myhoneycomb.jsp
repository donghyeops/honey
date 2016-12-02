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
	<!-- 게시글 페이지수 -->
<!--총 페이지수 -->
<% int all_p=((myhoney.size()-1)/10)+1; %>
<!--남은 게시글수 -->
<% int remain_p=myhoney.size()%10;  %>
<!--  페이지에 따라 시작하는 번호 1+(10*(page_n-1)) -->


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
		<%
		int rutin=10;
		int page_n=1;
		if(request.getParameter("page_n")==null){
			//out.println("/페이지못받음");
			page_n=1;
		}else{
			//out.println("/페이지받음");
		page_n=Integer.parseInt(request.getParameter("page_n"));//현재 페이지
		
		}
		
		if(page_n==all_p&&remain_p!=0||myhoney.size()==0){//마지막 페이지인 경우
			rutin=remain_p;
		}else{
			rutin=10;
		}
		
		//out.println("/현재 출력행야하는 게시글"+rutin);
		//out.println("/현재 페이지"+page_n);
		//out.println("/총게시글"+eventlist.size());
		int view_p=(1+(10*(page_n-1)))-1;
		for(int i=view_p; i<(view_p+rutin); i++) {
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
	<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<% if(view_a-1>0){%>
		<a href="?action=myhoneycomb&page_n=<%=view_a-1%>">이전</a>
	<%} %>
	<%for(int s=view_a;s<view_a+remain_a;s++) {%>
		<a href="?action=myhoneycomb&page_n=<%=s%>"><%=s%></a>
	<%} %>
	<% if(all_p-view_a>10){%>
		<a href="?action=myhoneycomb&page_n=<%=view_a+10%>">다음</a>
	<%} %>
		

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


