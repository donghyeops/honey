package honey;

import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HoneyControl
 */
@WebServlet("/HoneyControl")
public class HoneyControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HoneyControl() {
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
		
		if (action!=null && !action.equals("hccreate")) {
			session.removeAttribute("mode");
			session.removeAttribute("HC");
			session.removeAttribute("result");
		}
		
		if(action==null||action.equals("Main")||action.equals("null")){				//占싹뱄옙 占썩본창
			address="HoneyControl?action=newvideo";
			String main="main";
			request.setAttribute("main",main);
			System.out.println("엑션은"+action);
			System.out.println("메인");	
		}
		
		else if(action.equals("logout")){						//占싸그아울옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占썩본창占쏙옙占쏙옙
			session.invalidate();
			address="HoneyControl?action=newvideo";
		}
		
		else if(action.equals("login")){						//占싸깍옙占싸쏙옙 占쏙옙占실삼옙占쏙옙占쏙옙 占싸깍옙占싸기본창占쏙옙占쏙옙 
			String member_id = request.getParameter("member_id");	
			String member_pwd = request.getParameter("member_pwd");
			HoneyBean event = dao.memberCheck(member_id, member_pwd);			
			if(event.getMember_id()==null){	//占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙 占싸깍옙占쏙옙 占쏙옙占쏙옙 창占쏙옙占쏙옙
				address=src+"/fail_login.jsp";
			}else{							//占싸깍옙占쏙옙 占쏙옙占쏙옙占쏙옙 占싸깍옙占싸기본창占쏙옙占쏙옙	
			session.setAttribute("member_id", member_id);	
			session.setAttribute("member_pwd", member_pwd);
			//占쏙옙占실울옙 id占쏙옙pwd占쏙옙 占쏙옙占쏙옙占싼댐옙.
			address="HoneyControl?action=newvideo";
			}
		}
		
		else if(action.equals("gojoin")){//					회占쏙옙占쏙옙占쌉쏙옙 占쏙옙占싱듸옙 체크占쏙옙 占쏙옙占쏙옙 占쏙옙占싱듸옙占싱몌옙 회占쏙옙占쏙옙占쏙옙		
			String member_id = request.getParameter("member_id");
			
			String member_pwd = request.getParameter("member_pwd");		//占쏙옙橘占싫� 확占쏙옙
			String member_pwd2 = request.getParameter("member_pwd2");
			
			if(member_pwd.equals(member_pwd2)){							//占쏙옙橘占싫� 확占싸완뤄옙
				HoneyBean check = dao.joinCheck(member_id);
				if(check.getMember_id()==null){
					HoneyBean event = new HoneyBean();
					event.setMember_id(request.getParameter("member_id"));
					event.setMember_pwd(request.getParameter("member_pwd"));
					event.setMember_name(request.getParameter("member_name"));
					dao.addMember(event);
					address="HoneyControl?action=newvideo";
				}else{					//占쌩븝옙占쏙옙 占쏙옙占싱듸옙占싹쏙옙 占쏙옙占쌉쏙옙占쏙옙 창占쏙옙占쏙옙
					address=src+"/fail_join.jsp";
				}
			}
			else{														//占쏙옙橘占싫� 확占쏙옙 占쏙옙占쏙옙
					address=src+"/fail_pwd2.jsp";
			}			
		}
		
		else if(action.equals("mylist")){						//占쏙옙占쏙옙 占쌉쏙옙占쏙옙 占쌉시뱄옙占쏙옙占쏙옙
			String member_id = (String)session.getAttribute("member_id");
			ArrayList<HoneyBean> mylist = dao.getMylist(member_id);
			request.setAttribute("mylist", mylist);		
			address=src+"/H_mylist.jsp";
		}
		
		else if(action.equals("myhoneycomb")){					//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			String member_id = (String)session.getAttribute("member_id");
			ArrayList<HoneyBean> myhoney = dao.getMyhoneycomb(member_id);
			request.setAttribute("myhoney", myhoney);		
			address=src+"/H_myhoneycomb.jsp";
		}
		
