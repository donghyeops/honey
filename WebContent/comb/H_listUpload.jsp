<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="honey.HoneyBean"%>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>허니::게시판작성</title>
<link rel="stylesheet" href="./css/HoneyStyle.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function checkList1() {
	var str1 = document.getElementById('title1');
	var str2 = document.getElementById('contents1');
	
	if( str1.value.replace(/^\s*|\s*$/g,'') == "" ){
		alert("제목에 내용이 없습니다.");
	    return false;
	}
	if( str2.value.replace(/^\s*|\s*$/g,'') == "" ){
		alert("본문에 내용이 없습니다.");
	    return false;
	}
	
	return true;
}
function checkList2() {
	var str1 = document.getElementById('title2');
	var str2 = document.getElementById('contents2');
	
			if( str1.value.replace(/^\s*|\s*$/g,'') == "" ){
				alert("제목에 내용이 없습니다.");
			    return false;
			}
			if( str2.value.replace(/^\s*|\s*$/g,'') == "" ){
				alert("본문에 내용이 없습니다.");
			    return false;
			}
			
			return true;
}

</script>

</head>

<body>
	<!-- 게시글 페이지수 -->
<!--총 페이지수 -->
<% int all_p=((eventlist.size()-1)/10)+1; %>
<!--남은 게시글수 -->
<% int remain_p=eventlist.size()%10;  %>
<!--  페이지에 따라 시작하는 번호 1+(10*(page_n-1)) -->


<!-- 벌집 리스트 출력 -->
<div class="w3-container w3-display-topmiddle w3-card-8 w3-round-large w3-sand" style="margin: 150px 0px 0px 0px; width: 1000px; height: 800px">
	<div class="w3-panel w3-text-black w3-orange" style="margin: 0px 0px 0px 0px;width:900px" >누군가의 꿀통 업로드</div>
		<div class="w3-btn-group" style="width: 80%">
		<a onclick="document.getElementById('Upload').style.display='block'" style="margin: 10px 0px 20px 10px" class="w3-btn w3-amber">작성하기</a>
	</div>
	<div id="Upload" class="w3-modal">
    	<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width: 600px">
      		<div class="w3-center">
				<span onclick="document.getElementById('Upload').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    			<form class="w3-container" method="post" action="/honey/HoneyControl"  onSubmit="return checkList1()">
      				<div class="w3-section">
        				<label><b>제목</b></label>
        				<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Title" id="title1" name="list_title" required>
        				<label><b>본문 내용</b></label>
        				<input class="w3-input w3-border" type="text" placeholder="Enter Contents" id="contents1" name="list_contents" required>
        				<label><b>꿀통 아이디</b></label>
        				<input class="w3-input w3-border" type="text" placeholder="Enter Contents" name="hc_id" required>
        				<label><b>꿀통 비밀번호</b></label>
        				<input class="w3-input w3-border" type="password" placeholder="Enter Contents" name="hc_pwd" required>
        				<input type="hidden" name="action" value="list_upload_anyhc">
        				<button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">게시판에 업로드</button>
      				</div>
    			</form>
     		</div>
    	</div>
    </div>
<div class="w3-panel w3-text-black w3-orange" style="margin: 0px 0px 0px 0px;width:900px">내 꿀통 업로드</div>
	<div class="w3-btn-group" style="width: 900px; margin: 0px 0px 10px 0px">
		<button class="w3-btn w3-padding w3-amber w3-small" style="width:100px">꿀통 아이디</button>
		<button class="w3-btn w3-white w3-text-black" style="width:80%">꿀통 제목</button>
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
		
		if(page_n==all_p&&remain_p!=0||eventlist.size()==0){//마지막 페이지인 경우
			rutin=remain_p;
		}else{
			rutin=10;
		}
		
		//out.println("/현재 출력행야하는 게시글"+rutin);
		//out.println("/현재 페이지"+page_n);
		//out.println("/총게시글"+eventlist.size());
		int view_p=(1+(10*(page_n-1)))-1;
		for(int i=view_p; i<(view_p+rutin); i++) {
		HoneyBean event = (HoneyBean)eventlist.get(i);
	%>
	<div class="w3-btn-group" style="width: 900px; margin: 0px 0px 0px 0px">
		<button class="w3-btn w3-padding w3-amber w3-small" style="width:100px"><%=event.getHc_id()%></button>
		<a href="Viewer?hc_id=<%=event.getHc_id()%>" target="_blank">
			<button class="w3-btn w3-white" style="width:80%"><%=event.getHc_title()%></button>
		</a>
		<a onclick="document.getElementById('Upload<%=i%>').style.display='block'" class="w3-btn-floating w3-amber">+</a>
	</div>
	
	<div id="Upload<%=i%>" class="w3-modal">
    	<div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width: 600px">
      		<div class="w3-center">
				<span onclick="document.getElementById('Upload<%=i%>').style.display='none'" class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright" title="Close Modal">×</span>
    			<form class="w3-container" method="post" action="/honey/HoneyControl"  onSubmit="return checkList2()">
      				<div class="w3-section">
        				<label><b>제목</b></label>
        				<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Title" id="title2" name="list_title" required>
        				<label><b>본문 내용</b></label>
        				<input class="w3-input w3-border" type="text" placeholder="Enter Contents" id="contents2" name="list_contents" required>
        				<input type="hidden" name="action" value="list_upload">
        				<input type="hidden" name="hc_id" value=<%=event.getHc_id() %>>
        				<button class="w3-btn-block w3-amber w3-section w3-padding" type="submit">게시판에 업로드</button>
      				</div>
    			</form>
     		</div>
    	</div>
    </div>
	<%}
	%>	
	
	
	<%int remain_a=10;;%>
	<%int view_a=(((page_n-1)/10)*10+1);%>
	
	<%if(all_p-view_a<10) {
		remain_a=all_p-view_a+1;
	}
	%>
	
	<% if(view_a-1>0){%>
		<a href="?action=upload&page_n=<%=view_a-1%>">이전</a>
	<%} %>
	<%for(int s=view_a;s<view_a+remain_a;s++) {%>
		<a href="?action=upload&page_n=<%=s%>"><%=s%></a>
	<%} %>
	<% if(all_p-view_a>10){%>
		<a href="?action=upload&page_n=<%=view_a+10%>">다음</a>
	<%} %>
	
</div>
<%if(session.getAttribute("member_id")==null){ %>
<script> alert("로그인 해주십쇼."); location.replace("/honey/HoneyControl"); </script>
<%} else {%>
<%@ include file="Menubar_login.jsp"%>
<%} %>	

<div style="margin: 1000px 0px 0px 0px; width:1000px; height: 200px"></div>

</body>
</html>
