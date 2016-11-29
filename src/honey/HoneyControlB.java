package honey;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HoneyControlB
 */
@WebServlet("/HoneyControlB")
public class HoneyControlB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HoneyControlB() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String src="./comb";
		
		HoneyDAO dao = new DBHoneyDAO();
		String address = null;
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();	
		
		String action = request.getParameter("action");
		
		if(action==null||action.equals("Main")||action.equals("null")){				//일반 기본창
			address="HoneyControlB?action=newvideo";
			String main="main";
			request.setAttribute("main",main);
			System.out.println(action);
			System.out.println("메인으로");	
		}
		
		else if(action.equals("logout")){						//로그아웃시 세션종류후 기본창으로
			session.invalidate();
			address="HoneyControlB?action=newvideo";
		}
		
		else if(action.equals("login")){						//로그인시 세션생성후 로그인기본창으로 
			String member_id = request.getParameter("member_id");	
			String member_pwd = request.getParameter("member_pwd");
			HoneyBean event = dao.memberCheck(member_id, member_pwd);			
			if(event.getMember_id()==null){	//아이디가 없을시 로그인 실패 창으로
				address=src+"/fail_login.jsp";
			}else{							//로그인 성공시 로그인기본창으로	
			session.setAttribute("member_id", member_id);	
			session.setAttribute("member_pwd", member_pwd);
			//세션에 id와pwd를 설정한다.
			address="HoneyControlB?action=newvideo";
			}
		}
		
		else if(action.equals("gojoin")){//					회원가입시 아이디 체크후 없는 아이디이면 회원가입		
			String member_id = request.getParameter("member_id");
			
			String member_pwd = request.getParameter("member_pwd");		//비밀번호 확인
			String member_pwd2 = request.getParameter("member_pwd2");
			
			if(member_pwd.equals(member_pwd2)){							//비밀번호 확인완료
				HoneyBean check = dao.joinCheck(member_id);
				if(check.getMember_id()==null){
					HoneyBean event = new HoneyBean();
					event.setMember_id(request.getParameter("member_id"));
					event.setMember_pwd(request.getParameter("member_pwd"));
					event.setMember_name(request.getParameter("member_name"));
					event.setMember_mail(request.getParameter("member_mail"));
					dao.addMember(event);
					address="HoneyControlB?action=newvideo";
				}else{					//중복된 아이디일시 가입실패 창으로
					address=src+"/fail_join.jsp";
				}
			}
			else{														//비밀번호 확인 실패
					address=src+"/fail_pwd2.jsp";
			}			
		}
		
		else if(action.equals("mylist")){						//내가 게시한 게시물관리
			String member_id = (String)session.getAttribute("member_id");
			ArrayList<HoneyBean> mylist = dao.getMylist(member_id);
			request.setAttribute("mylist", mylist);		
			address=src+"/H_mylist.jsp";
		}
		
		else if(action.equals("myhoneycomb")){					//내가 만든 벌꿀통
			String member_id = (String)session.getAttribute("member_id");
			ArrayList<HoneyBean> myhoney = dao.getMyhoneycomb(member_id);
			request.setAttribute("myhoney", myhoney);		
			address=src+"/H_myhoneycomb.jsp";
		}
		
		else if(action.equals("modmember")){					//나의 정보 체크부분
			String member_id=(String)session.getAttribute("member_id");			
			String member_pwd=(String)session.getAttribute("member_pwd");//세션으로 아이디 비번 받기
			String member_pwd2=request.getParameter("member_pwd2");			//비밀번호 다시받기
			
			if(member_pwd.equals(member_pwd2)){		//비밀번호 확인 완료
				HoneyBean member= dao.memberCheck(member_id, member_pwd);	//자신의 정보를 받아온다.
				request.setAttribute("member", member);						//자신의 정보를 보낸다.
				address=src+"/H_updatemember.jsp";
			}else{										//비밀번호 확인 통과 못한경우
				address=src+"/fail_pwd2.jsp";	
			}	
		}
		
		else if(action.equals("updatemember")){								//나의 정보 수정받아서 하는부분
			String member_id=(String)session.getAttribute("member_id");
			String member_pwd=(String)session.getAttribute("member_pwd");//세션으로 아이디 비번 받기
			String member_pwd1=request.getParameter("member_pwd1");
			String member_pwd2=request.getParameter("member_pwd2");
			if(member_pwd1.equals(member_pwd2)){
				if(member_pwd1.length()==0){										//비밀번호 수정 안할시
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setMember_pwd(member_pwd);								//원 비밀번호
					event.setMember_name(request.getParameter("member_name"));
					event.setMember_mail(request.getParameter("member_mail"));		
					dao.updateMember(event);
				}else{															//비밀번호 수정시
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setMember_pwd(member_pwd1);							//번경 비밀번호
					session.setAttribute("member_pwd", member_pwd1);
					event.setMember_name(request.getParameter("member_name"));
					event.setMember_mail(request.getParameter("member_mail"));
					dao.updateMember(event);
				}
				address="HoneyControlB?action=newvideo";
			}else{
				address=src+"/fail_pwd2.jsp";
			}
		
		
		
		
		}
		
		else if(action.equals("addhc")){										//자신의 계정에 hc를 추가한다.
			int hc_id=Integer.parseInt(request.getParameter("hc_id"));			//원래hc_id갖고오기
			int newId = 0;
			String member_id=(String)session.getAttribute("member_id");			//로그인한 자신의 아이디가져오기
			String hc_pwd=dao.getHcpwd(hc_id); 									//해당 아이디의 비밀번호가져오기
			String hc_pwd1=request.getParameter("hc_pwd");						//입력된 비밀번호 가져오기
			
			if(hc_pwd.equals(hc_pwd1)){						//쓴 비밀번호와비교
															//맞으면 추가하기
			Mgr_bean HC = dao.getHC(hc_id);					//해당 hc아디이mgr가져오기
								
			do {
				newId = (int) (Math.random() * 100000);		//hc아이디를 다시 설정해서 연결시켜준다
			} while (!(dao.isGoodHC_ID(newId)));			// id 생성& 중복검사

			
			HC.setHc_id(newId);// 새로운hc_id 설정
			HC.setMember_id(member_id);//자신의 아이디로 설정
			
			dao.addHC(HC);						//해당 빈을 추가하기
			
			address="HoneyControlB?action=myhoneycomb";
			
			}else{								
				//다르면 돌려보냄
				address=src+"/fail_pwd2.jsp";
			}																	
		}
		
		else if(action.equals("list_upload_anyhc")){							//아무 hc를 자신의 게시글로 업로드			
			
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기		
			int hc_id=Integer.parseInt(request.getParameter("hc_id"));			//원래hc_id갖고오기
			String hc_pwd=dao.getHcpwd(hc_id); 									//해당 아이디의 비밀번호가져오기
			String hc_pwd1=request.getParameter("hc_pwd");						//입력된 비밀번호 가져오기
			
			
			if(hc_pwd.equals(hc_pwd1)){						//쓴 비밀번호와비교 맞으면 리스트에 등록
				HoneyBean event = new HoneyBean();
				event.setMember_id(member_id);
				event.setHc_id(hc_id);
				event.setList_title(request.getParameter("list_title"));
				event.setList_contents(request.getParameter("list_contents"));
				dao.addList(event);
			
				address="HoneyControlB?action=newvideo";
			}else{
				address=src+"/fail_pwd2.jsp";
			}		
		}
		
		else if(action.equals("list_remove")){
			System.out.println("삭제부분");
			System.out.println("프롬");
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기
			System.out.println("세션");
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			System.out.println("게시판번호"+list_n);
			String member_id2=dao.getListMemberid(list_n);							//작성자 아이디
			
			if(member_id.equals(member_id2)){									//작성자와 현재 로그인한 멤버가 같으면 삭제
				System.out.println("같다");
				dao.removeList(list_n);
				address="HoneyControlB?action=newvideo";
			}else{
				address=src+"/fail_login2.jsp";
				
			}		
		}
		
		else if(action.equals("list_update_form")){
			int list_n = Integer.parseInt(request.getParameter("list_n"));			
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기
			String member_id2=dao.getListMemberid(list_n);							//작성자 아이디
			if(member_id.equals(member_id2)){									//작성자와 현재 로그인한 멤버가 같으면 수정
				HoneyBean honey= dao.getList(list_n);							//해당 리스트 불러오기
				request.setAttribute("honey",honey);
				address=src+"/H_listupdate.jsp";
			}else{
				address=src+"/fail_login2.jsp";
			}
		}
		
		else if(action.equals("list_update")){
			System.out.println("수정");
			int list_n = Integer.parseInt(request.getParameter("list_n"));			
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기
			String member_id2=dao.getListMemberid(list_n);							//작성자 아이디
			String hc_pwd2=request.getParameter("hc_pwd");						//비밀번호를 받는다.
	
			System.out.println("수정2");
			if(member_id.equals(member_id2)){									//작성자와 현재 로그인한 멤버가 같으면 수정
				System.out.println("수정3");
				HoneyBean hb= new HoneyBean();
				System.out.println("수정3");
				String list_title = request.getParameter("list_title");
				String list_contents = request.getParameter("list_contents");
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));
				System.out.println("수정4");
				if(dao.getHcpwd(hc_id)==null){									//유효하지 않은 hc_id
					
					address=src+"/fail_hcid.jsp";								
				}else if(dao.getHcpwd(hc_id).equals(hc_pwd2)){					
					System.out.println("수정5");
					hb.setList_n(list_n);
					hb.setList_contents(list_contents);
					hb.setList_title(list_title);
					hb.setHc_id(hc_id);
					
					dao.updateList(hb);
					System.out.println("수정6");
					address="HoneyControlB?action=viewlist&list_n="+list_n;				
				}else {														//맞지않은 비밀번호
					address=src+"/fail_pwd2.jsp";
				}
			}else{
				address=src+"/fail_login2.jsp";
				
			}	
			
			
		}
		
		else if(action.equals("addCommment")){									//댓글추가						//어디서왔는지
			String from = request.getParameter("from");
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기
			int list_n=Integer.parseInt(request.getParameter("list_n"));
			String comment_contents = request.getParameter("comment_contents");
			System.out.println("댓글추가");
			System.out.println("나의 아이디"+member_id);
			System.out.println("해당 게시판 번호"+list_n);
			System.out.println("댓글 내용"+comment_contents);
			if(member_id==null){//로그인안한경우
				address=src+"/fail_login_p.jsp";
			}else if(comment_contents==null){//작성을안한경우
				address=src+"/fail_contents.jsp";
			}else{
			HoneyBean comment=new HoneyBean();
			comment.setComment_contents(comment_contents);
			comment.setList_n(list_n);
			comment.setMember_id(member_id);
			System.out.println("디비접속");
			dao.addComment(comment);
			System.out.println("접속완료");
			request.setAttribute("from", from);
			address="HoneyControlB?action=viewlist&list_n="+list_n;
			}			
		}
		
		else if(action.equals("deleteComment")){									//댓글 삭제
			int list_n = Integer.parseInt(request.getParameter("list_n"));							//어디서왔는지
			int comment_n=Integer.parseInt(request.getParameter("comment_n"));
			System.out.println("댓글지우기");
			dao.deleteComment(comment_n);
			address="HoneyControlB?action=viewlist&list_n="+list_n;
		}
		
		else if(action.equals("favoritehoneycomb")){							//찍어놓은 벌쿵통목록
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기
			ArrayList<HoneyBean> fvhoney = dao.getFvhoneycomb(member_id);
			request.setAttribute("fvhoney",fvhoney);
			address=src+"/H_favoritehoneycomb.jsp";
		}
		
		else if(action.equals("addFavoritehc")){								//찍어놓은 벌쿵통에 추가하기
			String from = request.getParameter("from");							//어디서왔는지
			String member_id=(String)session.getAttribute("member_id");			//세션으로 아이디 받기
			int hc_id=Integer.parseInt(request.getParameter("hc_id"));
			
			if(member_id==null){												//비로그인인경우
				address=src+"/fail_login_p.jsp";
			}else if(dao.getHcpwd(hc_id)==null){								//hc_id가 없는경우
				address=src+"/fail_hcid.jsp";
			
			}else{
				HoneyBean fvhoney = new HoneyBean();
				fvhoney.setHc_id(hc_id);
				fvhoney.setMember_id(member_id);
				dao.addFvhoneycomb(fvhoney);
				
				String ok = "ok";
				request.setAttribute("fvhcok",ok);					//성공했다고 알림
				address=from;
			}
		}
		else if(action.equals("viewlist")){
			String from = request.getParameter("from");
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			System.out.println("게시판보기"+from);
			if(from==null){
				System.out.println("아무것도 없음1");
			}else if(from.equals("ranking")){
				System.out.println("랭킹");
				ArrayList<HoneyBean> list = dao.getHoneyRanking();
				request.setAttribute("eventlist", list);
			}
			else if(from.equals("newvideo")){
				System.out.println("최신");
				ArrayList<HoneyBean> list = dao.getHoneyVideo();
				request.setAttribute("eventlist", list);
			}
			HoneyBean list = dao.getList(list_n);
			ArrayList<HoneyBean> comment = dao.getComment(list_n);
			int hc_id=list.getHc_id();
			Mgr_bean HC = dao.getHC(hc_id);
			
			request.setAttribute("HC",HC);
			request.setAttribute("list", list);
			request.setAttribute("comment", comment);
			request.setAttribute("from", from);
			address = src+"/H_list_view.jsp";
		}
		//주식이 만든 부분+내가추가함
		else if(action.equals("ranking")) {									//주			 랭킹창으로
			ArrayList<HoneyBean> list = dao.getHoneyRanking();
			request.setAttribute("eventlist", list);
			address = src+"/H_Ranking.jsp";
		}
		
		else if(action.equals("newvideo")){
			ArrayList<HoneyBean> list = dao.getHoneyVideo();					//주			최신비디오로	
			String main=request.getParameter("main");
			request.setAttribute("main",main);
			request.setAttribute("eventlist", list);
			address = src+"/H_newVideo.jsp";
		}
		
		else if(action.equals("updateGood")){									//주 			좋아요 더하기
			String member_id=(String)session.getAttribute("member_id");		//세션으로 아이디 비번 받기	
			System.out.println(member_id);
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			int good=Integer.parseInt(request.getParameter("good"));	
			String list_member_id=dao.getListMemberid(list_n);				//게시판쓴 아이디
			if(member_id==null){										//로그인 안한경우
				address =src+"/fail_login_p.jsp";
			}
			else if(member_id.equals(list_member_id)){							//작성자 본인인경우
				address =src+"/fail_goodbad_id.jsp";	
			}
			else if(dao.checkgoodbad(member_id,list_n).equals("true")){					//이미 평가 했는지 체크
				address = src+"/fail_goodbad2.jsp";
				
			}else{
				dao.updategoodbad(member_id,list_n);						//했다고 goodbad테이블에 추가
				good=good+1;			
				dao.updateGood(list_n, good);
				address="HoneyControlB?action=viewlist&list_n="+list_n;
			}
		}else if(action.equals("updateBad")){									//주 			싫어요 더하기
			String member_id=(String)session.getAttribute("member_id");		//세션으로 아이디 비번 받기	
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			int bad=Integer.parseInt(request.getParameter("bad"));	
			String list_member_id=dao.getListMemberid(list_n);				//게시판쓴 아이디
			if(member_id==null){										//로그인 안한경우
				address =src+"/fail_login_p.jsp";
			}
			else if(member_id.equals(list_member_id)){							//작성자 본인인경우
				address =src+"/fail_goodbad_id.jsp";	
			}
			else if(dao.checkgoodbad(member_id,list_n).equals("true")){					//이미 평가 했는지 체크
				address = src+"/fail_goodbad2.jsp";
				
			}else{
				dao.updategoodbad(member_id,list_n);						//했다고 goodbad테이블에 추가
				bad=bad+1;			
				dao.updateBad(list_n, bad);
				address="HoneyControlB?action=viewlist&list_n="+list_n;
			}
		}else if(action.equals("upload")){									//주 게시판 업로드
			String member_id=(String)session.getAttribute("member_id");		//세션으로 아이디 받기		
			ArrayList<HoneyBean> list = dao.getMyhoneycomb(member_id);
			request.setAttribute("eventlist", list);
			address = src+"/H_listUpload.jsp";
		} else if(action.equals("list_upload")){							//주 게시판 업로드
			HoneyBean event = new HoneyBean();
			String member_id=(String)session.getAttribute("member_id");		//세션으로 아이디 받기		
			
			event.setMember_id(member_id);
			event.setHc_id(Integer.parseInt(request.getParameter("hc_id")));
			event.setList_title(request.getParameter("list_title"));
			event.setList_contents(request.getParameter("list_contents"));
			dao.addList(event);
			
			address="HoneyControlB?action=newvideo";
		}else if(action.equals("hccreate")){														//동 꿀집 제작
			address=src+"/manager/createHC.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
