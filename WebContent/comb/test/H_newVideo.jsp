<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ page import="honey.HoneyBean" %>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="commentlist" class="java.util.ArrayList" scope="request"/>
<html>
<head>
<title>최신동영상</title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<body>


	

<div class="w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1600px; height: 1600px; padding: 0% 0px 0% 0px">
  	<div class="w3-btn-group " style="width: 80%; margin: 0px 15% 20px 15%"> <!-- // 리스트 속성 설명-->
		<button class="w3-btn w3-amber w3-xlarge w3-round-large" style="width:8%">번호</button>
  		<button class="w3-btn w3-white w3-xlarge" style="width:36%">제목</button>
  		<button class="w3-btn w3-black w3-xlarge" style="width:17.5%">작성자</button>
  		<button class="w3-btn w3-white w3-xlarge" style="width:17.5%">작성일</button>
		<button class="w3-btn w3-amber w3-padding-large w3-round-large" style="width:7% "><b>달아요</b></button>
		<button class="w3-btn w3-brown w3-padding-large w3-round-large" style="width:7%"><b>써요</b></button>
	</div>
	<%
		for(int i=0; i<eventlist.size(); i++) {
		HoneyBean event = (HoneyBean)eventlist.get(i);
	%>
	<div class="w3-btn-group " style="width: 80%; margin: 0px 15% 20px 15%">
		<button class="w3-btn w3-amber w3-xlarge w3-round-large" style="width:8%"><%=i+1%></button>
		<a onclick="document.getElementById('bulletin<%=i%>').style.display='block'" class="w3-xlarge">
  			<button class="w3-btn w3-white" style="width:36%"><%=event.getList_title() %></button>
		</a>
  		<button class="w3-btn w3-black w3-xlarge" style="width:17.5%"><%=event.getMember_name() %></button>
  		<button class="w3-btn w3-white w3-xlarge" style="width:17.5%"><%=event.getList_time() %></button>
		<a href="HoneyControl?from=newvideo&action=updateGood&list_n=<%= event.getList_n() %>&good=<%= event.getList_good() %>" >
			<button class="w3-btn w3-amber w3-padding-large w3-round-large" style="width:7% "><b><%=event.getList_good() %></b></button>
		</a>
		<a href="HoneyControl?from=newvideo&action=updateBad&list_n=<%= event.getList_n() %>&bad=<%= event.getList_bad() %>" >
			<button class="w3-btn w3-brown w3-padding-large w3-round-large" style="width:7%"><b><%=event.getList_bad() %></b></button>
		</a>
	</div><!--나열 종료-->
	
	<div id="bulletin<%=i%>" class="w3-modal">
		<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width: 1000px">
			<div class="w3-center" src="/honey/WebContent/comb/img/HoneyPattern.jpg">
				<br> <span onclick="document.getElementById('bulletin<%=i %>').style.display='none'"
							class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×
					</span>
			</div>
			  <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        		    <p><%=event.getList_contents() %></p>
            </div>		
            <div class="w3-container">
			<div class="w3-section">
				<a href="Viewer?hc_id=<%=event.getHc_id() %>" class="w3-xxlarge">
					<button class="w3-btn-block w3-round-large w3-amber  w3-padding w3-center" style="width: 80%; margin: 0px 10% 20px 10%">
						링크
					</button>
				</a>
				<a href="HoneyControl?from=newvideo&action=updateGood&list_n=<%= event.getList_n() %>&good=<%= event.getList_good() %>" >
					<button class="w3-btn w3-amber w3-padding-large w3-round-large" style="width:100% "><b>달아요 : +<%=event.getList_good() %></b></button>
				</a>
				
				<a href="HoneyControl?from=newvideo&action=updateBad&list_n=<%= event.getList_n() %>&bad=<%= event.getList_bad() %>" >
					<button class="w3-btn w3-brown w3-padding-large w3-round-large" style="width:100%"><b>써요 : -<%=event.getList_bad() %></b></button>	
				</a>
				<%
				if(session.getAttribute("member_id")==null){
				
				}
				else if(session.getAttribute("member_id").equals(event.getMember_id())){ %>
				<a href="HoneyControl?from=newvideo&action=list_remove&list_n=<%= event.getList_n()%>" >
					<button class="w3-btn w3-blue w3-padding-large w3-round-large" style="width:50%"><b>삭제</b></button>	
				</a>
				<a href="HoneyControl?from=newvideo&action=list_update_form&list_n=<%= event.getList_n() %>" >
					<button class="w3-btn w3-red w3-padding-large w3-round-large" style="width:50%"><b>수정</b></button>	
				</a>
				<%} %>
			</div></div>

			<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
<!-- 댓글 작성과 댓글 표시부분 -->
			<form method="post" action="/honey/HoneyControl">
			<input type="hidden" name="list_n" value="<%=event.getList_n()%>">
			<input type="hidden" name="action" value="addCommment">
			<input type="hidden" name="from" value="newvideo">
				<table border="1">
					<tr>
					<td><input type="text" name="comment_contents"></td>
					<td><input type="submit" value="작성"></td>
					</tr>
				</table>
			</form>
				<table border="1">
					<tr>
						<td>작성자</td>
						<td>내용</td>
						<td>시간</td>
					</tr>
				<%
				for(int j=0; j<commentlist.size(); j++) {
					HoneyBean comment = (HoneyBean)commentlist.get(j);
					if(comment.getList_n()==event.getList_n()){				
						for(int k=0;k<comment.getComment_n_list().size();k++){
							ArrayList<String> comment_contents = comment.getComment_contents_list();
							ArrayList<String> comment_time = comment.getComment_time_list();
							ArrayList<String> comment_n = comment.getComment_n_list();
							ArrayList<String> comment_member_id = comment.getComment_member_id_list();
				%>			
					<tr>
						<td><%=comment_member_id.get(k)%></td>
						<td><%=comment_contents.get(k)%></td>
						<td><%=comment_time.get(k)%></td>
						<%if(session.getAttribute("member_id")==null){}
						else if(session.getAttribute("member_id").equals(event.getMember_id())){ %>
						<td>
						<form method="post" action="/honey/HoneyControl">
							<input type="hidden" name="comment_n" value="<%=comment_n.get(k)%>">
							<input type="hidden" name="action" value="deleteComment">
							<input type="hidden" name="from" value="newvideo">
							<input type="submit" value="삭제">
						</form>
						</td>
						<td>수정</td>
						<%} %>
					</tr>			
				<%}}} %>
				</table>
<!-- 댓글 -->
			</div>
		</div>
	</div>
	<% }
	%>
</div>



<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>






		
<div style="margin: 1950px 0px 0px 0px; width:1500px; height: 200px"></div> <!-- //하단 여백 -->

<%=request.getParameter("action") %>
<%=request.getParameter("main") %>
<% if(request.getParameter("main")==null){
	%><%=request.getParameter("main") %><script>newvideo();</script><%
}else{%>
	<%=request.getParameter("main") %>
<% }%>
</body>
</html>