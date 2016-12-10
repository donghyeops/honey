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


<div class="w3-display-topmiddle w3-center w3-card-8 w3-round-xlarge w3-sand" style="margin: 150px 0px 50px 0px; width: 80%; max-width:1200px; min-width:400px; padding-bottom: 0%">
<!-- 꿀통 추가하기 -->
<div class="w3-container w3-center">
<form method="post" action="/honey/HoneyControl"> 
  <ul class="w3-navbar w3-center w3-round-xxlarge w3-margin">
  	<li style="width:100%">
  		<ul class="w3-navbar  w3-yellow w3-center">
  			<li style="width:40%"><a href="#" class="w3-padding-16"><b>추가할 꿀동</b></a></li>
  			<li style="width:60%"><input type="text" class="w3-input w3-white w3-padding-16" placeholder="Input Honecomb ID" name="hc_id"></li>
  		</ul>
  	</li>
  	<li style="width:100%">
  		<ul class="w3-navbar  w3-amber w3-center">
  			<li style="width:40%"><a href="#" class="w3-padding-16"><b>꿀통 비밀번호</b></a></li>
  			<li style="width:60%"><input type="text" class="w3-input w3-white w3-padding-16" placeholder="Input Honeycomb Password" name="hc_pwd"></li>
  		</ul>
  	</li>
  </ul>
  <input type="hidden" name="action" value="addhc">
  <input class="w3-btn w3-round-jumbo w3-green" style="width:100%" type="submit" value="추가하기">
  </form>
</div>
<!-- 꿀통추가 끝 -->

<!-- 꿀통 표시 -->
<div class="w3-container w3-padding-16 w3-light-grey">
    <ul class="w3-navbar w3-center w3-margin">
    <li class="w3-amber w3-padding-8" style="width:20%">꿀통 아이디</li>
    <li class="w3-white w3-padding-8" style="width:50%">꿀통 제목</li>
    <li class="w3-black w3-padding-8" style="width:15%">링크</li>
    <li class="w3-blue w3-padding-8" style="width:15%">편집</li>
    </ul>

			<!-- //리스트 길이만큼 반복-->
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
		
	  <!-- //리스트 나열-->
   <form  method="post" action="/honey/Editor">
   <input type="hidden" name="type" value="edit">
   <input type="hidden" name="hc_id" value=<%=event.getHc_id()%>>
   <input type="hidden" name="input_pwd" value="<%=event.getHc_pwd() %>">
   <ul class="w3-navbar w3-center w3-margin">
      <!-- 꿀통 아이디-->
      <li class="w3-amber w3-padding-8" style="width:20%"><%=event.getHc_id() %></li>
      <!-- 꿀통 제목 -->
      <li class="w3-white w3-padding-8" style="width:50%"><%=event.getHc_title() %></li>
      <!-- 링크 -->
      <li style="width:15%"><a href="Viewer?hc_id=<%=event.getHc_id()%>" class="w3-black w3-hover-amber">이동</a></li>
      <!-- 편집 -->
	  <li style="width:15%">
	  	<input class="w3-btn w3-blue w3-hover-indigo"type="submit" value="편집">
	  </li> 
   </ul>
   </form>
<!--나열 종료-->
		
		<%} %> 
	<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<ul class="w3-pagination">
		<% if(view_a-1>0){%>
			<li><a href="?action=myhoneycomb&page_n=<%=view_a-1%>">&laquo;</a></li>
		<%} %>
		<%for(int s=view_a;s<view_a+remain_a;s++) {
			if(s==page_n){%>
			<li><a href="?action=myhoneycomb&page_n=<%=s%>" class="w3-green"><%=s%></a></li>
		<%}else{ %>
			<li><a href="?action=myhoneycomb&page_n=<%=s%>" class="w3-white w3-hover-red"><%=s%></a></li>
		<%}} %>
		<% if(all_p-view_a>10){%>
			<li><a href="?action=myhoneycomb&page_n=<%=view_a+10%>">&raquo;</a></li> 
		<%} %>
	</ul>	

</div>
<!-- 꿀통 표시끝 -->
</div>

	
	
	
<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>

<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div>
	
</body>
</html>


