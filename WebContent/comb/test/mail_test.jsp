<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="honey.Mgr_bean"
	import="java.util.ArrayList" import="honey.SMTPMail"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (SMTPMail.getInstance().sendHi() == true) {
			out.println("성공");
		} else {
			out.println("실패");
		}
	%>
</body>
</html>