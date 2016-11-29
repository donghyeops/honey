<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ page import="honey.HoneyBean" %>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="commentlist" class="java.util.ArrayList" scope="request"/>
<html>
<head>
<title>허니::인기있는게시글</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>


<body>

<div>

<!-- // 랭킹 리스트-->
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
  	<div class="w3-btn-group w3-center w3-margin" style="height:30px"> <!-- // 리스트 속성 설명-->
		<button class="w3-btn w3-amber" style="height:30px;width:70px">번호</button>
  		<button class="w3-btn w3-white" style="height:30px;width:390px">제목</button>
  		<button class="w3-btn w3-black" style="height:30px;width:110px">작성자</button>
  		<button class="w3-btn w3-white" style="height:30px;width:220px">작성일</button>
		<button class="w3-btn w3-amber" style="height:30px;width:70px">달아요</button>
		<button class="w3-btn w3-brown" style="height:30px;width:70px">써요</button>
	</div>
	
		<!-- //리스트 길이만큼 반복-->
	<%
		for(int i=0; i<eventlist.size(); i++) {
		HoneyBean event = (HoneyBean)eventlist.get(i);
	%>
	<!-- //리스트 나열-->
	<div class="w3-btn-group w3-center w3-margin" style="height:30px">
		<!-- 번호-->
		<button class="w3-btn w3-amber" style="width:70px"><%=i+1%></button>
		<!-- 제목 -->
		<a href="HoneyControlB?action=viewlist&from=ranking&list_n=<%=event.getList_n() %>">
  			<button class="w3-btn w3-white" style="width:390px"><%=event.getList_title() %></button>
		</a>
		<!-- 작성자 -->
  		<button class="w3-btn w3-black " style="width:110px"><%=event.getMember_name() %></button>
  		<!-- 작성일 -->
		<button class="w3-btn w3-white " style="width:220px"><%=event.getList_time() %></button>
		<!-- 좋아요 -->
		<a href="HoneyControlB?from=ranking&action=updateGood&list_n=<%= event.getList_n() %>&good=<%= event.getList_good() %>" >
			<button class="w3-btn w3-amber " style="width:70px "><%=event.getList_good() %></button>
		</a>
		<!-- 싫어요 -->
		<a href="HoneyControlB?from=ranking&action=updateBad&list_n=<%= event.getList_n() %>&bad=<%= event.getList_bad() %>" >
		<button class="w3-btn w3-brown " style="width:70px"><%=event.getList_bad() %></button>
		</a>
	</div>
	
<!--나열 종료-->
	
		<% }
		%>
		
</div>

		<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>
</div>


		
<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div>
<script>ranking();</script>
</body>
</html>
