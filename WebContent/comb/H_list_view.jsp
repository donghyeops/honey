<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.HoneyBean" import="java.util.ArrayList"%>

<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />		<%--다음이전을위해 --%>
<jsp:useBean id="list" class="honey.HoneyBean" scope="request" />				<%--해당게시판내용 --%>
<jsp:useBean id="comment" class="java.util.ArrayList" scope="request"/>				<%--댓글 --%>
<jsp:useBean id="HC" class="honey.Mgr_bean" scope="request"/>					<%--영상 --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>허니::<%=list.getList_title() %></title>
<link rel="stylesheet" href="/honey/comb/css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script> 
<!--
function copy_trackback(trb) {
    var IE=(document.all)?true:false;
    if (IE) {
        if(confirm("이 글의 트랙백 주소를 클립보드에 복사하시겠습니까?"))
            window.clipboardData.setData("Text", trb);
    } else {
        temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", trb);
    }
}
function back(){
	history.go(-1);
}

//-->
</script> 
</head>
<body>
	<!-- 게시글 페이지수 -->
<!--총 페이지수 -->
<% int all_p=((comment.size()-1)/10)+1; %>
<!--남은 게시글수 -->
<% int remain_p=comment.size()%10;  %>
<!--  페이지에 따라 시작하는 번호 1+(10*(page_n-1)) -->

<div class="w3-display-topmiddle w3-contaner w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 2000px">
<!-- 이전 다음 -->
<div class="w3-container w3-padding w3-btn-group w3-yellow w3-margin-top" style="height:40px">
	 <button class="w3-btn w3-blue w3-display-topmiddle" style="margin:18px 0px 0px 0px" onclick="back()">목록</button>
</div>
<!-- 게시판번호 -->
<!-- 게시판제목 -->
<!-- 작성일 -->
	<div class="w3-panel w3-red w3-btn-group">
		<button class="w3-btn">제목</button>
		<button class="w3-btn w3-white w3-text-black" style="width:600px"><%=list.getList_title() %></button>
		<button class="w3-btn">작성일</button>
		<button class="w3-btn w3-white w3-text-black"><%=list.getList_time() %></button>
	</div>



<!-- 게시판내용 -->
	<div class="w3-panel w3-padding w3-blue">
		<%=list.getList_contents() %>
	</div>	
<!-- 동영상 -->

	<div style="overflow:scroll;width:800px; height:500px;margin:0px 0px 0px 100px;padding:0px 0px 0px 150px">
		<%
		if (HC.getURLs().size() == 0) {
			out.println("존재하지 않는 페이지 입니다.");
		}
		ArrayList<String> URLs = HC.getURLs(); 
		for(String url : URLs) {
		%>
			<%=url%>
			<br>
		<%} %>
	</div>
<!-- 동영상 끝 -->
<!-- 자기거 삭제 수정 부분 -->
<div class="w3-container w3-padding">
	<div class="w3-btn-group w3-padding w3-center">
	<%
				if(session.getAttribute("member_id")==null){
				}
				else if(session.getAttribute("member_id").equals(list.getMember_id())){ %>
			<!-- 삭제 -->	
				<a href="HoneyControl?action=list_remove&list_n=<%= list.getList_n() %>" >
				
					<button class="w3-btn w3-red w3-padding-large w3-round-large" style="width:50%"><b>삭제</b></button>	
				</a>
			<!-- 수정 -->
				<a href="HoneyControl?action=list_update_form&list_n=<%= list.getList_n() %>" >
					<button class="w3-btn w3-blue w3-padding-large w3-round-large" style="width:50%"><b>수정</b></button>	
				</a>
				<%}else{} %>
	</div>
</div>
<!-- 자기거 삭제 수정 끝 -->
<!-- 퍼가기버튼 -->
	<div class="w3-contaner w3-yellow">
		<!-- 해당꿀집 링크 -->
			<div class="w3-btn-group w3-padding w3-center"  >
					
					<button class="w3-btn w3-amber w3-padding w3-center w3-left" onclick="copy_trackback('http://hcvideo.mooo.com:8081/honey/Viewer?hc_id=<%=list.getHc_id()%>'); return false;"  style="margin: 0px 10% 20px 10%">
						꿀통아이디<%=list.getHc_id()%>링크복사하기
					</button> 
										
					<form method="post" action="/honey/HoneyControl">
					<input type="hidden" name="hc_id" value="<%=HC.getHc_id()%>">
					<input type="hidden" name="from" value="HoneyControl?action=viewlist&list_n=<%=list.getList_n()%>">
					<input type="hidden" name="action" value="addFavoritehc">
					<button class="w3-btn w3-amber w3-padding w3-center w3-right" type="submit" style="margin: 0px 10% 20px 10%">
						꿀통 몰래 훔치기
					</button>
				</form>
			</div>

	</div>