		else if(action.equals("modmember")){					//占쏙옙占쏙옙 占쏙옙占쏙옙 체크占싸븝옙
			String member_id=(String)session.getAttribute("member_id");			
			String member_pwd=(String)session.getAttribute("member_pwd");//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占� 占쌨깍옙
			String member_pwd2=request.getParameter("member_pwd2");			//占쏙옙橘占싫� 占쌕시받깍옙
			
			if(member_pwd.equals(member_pwd2)){		//占쏙옙橘占싫� 확占쏙옙 占싹뤄옙
				HoneyBean member= dao.memberCheck(member_id, member_pwd);	//占쌘쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨아온댐옙.
				request.setAttribute("member", member);						//占쌘쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙.
				address=src+"/H_updatemember.jsp";
			}else{										//占쏙옙橘占싫� 확占쏙옙 占쏙옙占� 占쏙옙占싼곤옙占�
				address=src+"/fail_pwd2.jsp";	
			}	
		}
		
		else if(action.equals("updatemember")){								//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쌨아쇽옙 占싹는부븝옙
			String member_id=(String)session.getAttribute("member_id");
			String member_pwd=(String)session.getAttribute("member_pwd");//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占� 占쌨깍옙
			String member_pwd1=request.getParameter("member_pwd1");
			String member_pwd2=request.getParameter("member_pwd2");
			if(member_pwd1.equals(member_pwd2)){
				if(member_pwd1.length()==0){										//占쏙옙橘占싫� 占쏙옙占쏙옙 占쏙옙占쌀쏙옙
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setMember_pwd(member_pwd);								//占쏙옙 占쏙옙橘占싫�
					event.setMember_name(request.getParameter("member_name"));		
					dao.updateMember(event);
				}else{															//占쏙옙橘占싫� 占쏙옙占쏙옙占쏙옙
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setMember_pwd(member_pwd1);							//占쏙옙占쏙옙 占쏙옙橘占싫�
					session.setAttribute("member_pwd", member_pwd1);
					event.setMember_name(request.getParameter("member_name"));
					dao.updateMember(event);
				}
				address="HoneyControl?action=newvideo";
			}else{
				address=src+"/fail_pwd2.jsp";
			}
		
		
		
		
		}
		
