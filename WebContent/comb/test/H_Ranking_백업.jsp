<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ page import="honey.HoneyBean" %>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="commentlist" class="java.util.ArrayList" scope="request"/>
<html>
<head>
<title>HONEYCOMB</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>


<body>
	<!-- 게시글 페이지수 -->
<!--총 페이지수 -->
<% int all_p=((eventlist.size()-1)/10)+1; %>
<!--남은 게시글수 -->
<% int remain_p=eventlist.size()%10;  %>
<!--  페이지에 따라 시작하는 번호 1+(10*(page_n-1)) -->
<div>

<!-- // 랭킹 리스트-->
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 70%; height: 500px">
     <div class="w3-btn-group w3-center w3-margin" style="height:30px;width:100%"> <!-- // 리스트 속성 설명-->
      <button class="w3-btn w3-amber" style="height:30px;width:8%">번호</button>
        <button class="w3-btn w3-white" style="height:30px;width:35%">제목</button>
        <button class="w3-btn w3-black" style="height:30px;width:15%">작성자</button>
        <button class="w3-btn w3-white" style="height:30px;width:23%">작성일</button>
      <button class="w3-btn w3-amber" style="height:30px;width:8%">달아요</button>
      <button class="w3-btn w3-brown" style="height:30px;width:8%">써요</button>
   </div>

	
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
		
		if(page_n==all_p&&remain_p!=0||eventlist.size()==0){//마지막 페이지인 경우
			rutin=remain_p;
		}else{
			rutin=10;
		}
		
		//out.println("/현재 출력행야하는 게시글"+rutin);
		//out.println("/현재 페이지"+page_n);
		//out.println("/총게시글"+eventlist.size());
		int view_p=(1+(10*(page_n-1)))-1;
		for(int i=view_p; i<(view_p+rutin); i++) {
		HoneyBean event = (HoneyBean)eventlist.get(i);
	%>
	 <!-- //리스트 나열-->
   <div class="w3-btn-group w3-center w3-margin" style="height:30px">
      <!-- 번호-->
      <button class="w3-btn w3-amber" style="width:8%"><%=i+1%></button>
      <!-- 제목 -->
     
      <button class="w3-btn w3-white" style="width:36%"><a href="HoneyControl?action=viewlist&from=ranking&list_n=<%=event.getList_n() %>"><%=event.getList_title() %> </a></button>
     
      <!-- 작성자 -->
        <button class="w3-btn w3-black " style="width:15%"><%=event.getMember_name() %></button>
        <!-- 작성일 -->
      <button class="w3-btn w3-white " style="width:20%"><%=event.getList_time() %></button>
      <!-- 좋아요 -->
      <a href="HoneyControl?from=ranking&action=updateGood&list_n=<%= event.getList_n() %>&good=<%= event.getList_good() %>" >
         <button class="w3-btn w3-amber " style="width:8% "><%=event.getList_good() %></button>
      </a>
      <!-- 싫어요 -->
      <a href="HoneyControl?from=ranking&action=updateBad&list_n=<%= event.getList_n() %>&bad=<%= event.getList_bad() %>" >
      <button class="w3-btn w3-brown " style="width:8%"><%=event.getList_bad() %></button>
      </a>
   </div>
   
<!--나열 종료-->

	
		<% }
		%>
		<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<% if(view_a-1>0){%>
		<a href="?action=ranking&page_n=<%=view_a-1%>">이전</a>
	<%} %>
	<%for(int s=view_a;s<view_a+remain_a;s++) {%>
		<a href="?action=ranking&page_n=<%=s%>"><%=s%></a>
	<%} %>
	<% if(all_p-view_a>10){%>
		<a href="?action=ranking&page_n=<%=view_a+10%>">다음</a>
	<%} %>
		
</div>

		<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>
</div>


		
<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div>
</body>
</html>
