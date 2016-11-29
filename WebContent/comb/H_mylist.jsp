<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" %>
<%@ page import="honey.HoneyBean" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="mylist" class="java.util.ArrayList" scope="request"/>
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
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
	<div class="w3-btn-group w3-center w3-margin" style="height:30px"> <!-- // 리스트 속성 설명-->
		<button class="w3-btn w3-amber" style="height:30px;width:70px">번호</button>
  		<button class="w3-btn w3-white" style="height:30px;width:340px">제목</button>
		<button class="w3-btn w3-black" style="height:30px;width:100px">꿀통링크</button>
  		<!--  <button class="w3-btn w3-black" style="height:30px;width:110px">작성자</button>-->
  		<button class="w3-btn w3-white" style="height:30px;width:220px">작성일</button>
		<button class="w3-btn w3-amber" style="height:30px;width:70px">평가</button>
		<button class="w3-btn w3-red" style="height:30px;width:70px">삭제</button>
		<button class="w3-btn w3-blue" style="height:30px;width:70px">수정</button>
	</div>



	<div class="w3-btn-group w3-center w3-margin" style="height:30px">
	<%
			for(int i=0;i<mylist.size();i++){
				HoneyBean event =(HoneyBean)mylist.get(i);
		%>
		
	<!-- //리스트 나열-->
	
		<!-- 번호-->
		<button class="w3-btn w3-amber" style="width:70px"><%=i+1%></button>
		<!-- 제목 -->
		<a href="HoneyControlB?action=viewlist&from=ranking&list_n=<%=event.getList_n() %>">
  			<button class="w3-btn w3-white" style="width:340px"><%=event.getList_title() %></button>
		</a>
		<!-- 꿀통링크 -->
		<a href="Viewer?hc_id=<%=event.getHc_id()%>">
  			<button class="w3-btn w3-black " style="width:100px"><%=event.getHc_id()%></button>
		</a>  		
		<!-- 작성일 -->
		<button class="w3-btn w3-white " style="width:220px"><%=event.getList_time() %></button>
		<!-- 평가 -->
		<button class="w3-btn w3-amber " style="width:70px "><%=event.getList_good() %>/<%=event.getList_bad() %></button>
		<!-- 삭제 -->
		<a href="HoneyControlB?from=mylist&action=list_remove&list_n=<%=event.getList_n()%>">
		<button class="w3-btn w3-red " style="width:70px">삭제</button>
		</a>
		<!-- 수정 -->
		<a href="HoneyControlB?action=list_update_form&list_n=<%=event.getList_n()%>">
		<button class="w3-btn w3-blue " style="width:70px">수정</button>
		</a>
		<%} %>
	</div>
	
<!--나열 종료-->
</div>
<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>
	
</body>
</html>