		else if(action.equals("addhc")){										//占쌘쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 hc占쏙옙 占쌩곤옙占싼댐옙.
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){//占쏙옙占쌘뤄옙 占쌉뤄옙占싼곤옙占�
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));			//占쏙옙占쏙옙hc_id占쏙옙占쏙옙占쏙옙占�
				int newId = 0;
				String member_id=(String)session.getAttribute("member_id");			//占싸깍옙占쏙옙占쏙옙 占쌘쏙옙占쏙옙 占쏙옙占싱듸옙占쏙옙占쏙옙占쏙옙
				String hc_pwd=dao.getHcpwd(hc_id); 									//占쌔댐옙 占쏙옙占싱듸옙占쏙옙 占쏙옙橘占싫ｏ옙占쏙옙占쏙옙占쏙옙占�
				String hc_pwd1=request.getParameter("hc_pwd");						//占쌉력듸옙 占쏙옙橘占싫� 占쏙옙占쏙옙占쏙옙占쏙옙
				System.out.println(hc_pwd1);
				System.out.println(SHA1.sha1(hc_pwd1));
				System.out.println(hc_pwd);
				if(hc_pwd==null){											//占쌔댐옙 占쏙옙占쏙옙占쏙옙 占쏙옙占승곤옙占�
					address=src+"/fail_hcid.jsp";
				}
				else if(hc_pwd.equals(SHA1.sha1(hc_pwd1))){						//占쏙옙 占쏙옙橘占싫ｏ옙故占�
															//占쏙옙占쏙옙占쏙옙 占쌩곤옙占싹깍옙
					Mgr_bean HC = dao.getHC(hc_id);					//占쌔댐옙 hc占싣듸옙占쏙옙mgr占쏙옙占쏙옙占쏙옙占쏙옙
								
					do {
						newId = (int) (Math.random() * 100000);		//hc占쏙옙占싱듸옙 占쌕쏙옙 占쏙옙占쏙옙占쌔쇽옙 占쏙옙占쏙옙占쏙옙占쏙옙娩占�
					} while (!(dao.isGoodHC_ID(newId)));			// id 占쏙옙占쏙옙& 占쌩븝옙占싯삼옙

			
					HC.setHc_id(newId);// 占쏙옙占싸울옙hc_id 占쏙옙占쏙옙
					HC.setMember_id(member_id);//占쌘쏙옙占쏙옙 占쏙옙占싱듸옙占� 占쏙옙占쏙옙
					HC.setHc_pwd(request.getParameter("hc_pwd"));
					dao.addHC(HC);						//占쌔댐옙 占쏙옙占쏙옙 占쌩곤옙占싹깍옙
			
					address="HoneyControl?action=myhoneycomb";
			
				}else{								
					//占쌕몌옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
					address=src+"/fail_pwd2.jsp";
				}	
			}else{//占쏙옙占쌘몌옙 占쌉뤄옙占싼곤옙占�
				address=src+"/fail_hcid.jsp";
			}
																			
		}
		
		else if(action.equals("list_upload_anyhc")){							//占싣뱄옙 hc占쏙옙 占쌘쏙옙占쏙옙 占쌉시글뤄옙 占쏙옙占싸듸옙			
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//占쏙옙占쌘뤄옙 占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙占�
				String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙		
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));			//占쏙옙占쏙옙hc_id占쏙옙占쏙옙占쏙옙占�
				String hc_pwd=dao.getHcpwd(hc_id); 									//占쌔댐옙 占쏙옙占싱듸옙占쏙옙 占쏙옙橘占싫ｏ옙占쏙옙占쏙옙占쏙옙占�
				String hc_pwd1=request.getParameter("hc_pwd");						//占쌉력듸옙 占쏙옙橘占싫� 占쏙옙占쏙옙占쏙옙占쏙옙
			
			
				if(hc_pwd.equals(SHA1.sha1(hc_pwd1))){						//占쏙옙 占쏙옙橘占싫ｏ옙故占� 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙트占쏙옙 占쏙옙占�
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setHc_id(hc_id);
					event.setList_title(request.getParameter("list_title"));
					event.setList_contents(request.getParameter("list_contents"));
					dao.addList(event);
			
					address="HoneyControl?action=newvideo";
				}else{
					address=src+"/fail_pwd2.jsp";
				}
			}else{															//占쏙옙占쌘몌옙 占쌉뤄옙占싼곤옙占�
				address=src+"/fail_hcid.jsp";
			}
		}
		
		else if(action.equals("list_remove")){
			System.out.println("게시글삭제");
			String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			System.out.println("게시글번호"+list_n);
			String member_id2=dao.getListMemberid(list_n);							//占쌜쇽옙占쏙옙 占쏙옙占싱듸옙
			
			if(member_id.equals(member_id2)){									//占쌜쇽옙占쌘울옙 占쏙옙占쏙옙 占싸깍옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
				dao.removeList(list_n);
				address="HoneyControl?action=newvideo";
			}else{
				address=src+"/fail_login2.jsp";
				
			}		
		}
		
		else if(action.equals("list_update_form")){
			String from = request.getParameter("from");
			String from_page = request.getParameter("from_page");
			String searchs = request.getParameter("searchs");
			
			int list_n = Integer.parseInt(request.getParameter("list_n"));			
			String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
			String member_id2=dao.getListMemberid(list_n);							//占쌜쇽옙占쏙옙 占쏙옙占싱듸옙
			if(member_id.equals(member_id2)){									//占쌜쇽옙占쌘울옙 占쏙옙占쏙옙 占싸깍옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
				HoneyBean honey= dao.getList(list_n);							//占쌔댐옙 占쏙옙占쏙옙트 占쌀뤄옙占쏙옙占쏙옙
				request.setAttribute("from", from);
				request.setAttribute("from_page",from_page);
				request.setAttribute("searchs",searchs);
				request.setAttribute("honey",honey);
				address=src+"/H_listupdate.jsp";
			}else{
				address=src+"/fail_login2.jsp";
			}
		}
		
		else if(action.equals("list_update")){
			//if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//占쏙옙占쌘뤄옙 占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙
				String from = request.getParameter("from");
				String from_page = request.getParameter("from_page");
				String searchs = request.getParameter("searchs");
				int list_n = Integer.parseInt(request.getParameter("list_n"));			
				String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
				String member_id2=dao.getListMemberid(list_n);							//占쌜쇽옙占쏙옙 占쏙옙占싱듸옙
				//String hc_pwd2=request.getParameter("hc_pwd");						//占쏙옙橘占싫ｏ옙占� 占쌨는댐옙.
	
				if(member_id.equals(member_id2)){									//占쌜쇽옙占쌘울옙 占쏙옙占쏙옙 占싸깍옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙

					HoneyBean hb= new HoneyBean();
					String list_title = request.getParameter("list_title");
					String list_contents = request.getParameter("list_contents");
					//int hc_id=Integer.parseInt(request.getParameter("hc_id"));
					//if(dao.getHcpwd(hc_id)==null){									//占쏙옙효占쏙옙占쏙옙 占쏙옙占쏙옙 hc_id
					
					//	address=src+"/fail_hcid.jsp";								
					//}else 
						//if(dao.getHcpwd(hc_id).equals(SHA1.sha1(hc_pwd2))){		
						hb.setList_n(list_n);
						hb.setList_contents(list_contents);
						hb.setList_title(list_title);
						//hb.setHc_id(hc_id);
					
						dao.updateList(hb);
						address="HoneyControl?action=viewlist&from="+from+"&from_page="+from_page+"&searchs="+searchs+"&list_n="+list_n;				
					//}else {														//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙橘占싫�
					//	address=src+"/fail_pwd2.jsp";
					//}
				}else{
					address=src+"/fail_login2.jsp";
					
				}	
			//}else{
				//address=src+"/fail_hcid.jsp";
			//}
			
		}
		
		else if(action.equals("addCommment")){									//占쏙옙占쏙옙煞占�						//占쏙옙兆�왔댐옙占쏙옙
			String from = request.getParameter("from");
			String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
			int list_n=Integer.parseInt(request.getParameter("list_n"));
			String comment_contents = request.getParameter("comment_contents");
			System.out.println("댓글추가");
			if(member_id==null){//占싸깍옙占싸억옙占싼곤옙占�
				address=src+"/fail_login_p.jsp";
			}else if(comment_contents==null){//占쌜쇽옙占쏙옙占쏙옙占싼곤옙占�
				address=src+"/fail_contents.jsp";
			}else{
			HoneyBean comment=new HoneyBean();
			comment.setComment_contents(comment_contents);
			comment.setList_n(list_n);
			comment.setMember_id(member_id);
			dao.addComment(comment);
			request.setAttribute("from", from);
			address="HoneyControl?action=viewlist&list_n="+list_n;
			}			
		}
		
		else if(action.equals("deleteComment")){									//占쏙옙占� 占쏙옙占쏙옙
			int list_n = Integer.parseInt(request.getParameter("list_n"));							//占쏙옙兆�왔댐옙占쏙옙
			int comment_n=Integer.parseInt(request.getParameter("comment_n"));
			System.out.println("댓글지우기");
			dao.deleteComment(comment_n);
			address="HoneyControl?action=viewlist&list_n="+list_n;
		}
		
		else if(action.equals("favoritehoneycomb")){							//占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
			String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
			ArrayList<HoneyBean> fvhoney = dao.getFvhoneycomb(member_id);
			request.setAttribute("fvhoney",fvhoney);
			address=src+"/H_favoritehoneycomb.jsp";
		}
		
		else if(action.equals("addFavoritehc")){								//占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쎈에 占쌩곤옙占싹깍옙
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//占쏙옙占쌘뤄옙 占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙占�
				String from = request.getParameter("from");							//占쏙옙兆�왔댐옙占쏙옙
				String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));
			
				if(member_id==null){												//占쏙옙慣占쏙옙占쏙옙寬占쏙옙
					address=src+"/fail_login_p.jsp";
				}else if(dao.getHcpwd(hc_id)==null){								//hc_id占쏙옙 占쏙옙占승곤옙占�
					address=src+"/fail_hcid.jsp";
			
				}else{					
					HoneyBean fvhoney = new HoneyBean();
					fvhoney.setHc_id(hc_id);
					fvhoney.setMember_id(member_id);
					
					if(dao.checkFvhoneycomb(fvhoney)){			//占쌔댐옙占쏙옙占쏙옙占� 占쏙옙찾占쌩댐옙占쏙옙 체크 占쏙옙占쏙옙占쏙옙 true占쏙옙占쏙옙占쏙옙false
						address=src+"/fail_samefv.jsp";
					}else{
						dao.addFvhoneycomb(fvhoney);
				
						String ok = "ok";
						request.setAttribute("fvhcok",ok);					//占쏙옙占쏙옙占쌩다곤옙 占싯몌옙
						address=from;
					}
				}
			}else{
				address=src+"/fail_hcid.jsp";
			}
		}
		else if(action.equals("deleteFavoritehc")){		
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//占쏙옙占쌘뤄옙 占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙占�
				String member_id=(String)session.getAttribute("member_id");			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));
			
				if(member_id==null){												//占쏙옙慣占쏙옙占쏙옙寬占쏙옙
					address=src+"/fail_login_p.jsp";
				}else if(dao.getHcpwd(hc_id)==null){								//hc_id占쏙옙 占쏙옙占승곤옙占�
					address=src+"/fail_hcid.jsp";
			
				}else{					
					HoneyBean fvhoney = new HoneyBean();
					fvhoney.setHc_id(hc_id);
					fvhoney.setMember_id(member_id);
					dao.deleteFvhoneycomb(fvhoney);
					address="HoneyControl?action=favoritehoneycomb";
				}
			}else{
				address=src+"/fail_hcid.jsp";
			}
			
			
		}
		
		
		
		else if(action.equals("viewlist")){
			String from = request.getParameter("from");
			String from_page = request.getParameter("from_page");
			String searchs = request.getParameter("searchs");
			System.out.println("온곳"+from);
			System.out.println("온페이지"+from_page);
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			if(from==null){
				
			}else if(from.equals("ranking")){
				
				ArrayList<HoneyBean> list = dao.getHoneyRanking();
				request.setAttribute("eventlist", list);
			}
			else if(from.equals("newvideo")){
				
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
			request.setAttribute("from_page", from_page);
			request.setAttribute("searchs", searchs);
			address = src+"/H_list_view.jsp";
		}
		//占쌍쏙옙占쏙옙 占쏙옙占쏙옙 占싸븝옙+占쏙옙占쏙옙占쌩곤옙占쏙옙
		else if(action.equals("ranking")) {									//占쏙옙			 占쏙옙킹창占쏙옙占쏙옙
			ArrayList<HoneyBean> list = dao.getHoneyRanking();
			request.setAttribute("eventlist", list);
			address = src+"/H_Board.jsp";
		}
		
		else if(action.equals("newvideo")){
			ArrayList<HoneyBean> list = dao.getHoneyVideo();					//占쏙옙			占쌍신븝옙占쏙옙占쏙옙	
			request.setAttribute("eventlist", list);
			address = src+"/H_Board.jsp";
		}
		
		else if(action.equals("updateGood")){									//占쏙옙 			占쏙옙占싣울옙 占쏙옙占싹깍옙
			String member_id=(String)session.getAttribute("member_id");		//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占� 占쌨깍옙	
			String from = request.getParameter("from");
			String action2 = request.getParameter("action2");
			String searchs = request.getParameter("searchs");
			String from_page = request.getParameter("from_page");
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			int good=Integer.parseInt(request.getParameter("good"));	
			String list_member_id=dao.getListMemberid(list_n);				//占쌉쏙옙占실억옙 占쏙옙占싱듸옙
			if(member_id==null){										//占싸깍옙占쏙옙 占쏙옙占싼곤옙占�
				address =src+"/fail_login_p.jsp";
			}
			else if(member_id.equals(list_member_id)){							//占쌜쇽옙占쏙옙 占쏙옙占쏙옙占싸곤옙占�
				address =src+"/fail_goodbad_id.jsp";	
			}
			else if(dao.checkgoodbad(member_id,list_n).equals("true")){					//占싱뱄옙 占쏙옙 占쌩댐옙占쏙옙 체크
				address = src+"/fail_goodbad2.jsp";
				
			}else{
				dao.updategoodbad(member_id,list_n);						//占쌩다곤옙 goodbad占쏙옙占싱븝옙 占쌩곤옙
				good=good+1;			
				dao.updateGood(list_n, good);
				System.out.println("컨트롤에서"+action2);
				System.out.println("서치물"+searchs);
				if(from.equals("search")){
					action2=from;
				}
				
				if(action2==null){
					System.out.println("action2가널이다-게시판에서들어갔다");
					address="HoneyControl?action="+from+"&page_n="+from_page;
				}else if(action2.equals("search")){
					address="Search?search="+searchs+"&page_n="+from_page;
				}
				else{
					System.out.println("action2가"+action2+"이다 게시물에서좋아용");
					address="HoneyControl?action=viewlist&list_n="+list_n;		
				}
			}
		}else if(action.equals("updateBad")){									//占쏙옙 			占싫억옙占� 占쏙옙占싹깍옙
			String member_id=(String)session.getAttribute("member_id");		//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쏙옙占� 占쌨깍옙	
			String from = request.getParameter("from");
			String action2 = request.getParameter("action2");
			String searchs = request.getParameter("searchs");
			String from_page = request.getParameter("from_page");
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			int bad=Integer.parseInt(request.getParameter("bad"));	
			String list_member_id=dao.getListMemberid(list_n);				//占쌉쏙옙占실억옙 占쏙옙占싱듸옙
			if(member_id==null){										//占싸깍옙占쏙옙 占쏙옙占싼곤옙占�
				address =src+"/fail_login_p.jsp";
			}
			else if(member_id.equals(list_member_id)){							//占쌜쇽옙占쏙옙 占쏙옙占쏙옙占싸곤옙占�
				address =src+"/fail_goodbad_id.jsp";	
			}
			else if(dao.checkgoodbad(member_id,list_n).equals("true")){					//占싱뱄옙 占쏙옙 占쌩댐옙占쏙옙 체크
				address = src+"/fail_goodbad2.jsp";
				
			}else{
				dao.updategoodbad(member_id,list_n);						//占쌩다곤옙 goodbad占쏙옙占싱븝옙 占쌩곤옙
				bad=bad+1;			
				dao.updateBad(list_n, bad);
				
				if(action2==null){
					System.out.println("action2가널이다-게시판에서들어갔다");
					address="HoneyControl?action="+from+"&page_n="+from_page;
				}else if(action2.equals("search")){
					address="Search?search="+searchs+"&page_n="+from_page;
				}
				else{
					System.out.println("action2가"+action2+"이다 게시물에서좋아용");
					address="HoneyControl?action=viewlist&list_n="+list_n;		
				}
			}
		}else if(action.equals("upload")){									//占쏙옙 占쌉쏙옙占쏙옙 占쏙옙占싸듸옙
			String member_id=(String)session.getAttribute("member_id");		//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙		
			ArrayList<HoneyBean> list = dao.getMyhoneycomb(member_id);
			request.setAttribute("eventlist", list);
			address = src+"/H_listUpload.jsp";
		}
		else if(action.equals("list_upload")){							//占쏙옙 占쌉쏙옙占쏙옙 占쏙옙占싸듸옙
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){//占쏙옙占쌘뤄옙 占쌉뤄옙占싼곤옙占�
				HoneyBean event = new HoneyBean();
				String member_id=(String)session.getAttribute("member_id");		//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占싱듸옙 占쌨깍옙		
			
				event.setMember_id(member_id);
				event.setHc_id(Integer.parseInt(request.getParameter("hc_id")));
				event.setList_title(request.getParameter("list_title"));
				event.setList_contents(request.getParameter("list_contents"));
				dao.addList(event);
			
				address="HoneyControl?action=newvideo";
			}else{
				address=src+"/fail_hcid.jsp";
			}
			
		}else if(action.equals("hccreate")){														//占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙
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
