<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ page import="honey.HoneyBean" %>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<html>
<head>
<title>HONEYCOMB</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
li {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

</head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<body>
	<!-- 게시글 페이지수 -->
<!--총 페이지수 -->
<% int all_p=((eventlist.size()-1)/10)+1; %>
<!--남은 게시글수 -->
<% int remain_p=eventlist.size()%10;  %>
<!--  페이지에 따라 시작하는 번호 1+(10*(page_n-1)) -->
	

<div class="w3-display-topmiddle w3-center w3-card-8 w3-round-xlarge w3-sand " style="margin: 150px 0px 50px 0px; width: 80%; max-width:1200px; min-width:400px; padding-bottom: 0%">
	<br>
  <ul class="w3-navbar w3-center w3-round-xlarge w3-margin-bottom w3-hide-medium w3-hide-small" style="width:95%; margin:0px 2.5% 0px 2.5% ">
      	<li class="w3-amber w3-padding-8" style="width:8%">번호</li>
      	<li class="w3-white w3-padding-8" style="width:30%">제목</li>
      	<li class="w3-black w3-padding-8" style="width:12%">작성자</li>
	  	<li class="w3-white w3-padding-8" style="width:28%">작성일</li> 
        <li class="w3-amber w3-padding-8" style="width:11%">달아요</li>
        <li class="w3-brown w3-padding-8" style="width:11%">써요</li>
  </ul>
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
	<ul class="w3-navbar w3-center w3-round-xlarge w3-margin-bottom w3-hide-medium w3-hide-small" style="width:95%; margin:0px 2.5% 0px 2.5% ">
      	<!--번호-->
      	<li class="w3-amber w3-padding-8" style="width:8%"><%=i+1%></li>
      	<!--제목 -->
      	<li class="w3-white" style="width:30%">
      		<a href="HoneyControl?action=viewlist&from=newvideo&list_n=<%=event.getList_n() %>">
      			<%=event.getList_title() %>
      		</a>
      	</li>
      	<!--작성자-->
      	<li class="w3-black w3-padding-8" style="width:12%"><%=event.getMember_name() %></li>
      	<!--작성일-->
	  	<li class="w3-white w3-padding-8" style="width:28%"><%=event.getList_time() %></li> 
        <li style="width:11%">
        	<a href="HoneyControl?from=ranking&action=updateGood&list_n=<%= event.getList_n() %>&good=<%= event.getList_good() %>" class="w3-amber w3-hover-yellow"><%=event.getList_good() %></a>
        </li>
        <li style="width:11%">
        	<a href="HoneyControl?from=ranking&action=updateBad&list_n=<%= event.getList_n() %>&bad=<%= event.getList_bad() %>" class="w3-brown w3-hover-dark-gray"><%=event.getList_bad() %></a>
        </li>
   	</ul>  
    
  	<ul class="w3-navbar w3-center w3-round-xlarge w3-margin-bottom w3-margin w3-hide-large">
  		<li style="width:100%">
    		<ul class="w3-navbar w3-center">
    			<li class="w3-yellow w3-padding-16 w3-hide-small" style="width:12%"><%=i+1%></li>
            	<li class="w3-yellow w3-medium w3-hide-medium w3-hide-large" style="width:12%"><%=i+1%></li>
    			<li class="w3-white" style="width:38%">
            		<a href="HoneyControl?action=viewlist&from=newvideo&list_n=<%=event.getList_n() %>" class="w3-padding-16">
                		<%=event.getList_title() %>
                	</a>
            	</li>
    			<li class="w3-black w3-padding-16 w3-hide-small" style="width:20%"><%=event.getMember_name() %></li>
    			<li class="w3-white w3-padding-16 w3-hide-small" style="width:30%"><%=event.getList_time() %></li>
 	 		</ul>
  		</li>
  		<li style="width:100%">
    		<ul class="w3-navbar  w3-khaki w3-center">
    			<li class="w3-amber w3-small" style="width:50%">
            		<a href="HoneyControl?from=ranking&action=updateGood&list_n=<%= event.getList_n() %>&good=<%= event.getList_good() %>" class="w3-hover-yellow">
                		<%=event.getList_good() %>
                	</a>
            	</li>
    			<li class="w3-brown w3-small" style="width:50%">
            		<a href="HoneyControl?from=ranking&action=updateBad&list_n=<%= event.getList_n() %>&bad=<%= event.getList_bad() %>"  class="w3-hover-dark-gray">
                		<%=event.getList_bad() %>
                	</a>
            	</li>
 			</ul>
  		</li>
 	</ul>
	<% }
	%>

	<!--나열 종료-->
	<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<ul class="w3-pagination">
		<% if(view_a-1>0){%>
			<li><a href="?page_n=<%=view_a-1%>">&laquo;</a></li>
		<%} %>
		<%for(int s=view_a;s<view_a+remain_a;s++) {
			if(s==page_n){%>
				<li><a href="?page_n=<%=s%>" class="w3-green"><%=s%></a></li>
		<%}else{ %>
				<li><a href="?page_n=<%=s%>" class="w3-white w3-hover-red"><%=s%></a></li>
		<%}} %>
		<% if(all_p-view_a>10){%>
				<li><a href="?page_n=<%=view_a+10%>">&raquo;</a></li> 
		<%} %>
	</ul>
</div>


<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>
	
<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div> <!-- //하단 여백 -->

</body>
</html>