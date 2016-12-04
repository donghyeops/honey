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

<div class="w3-display-topmiddle w3-center w3-card-8 w3-round-xlarge w3-sand " style="margin: 150px 0px 0px 0px; width: 80%; height: 800px; max-width:1200px">
	<!-- 이전 다음 -->
    <ul class="w3-navbar w3-center w3-round-xlarge">
  		<li style="width:100%">
  			<ul class="w3-navbar w3-center">
  				<li style="width:100%">
                	<a href="#" class="w3-green w3-hover-red w3-padding-8" onclick="back()"><b>목록으로</b></a>
                <!-- 게시판번호 -->
				<!-- 게시판제목 -->
				<!-- 작성일 -->
                </li>
  			</ul>
  		</li>
  		<li class="w3-hide-small w3-margin-top" style="width:100%">
  			<ul class="w3-navbar w3-center">
  				<li class="w3-gray w3-padding-16" style="width:13%"><b>제목</b></li>
            	<li class="w3-white w3-padding-16" style="width:37%"><%=list.getList_title() %></li>
            	<li class="w3-gray w3-padding-16" style="width:13%"><b>작성일</b></li>
				<li class="w3-white w3-padding-16" style="width:37%"><%=list.getList_time() %></li>
          	</ul>
  		</li>
        <li style="width:100%">
  			<ul class="w3-navbar w3-center">
  				<li style="height:15px"><hr></li>
            </ul>
  		</li>
  	</ul>
    <!-- 게시판내용 -->
  	<ul class="w3-navbar w3-center">
  		<li style="width:100%">
  			<ul class="w3-navbar w3-amber w3-center w3-padding-8">
  				<li style="width:100%"><b><%=list.getList_contents() %></b></li>
  			</ul>
  		</li>
     	<!-- 동영상 -->
  		<li style="width:100%">
  			<ul id="video" class="w3-navbar w3-light-gray w3-center" style="overflow:scroll; overflow-x:hidden">
  				<li style="width:100%; height:300px">
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
               </li>
  			</ul>
  		</li>
  	</ul>
    <!-- 동영상 끝 -->
	<!-- 자기거 삭제 수정 부분 -->
    <ul class="w3-navbar w3-center w3-margin-bottom" style="width:100%">
    		<%
				if(session.getAttribute("member_id")==null){
				}
				else if(session.getAttribute("member_id").equals(list.getMember_id())){ %>
            <!-- 삭제 -->	
    		<li style="width:50%">
            	<a href="HoneyControl?action=list_remove&list_n=<%= list.getList_n() %>" class="w3-padding-8 w3-pink w3-hover-red" >
                	<b>삭제하기</b>
                </a>
            </li>
            <!-- 수정 -->
    		<li style="width:50%">
            	<a href="HoneyControl?action=list_update_form&list_n=<%= list.getList_n() %>" class="w3-padding-8 w3-indigo w3-hover-blue">
                	<b>수정하기</b>
                </a>
            </li>
            <%}else{} %>
            <!-- 해당꿀집 링크 -->
            <li style="width:50%">
            	<a href="#" class="w3-padding-8 w3-amber w3-hover-yellow" onclick="copy_trackback('http://hcvideo.mooo.com:8081/honey/Viewer?hc_id=<%=list.getHc_id()%>'); return false;">
                	<b>꿀통 링크 복사하기</b>
                </a>
            </li>
            <form method="post" action="/honey/HoneyControl">
					<input type="hidden" name="hc_id" value="<%=HC.getHc_id()%>">
					<input type="hidden" name="from" value="HoneyControl?action=viewlist&list_n=<%=list.getList_n()%>">
					<input type="hidden" name="action" value="addFavoritehc">
    		<li style="width:50%"><b>
            	<input class="w3-btn w3-padding-8 w3-brown w3-hover-dark-gray"type="submit" value="꿀통 몰래 훔치기"></b>
            </li>
            </form>
  	</ul>
    <!-- 퍼가기 버튼 끝 -->
	<!-- 달아 써요부분 -->
    <ul class="w3-navbar w3-center w3-round-jumbo w3-margin-bottom" style="width:70%; margin:0px 15% 0px 15%">
    	<li style="width:50%">
            <a href="HoneyControl?action=updateGood&list_n=<%= list.getList_n() %>&good=<%= list.getList_good() %>" class="w3-padding-8 w3-amber w3-hover-yellow">
                <b>달아요: <%=list.getList_good() %></b>
            </a>
        </li>
    	<li style="width:50%">
            <a href="HoneyControl?action=updateBad&list_n=<%= list.getList_n() %>&bad=<%= list.getList_bad() %>" class="w3-padding-8 w3-brown w3-hover-dark-gray">
                <b>써요: <%=list.getList_bad() %></b>
            </a>
        </li>
  		</ul>
        <!-- 달아 싫어요 끝 -->

		<!-- 댓글 -->
		<ul class="w3-navbar w3-center w3-round-large w3-margin-bottom">
            	<form method="post" action="/honey/HoneyControl">
				<input type="hidden" name="list_n" value="<%=list.getList_n()%>">
				<input type="hidden" name="action" value="addCommment">
				<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
    			<li class="w3-padding-8 w3-green" style="width:15%">
                	<b>댓글</b>
                </li>
    			<li style="width:70%">
                <input type="text" class="w3-input w3-white w3-padding-8" name="comment_contents" placeholder="로그인후 사용해주세요"> 
                </li>
                <li style="width:15%">
                	<b><input class="w3-btn w3-padding-8 w3-green w3-hover-teal"type="submit" value="작성하기"></b>
                </li>
                </form>
  		</ul>
        <div class="w3-light-gray" style="height:220px; overflow:scroll; overflow-x:hidden">
            <!-- 댓글 표시 -->
			<div class="w3-row" style="width:100%">
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
                    int view_p=(1+(10*(page_n-1)))-1;
					for(int i=view_p; i<(view_p+rutin); i++) {
						HoneyBean comment_out = (HoneyBean)comment.get(i);	
				%>
                <ul class="w3-navbar w3-center w3-round-large w3-margin-bottom">
                	<li class="w3-padding-12 w3-blue" style="width:15%">
                		<b><%=comment_out.getMember_id() %></b>
                	</li>
                    <li class="w3-padding-12 w3-white" style="width:55%">
                		<b><%=comment_out.getComment_contents() %></b>
                	</li>
                    <li class="w3-padding-12 w3-white" style="width:25%">
                		<b><%=comment_out.getComment_time() %></b>
                	</li>
                    <%if(session.getAttribute("member_id")==null){}
						else if(session.getAttribute("member_id").equals(comment_out.getMember_id())){ %>
                    <form method="post" action="/honey/HoneyControl">
						<input type="hidden" name="comment_n" value="<%=comment_out.getComment_n()%>">
						<input type="hidden" name="action" value="deleteComment">
						<input type="hidden" name="list_n" value="<%=list.getList_n() %>"> 
                        <li style="width:5%">
                			<b><input class="w3-btn w3-padding-8 w3-red w3-hover-pink"type="submit" value="x"></b>
                		</li>
                    </form>
					<%} else{%>
						<li class="w3-padding-8 w3-black" style="width:5%">
                			<b><hr></b>
                		</li>
					<%}%>
					</ul>
					<%} %> 
             </div>
             <!-- 댓글표시끝 -->
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
			<%for(int s=view_a;s<view_a+remain_a;s++) {%>
			<li><a href="?page_n=<%=s%>"><%=s%></a></li>
			<%} %>
			<% if(all_p-view_a>10){%>
			<li><a href="?page_n=<%=view_a+10%>">&raquo;</a></li>
			<%} %>
        </div>
</div>
		<%if(session.getAttribute("member_id")==null){ %>
		<%@ include file="Menubar_logout.jsp"%>
		<%} else {%>
		<%@ include file="Menubar_login.jsp"%>
		<%} %>

</body>
</html>