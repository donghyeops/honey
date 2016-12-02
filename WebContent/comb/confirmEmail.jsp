<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.SMTPMail"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<title>이메일 확인</title>

<% request.setCharacterEncoding("utf-8"); %>
<%
	String type = request.getParameter("type");
	if (type.equals("send")) {
		String email = request.getParameter("email");
		out.print(email);
		SMTPMail.getInstance().sendHi();
		if (SMTPMail.getInstance().sendJoinNumber(email)) {
			%>
			<center>
			<h4>해당 이메일로 코드를 전송하였습니다.</h4><br>
			<%
		} else {
			%>
			<center>
			<h4>전송에 실패하였습니다.</h4><br>
			<%
		}
		%>
		<input type="button" value="닫기" onclick="end()"/>
		</center>
		<%
		}
	else { 
		String number = request.getParameter("number");
		boolean isChecked = SMTPMail.getInstance().checkJoinNumber(Integer.parseInt(number));
		
		if (isChecked) {%>
			<center>
			<h4>확인되었습니다.</h4><br>
			<input type="button" value="닫기" onclick="checkOut('true')"/>
			</center>
		<%
		} else {%>
			<center>
			<h4>인증 번호가 다릅니다.</h4><br>
			<input type="button" value="닫기" onclick="checkOut('false')"/>
			</center>
		<%}
	}%>

<script language="javascript">
	function end() {
		self.close();
	}
	function checkOut(isChecked) {
		opener.document.join.isChecked.value = isChecked;
		self.close();
	}
</script>