<!-- 퍼가기 버튼 끝 -->

<!-- 달아 싫어요부분 -->
	<div class="w3-contaner w3-red">
	<!-- 달아요부분 -->
				<div class="w3-btn-group w3-padding w3-center"  >
				<a href="HoneyControl?action=updateGood&list_n=<%= list.getList_n() %>&good=<%= list.getList_good() %>" >
					<button class="w3-btn w3-padding w3-left w3-amber w3-round" style="margin-left:310px;width:120px"><b>달아요: +<%=list.getList_good() %></b></button>
				</a>
			<!-- 싫어요 부분 -->
				<a href="HoneyControl?action=updateBad&list_n=<%= list.getList_n() %>&bad=<%= list.getList_bad() %>" >
					<button class="w3-btn w3-padding w3-left w3-brown w3-round" style="width:120px"><b>써요: +<%=list.getList_bad() %></b></button>	
				</a>
				</div>

	</div>
<!-- 달아 싫어요 끝 -->

<!-- 댓글 -->
	<div class="w3-container w3-padding w3-green">
		<!-- 댓글 작성 -->
		<form method="post" action="/honey/HoneyControl">
		<input type="hidden" name="list_n" value="<%=list.getList_n()%>">
		<input type="hidden" name="action" value="addCommment">
		<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
			<div class="w3-row w3-red" style="margin:0px 0px 10px 10px;height:40px;width:950px">
				<div class="w3-padding w3-left w3-center w3-blue w3-margin-right" style="width:70px">댓글	</div>
				<input class="w3-input w3-left w3-margin-right" name="comment_contents" style="width:600px;height:40px" type="text">
				<button class="w3-btn w3-left" type="submit" style="height:40px;width:200px">작성하기</button>
			</div>
		</form>
		<!-- 댓글 표시 -->
		<div class="w3-row w3-yellow" style="margin:0px 0px 0px 10px;width:950px">
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
		
		if(page_n==all_p&&remain_p!=0||comment.size()==0){//마지막 페이지인 경우
			rutin=remain_p;
		}else{
			rutin=10;
		}
		
		//out.println("/현재 출력행야하는 게시글"+rutin);
		//out.println("/현재 페이지"+page_n);
		//out.println("/총게시글"+eventlist.size());
		int view_p=(1+(10*(page_n-1)))-1;
		for(int i=view_p; i<(view_p+rutin); i++) {
					HoneyBean comment_out = (HoneyBean)comment.get(i);	
			%>		
		
			<div class="w3-padding w3-left w3-center w3-blue w3-margin-right w3-border" style="height:50px;width:70px"><%=comment_out.getMember_id() %></div>
			<div class="w3-padding w3-left w3-center w3-blue w3-margin-right w3-border" style="height:50px;width:600px"><%=comment_out.getComment_contents() %></div>
			<div class="w3-center w3-blue w3-left w3-border" style="padding:10px 0px 0px 0px;height:50px;width:200px"><%=comment_out.getComment_time() %></div>
			<%if(session.getAttribute("member_id")==null){}
						else if(session.getAttribute("member_id").equals(comment_out.getMember_id())){ %>
			<form method="post" action="/honey/HoneyControl">
				<input type="hidden" name="comment_n" value="<%=comment_out.getComment_n()%>">
				<input type="hidden" name="action" value="deleteComment">
				<input type="hidden" name="list_n" value="<%=list.getList_n() %>">
				<button class="w3-padding w3-btn w3-left w3-red" type="submit" style="height:50px;width:5px">x</button>
			</form>
			<%} else{}%>
		<%} %>
		
	
		</div>
				<!-- 댓글표시끝 -->
				
					<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<% if(view_a-1>0){%>
		<a href="?action=viewlist&list_n=<%=list.getList_n()%>&page_n=<%=view_a-1%>">이전</a>
	<%} %>
	<%for(int s=view_a;s<view_a+remain_a;s++) {%>
		<a href="?action=viewlist&list_n=<%=list.getList_n()%>&page_n=<%=s%>"><%=s%></a>
	<%} %>
	<% if(all_p-view_a>10){%>
		<a href="?action=viewlist&list_n=<%=list.getList_n()%>&page_n=<%=view_a+10%>">다음</a>
	<%} %>
<!-- 댓글 -->

	</div>
</div>
		<%if(session.getAttribute("member_id")==null){ %>
<%@ include file="Menubar_logout.jsp"%>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>



</body>
</html>