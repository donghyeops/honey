<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" %>
<%@ page import="honey.HoneyBean" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="mylist" class="java.util.ArrayList" scope="request"/>
<%String from = request.getParameter("action"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::나의 게시글</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<!-- 게시글 페이지수 -->
<!--총 페이지수 -->
<% int all_p=((mylist.size()-1)/10)+1; %>
<!--남은 게시글수 -->
<% int remain_p=mylist.size()%10;  %>
<!--  페이지에 따라 시작하는 번호 1+(10*(page_n-1)) -->

<div class="w3-display-topmiddle w3-center w3-card-8 w3-round-xlarge w3-sand " style="margin: 150px 0px 50px 0px; width: 80%; max-width:1200px; min-width:400px; padding-bottom: 0%">
	<div class="w3-btn-group w3-center w3-margin" style="height:30px"> <!-- // 리스트 속성 설명-->
		<button class="w3-btn w3-amber" style="height:30px;width:70px">번호</button>
  		<button class="w3-btn w3-white" style="height:30px;width:340px">제목</button>
		<button class="w3-btn w3-black" style="height:30px;width:100px">꿀통링크</button>
  		<button class="w3-btn w3-white" style="height:30px;width:220px">작성일</button>
		<button class="w3-btn w3-amber" style="height:30px;width:70px">평가</button>
		<button class="w3-btn w3-red" style="height:30px;width:70px">삭제</button>
		<button class="w3-btn w3-blue" style="height:30px;width:70px">수정</button>
	</div>



	
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
		
		if(page_n==all_p&&remain_p!=0||mylist.size()==0){//마지막 페이지인 경우
			rutin=remain_p;
		}else{
			rutin=10;
		}
		String from_page=String.valueOf(page_n);
		//out.println("/현재 출력행야하는 게시글"+rutin);
		//out.println("/현재 페이지"+page_n);
		//out.println("/총게시글"+eventlist.size());
		int view_p=(1+(10*(page_n-1)))-1;
		for(int i=view_p; i<(view_p+rutin); i++) {
				HoneyBean event =(HoneyBean)mylist.get(i);
		%>
		
	<!-- //리스트 나열-->
	<div class="w3-btn-group w3-center w3-margin" style="height:30px">
		<!-- 번호-->
		<button class="w3-btn w3-amber" style="width:70px"><%=i+1%></button>
		<!-- 제목 -->
		
  		<button class="w3-btn w3-white" style="width:340px"><a href="HoneyControl?action=viewlist&from_page=<%=from_page %>&from=<%=from %>&list_n=<%=event.getList_n() %>"><%=event.getList_title() %></a></button>
		
		<!-- 꿀통링크 -->
		
  		<button class="w3-btn w3-black " style="width:100px"><a href="Viewer?hc_id=<%=event.getHc_id()%>"><%=event.getHc_id()%></a></button>
		  		
		<!-- 작성일 -->
		<button class="w3-btn w3-white " style="width:220px"><%=event.getList_time() %></button>
		<!-- 평가 -->
		<button class="w3-btn w3-amber " style="width:70px "><%=event.getList_good() %>/<%=event.getList_bad() %></button>
		<!-- 삭제 -->
		
		<button class="w3-btn w3-red " style="width:70px"><a href="HoneyControl?from=<%=from %>&action=list_remove&list_n=<%=event.getList_n()%>">삭제</a></button>
		
		<!-- 수정 -->
		
		<button class="w3-btn w3-blue " style="width:70px"><a href="HoneyControl?action=list_update_form&list_n=<%=event.getList_n()%>">수정</a></button>
	
	</div>
		<%} %>
	
	
<!--나열 종료-->
<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<ul class="w3-pagination">
		<% if(view_a-1>0){%>
			<li><a href="?action=mylist&page_n=<%=view_a-1%>">&laquo;</a></li>
		<%} %>
		<%for(int s=view_a;s<view_a+remain_a;s++) {
			if(s==page_n){%>
			<li><a href="?action=mylist&page_n=<%=s%>" class="w3-green"><%=s%></a></li>
		<%}else{ %>
			<li><a href="?action=mylist&page_n=<%=s%>" class="w3-white w3-hover-red"><%=s%></a></li>
		<%}} %>
		<% if(all_p-view_a>10){%>
			<li><a href="?action=mylist&page_n=<%=view_a+10%>">&raquo;</a></li> 
		<%} %>
	</ul>
		
</div>



<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>

<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div>

</body>
</html>
