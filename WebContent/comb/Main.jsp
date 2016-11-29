<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="honey.HoneyBean" %>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<html>
<head>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<body>

<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>



		
</body>
</html>
