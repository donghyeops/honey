<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.HoneyBean" %>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>벌꿀</title>
</head>
<link rel="stylesheet" href="./HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<body>

<%HoneyBean title = (HoneyBean)eventlist.get(0); %>
<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1600px; height: 1600px; padding: 2% 0px 0% 0px">
<div class="w3-panel w3-round-large w3-amber w3-xxxlarge w3-center" style="width: 80%; margin: 0px 10% 40px 10%"><%=title.getHc_title() %>
	<%
		for(int i=0; i<eventlist.size(); i++) {
		HoneyBean event = (HoneyBean)eventlist.get(i);
	%>
	<!-- 비디오 나열 -->
	
	</div>
 	<%=event.getVideo_url()%>
	<% }
	%>
	<!-- 반복 종료 -->
</div>


<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>

</body>
</html>