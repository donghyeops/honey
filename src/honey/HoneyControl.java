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
		
		if(action==null||action.equals("Main")||action.equals("null")){				//�Ϲ� �⺻â
			address="HoneyControl?action=newvideo";
			String main="main";
			request.setAttribute("main",main);
			System.out.println(action);
			System.out.println("��������");	
		}
		
		else if(action.equals("logout")){						//�α׾ƿ��� ���������� �⺻â����
			session.invalidate();
			address="HoneyControl?action=newvideo";
		}
		
		else if(action.equals("login")){						//�α��ν� ���ǻ����� �α��α⺻â���� 
			String member_id = request.getParameter("member_id");	
			String member_pwd = request.getParameter("member_pwd");
			HoneyBean event = dao.memberCheck(member_id, member_pwd);			
			if(event.getMember_id()==null){	//���̵� ������ �α��� ���� â����
				address=src+"/fail_login.jsp";
			}else{							//�α��� ������ �α��α⺻â����	
			session.setAttribute("member_id", member_id);	
			session.setAttribute("member_pwd", member_pwd);
			//���ǿ� id��pwd�� �����Ѵ�.
			address="HoneyControl?action=newvideo";
			}
		}
		
		else if(action.equals("gojoin")){//					ȸ�����Խ� ���̵� üũ�� ���� ���̵��̸� ȸ������		
			String member_id = request.getParameter("member_id");
			
			String member_pwd = request.getParameter("member_pwd");		//��й�ȣ Ȯ��
			String member_pwd2 = request.getParameter("member_pwd2");
			
			if(member_pwd.equals(member_pwd2)){							//��й�ȣ Ȯ�οϷ�
				HoneyBean check = dao.joinCheck(member_id);
				if(check.getMember_id()==null){
					HoneyBean event = new HoneyBean();
					event.setMember_id(request.getParameter("member_id"));
					event.setMember_pwd(request.getParameter("member_pwd"));
					event.setMember_name(request.getParameter("member_name"));
					dao.addMember(event);
					address="HoneyControl?action=newvideo";
				}else{					//�ߺ��� ���̵��Ͻ� ���Խ��� â����
					address=src+"/fail_join.jsp";
				}
			}
			else{														//��й�ȣ Ȯ�� ����
					address=src+"/fail_pwd2.jsp";
			}			
		}
		
		else if(action.equals("mylist")){						//���� �Խ��� �Խù�����
			String member_id = (String)session.getAttribute("member_id");
			ArrayList<HoneyBean> mylist = dao.getMylist(member_id);
			request.setAttribute("mylist", mylist);		
			address=src+"/H_mylist.jsp";
		}
		
		else if(action.equals("myhoneycomb")){					//���� ���� ������
			String member_id = (String)session.getAttribute("member_id");
			ArrayList<HoneyBean> myhoney = dao.getMyhoneycomb(member_id);
			request.setAttribute("myhoney", myhoney);		
			address=src+"/H_myhoneycomb.jsp";
		}
		
		else if(action.equals("modmember")){					//���� ���� üũ�κ�
			String member_id=(String)session.getAttribute("member_id");			
			String member_pwd=(String)session.getAttribute("member_pwd");//�������� ���̵� ��� �ޱ�
			String member_pwd2=request.getParameter("member_pwd2");			//��й�ȣ �ٽùޱ�
			
			if(member_pwd.equals(member_pwd2)){		//��й�ȣ Ȯ�� �Ϸ�
				HoneyBean member= dao.memberCheck(member_id, member_pwd);	//�ڽ��� ������ �޾ƿ´�.
				request.setAttribute("member", member);						//�ڽ��� ������ ������.
				address=src+"/H_updatemember.jsp";
			}else{										//��й�ȣ Ȯ�� ��� ���Ѱ��
				address=src+"/fail_pwd2.jsp";	
			}	
		}
		
		else if(action.equals("updatemember")){								//���� ���� �����޾Ƽ� �ϴºκ�
			String member_id=(String)session.getAttribute("member_id");
			String member_pwd=(String)session.getAttribute("member_pwd");//�������� ���̵� ��� �ޱ�
			String member_pwd1=request.getParameter("member_pwd1");
			String member_pwd2=request.getParameter("member_pwd2");
			if(member_pwd1.equals(member_pwd2)){
				if(member_pwd1.length()==0){										//��й�ȣ ���� ���ҽ�
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setMember_pwd(member_pwd);								//�� ��й�ȣ
					event.setMember_name(request.getParameter("member_name"));		
					dao.updateMember(event);
				}else{															//��й�ȣ ������
					HoneyBean event = new HoneyBean();
					event.setMember_id(member_id);
					event.setMember_pwd(member_pwd1);							//���� ��й�ȣ
					session.setAttribute("member_pwd", member_pwd1);
					event.setMember_name(request.getParameter("member_name"));
					dao.updateMember(event);
				}
				address="HoneyControl?action=newvideo";
			}else{
				address=src+"/fail_pwd2.jsp";
			}
		
		
		
		
		}
		
		else if(action.equals("addhc")){										//�ڽ��� ������ hc�� �߰��Ѵ�.
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){//���ڷ� �Է��Ѱ��
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));			//����hc_id�������
				int newId = 0;
				String member_id=(String)session.getAttribute("member_id");			//�α����� �ڽ��� ���̵�������
				String hc_pwd=dao.getHcpwd(hc_id); 									//�ش� ���̵��� ��й�ȣ��������
				String hc_pwd1=request.getParameter("hc_pwd");						//�Էµ� ��й�ȣ ��������
				System.out.println(hc_pwd1);
				System.out.println(SHA1.sha1(hc_pwd1));
				System.out.println(hc_pwd);
				if(hc_pwd==null){											//�ش� ������ ���°��
					address=src+"/fail_hcid.jsp";
				}
				else if(hc_pwd.equals(SHA1.sha1(hc_pwd1))){						//�� ��й�ȣ�ͺ�
															//������ �߰��ϱ�
					Mgr_bean HC = dao.getHC(hc_id);					//�ش� hc�Ƶ���mgr��������
								
					do {
						newId = (int) (Math.random() * 100000);		//hc���̵� �ٽ� �����ؼ� ��������ش�
					} while (!(dao.isGoodHC_ID(newId)));			// id ����& �ߺ��˻�

			
					HC.setHc_id(newId);// ���ο�hc_id ����
					HC.setMember_id(member_id);//�ڽ��� ���̵�� ����
					HC.setHc_pwd(request.getParameter("hc_pwd"));
					dao.addHC(HC);						//�ش� ���� �߰��ϱ�
			
					address="HoneyControl?action=myhoneycomb";
			
				}else{								
					//�ٸ��� ��������
					address=src+"/fail_pwd2.jsp";
				}	
			}else{//���ڸ� �Է��Ѱ��
				address=src+"/fail_hcid.jsp";
			}
																			
		}
		
		else if(action.equals("list_upload_anyhc")){							//�ƹ� hc�� �ڽ��� �Խñ۷� ���ε�			
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//���ڷ� ���� ���̵� �������
				String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�		
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));			//����hc_id�������
				String hc_pwd=dao.getHcpwd(hc_id); 									//�ش� ���̵��� ��й�ȣ��������
				String hc_pwd1=request.getParameter("hc_pwd");						//�Էµ� ��й�ȣ ��������
			
			
				if(hc_pwd.equals(SHA1.sha1(hc_pwd1))){						//�� ��й�ȣ�ͺ� ������ ����Ʈ�� ���
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
			}else{															//���ڸ� �Է��Ѱ��
				address=src+"/fail_hcid.jsp";
			}
		}
		
		else if(action.equals("list_remove")){
			System.out.println("�����κ�");
			System.out.println("����");
			String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
			System.out.println("����");
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			System.out.println("�Խ��ǹ�ȣ"+list_n);
			String member_id2=dao.getListMemberid(list_n);							//�ۼ��� ���̵�
			
			if(member_id.equals(member_id2)){									//�ۼ��ڿ� ���� �α����� ����� ������ ����
				System.out.println("����");
				dao.removeList(list_n);
				address="HoneyControl?action=newvideo";
			}else{
				address=src+"/fail_login2.jsp";
				
			}		
		}
		
		else if(action.equals("list_update_form")){
			int list_n = Integer.parseInt(request.getParameter("list_n"));			
			String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
			String member_id2=dao.getListMemberid(list_n);							//�ۼ��� ���̵�
			if(member_id.equals(member_id2)){									//�ۼ��ڿ� ���� �α����� ����� ������ ����
				HoneyBean honey= dao.getList(list_n);							//�ش� ����Ʈ �ҷ�����
				request.setAttribute("honey",honey);
				address=src+"/H_listupdate.jsp";
			}else{
				address=src+"/fail_login2.jsp";
			}
		}
		
		else if(action.equals("list_update")){
			//if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//���ڷ� ���� ���̵� ������
				int list_n = Integer.parseInt(request.getParameter("list_n"));			
				String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
				String member_id2=dao.getListMemberid(list_n);							//�ۼ��� ���̵�
				//String hc_pwd2=request.getParameter("hc_pwd");						//��й�ȣ�� �޴´�.
	
				if(member_id.equals(member_id2)){									//�ۼ��ڿ� ���� �α����� ����� ������ ����

					HoneyBean hb= new HoneyBean();
					String list_title = request.getParameter("list_title");
					String list_contents = request.getParameter("list_contents");
					//int hc_id=Integer.parseInt(request.getParameter("hc_id"));
					//if(dao.getHcpwd(hc_id)==null){									//��ȿ���� ���� hc_id
					
					//	address=src+"/fail_hcid.jsp";								
					//}else 
						//if(dao.getHcpwd(hc_id).equals(SHA1.sha1(hc_pwd2))){		
						hb.setList_n(list_n);
						hb.setList_contents(list_contents);
						hb.setList_title(list_title);
						//hb.setHc_id(hc_id);
					
						dao.updateList(hb);
						address="HoneyControl?action=viewlist&list_n="+list_n;				
					//}else {														//�������� ��й�ȣ
					//	address=src+"/fail_pwd2.jsp";
					//}
				}else{
					address=src+"/fail_login2.jsp";
					
				}	
			//}else{
				//address=src+"/fail_hcid.jsp";
			//}
			
		}
		
		else if(action.equals("addCommment")){									//����߰�						//��𼭿Դ���
			String from = request.getParameter("from");
			String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
			int list_n=Integer.parseInt(request.getParameter("list_n"));
			String comment_contents = request.getParameter("comment_contents");
			System.out.println("����߰�");
			System.out.println("���� ���̵�"+member_id);
			System.out.println("�ش� �Խ��� ��ȣ"+list_n);
			System.out.println("��� ����"+comment_contents);
			if(member_id==null){//�α��ξ��Ѱ��
				address=src+"/fail_login_p.jsp";
			}else if(comment_contents==null){//�ۼ������Ѱ��
				address=src+"/fail_contents.jsp";
			}else{
			HoneyBean comment=new HoneyBean();
			comment.setComment_contents(comment_contents);
			comment.setList_n(list_n);
			comment.setMember_id(member_id);
			System.out.println("�������");
			dao.addComment(comment);
			System.out.println("���ӿϷ�");
			request.setAttribute("from", from);
			address="HoneyControl?action=viewlist&list_n="+list_n;
			}			
		}
		
		else if(action.equals("deleteComment")){									//��� ����
			int list_n = Integer.parseInt(request.getParameter("list_n"));							//��𼭿Դ���
			int comment_n=Integer.parseInt(request.getParameter("comment_n"));
			System.out.println("��������");
			dao.deleteComment(comment_n);
			address="HoneyControl?action=viewlist&list_n="+list_n;
		}
		
		else if(action.equals("favoritehoneycomb")){							//������ ��������
			String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
			ArrayList<HoneyBean> fvhoney = dao.getFvhoneycomb(member_id);
			request.setAttribute("fvhoney",fvhoney);
			address=src+"/H_favoritehoneycomb.jsp";
		}
		
		else if(action.equals("addFavoritehc")){								//������ �����뿡 �߰��ϱ�
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//���ڷ� ���� ���̵� �������
				String from = request.getParameter("from");							//��𼭿Դ���
				String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));
			
				if(member_id==null){												//��α����ΰ��
					address=src+"/fail_login_p.jsp";
				}else if(dao.getHcpwd(hc_id)==null){								//hc_id�� ���°��
					address=src+"/fail_hcid.jsp";
			
				}else{					
					HoneyBean fvhoney = new HoneyBean();
					fvhoney.setHc_id(hc_id);
					fvhoney.setMember_id(member_id);
					
					if(dao.checkFvhoneycomb(fvhoney)){			//�ش������ ��ã�ߴ��� üũ ������ true������false
						address=src+"/fail_samefv.jsp";
					}else{
						dao.addFvhoneycomb(fvhoney);
				
						String ok = "ok";
						request.setAttribute("fvhcok",ok);					//�����ߴٰ� �˸�
						address=from;
					}
				}
			}else{
				address=src+"/fail_hcid.jsp";
			}
		}
		else if(action.equals("deleteFavoritehc")){		
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){		//���ڷ� ���� ���̵� �������
				String member_id=(String)session.getAttribute("member_id");			//�������� ���̵� �ޱ�
				int hc_id=Integer.parseInt(request.getParameter("hc_id"));
			
				if(member_id==null){												//��α����ΰ��
					address=src+"/fail_login_p.jsp";
				}else if(dao.getHcpwd(hc_id)==null){								//hc_id�� ���°��
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
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			System.out.println("�Խ��Ǻ���"+from);
			if(from==null){
				System.out.println("�ƹ��͵� ����1");
			}else if(from.equals("ranking")){
				System.out.println("��ŷ");
				ArrayList<HoneyBean> list = dao.getHoneyRanking();
				request.setAttribute("eventlist", list);
			}
			else if(from.equals("newvideo")){
				System.out.println("�ֽ�");
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
		//�ֽ��� ���� �κ�+�����߰���
		else if(action.equals("ranking")) {									//��			 ��ŷâ����
			ArrayList<HoneyBean> list = dao.getHoneyRanking();
			request.setAttribute("eventlist", list);
			address = src+"/H_Board.jsp";
		}
		
		else if(action.equals("newvideo")){
			ArrayList<HoneyBean> list = dao.getHoneyVideo();					//��			�ֽź�����	
			String main=request.getParameter("main");
			request.setAttribute("main",main);
			request.setAttribute("eventlist", list);
			address = src+"/H_Board.jsp";
		}
		
		else if(action.equals("updateGood")){									//�� 			���ƿ� ���ϱ�
			String member_id=(String)session.getAttribute("member_id");		//�������� ���̵� ��� �ޱ�	
			System.out.println(member_id);
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			int good=Integer.parseInt(request.getParameter("good"));	
			String list_member_id=dao.getListMemberid(list_n);				//�Խ��Ǿ� ���̵�
			if(member_id==null){										//�α��� ���Ѱ��
				address =src+"/fail_login_p.jsp";
			}
			else if(member_id.equals(list_member_id)){							//�ۼ��� �����ΰ��
				address =src+"/fail_goodbad_id.jsp";	
			}
			else if(dao.checkgoodbad(member_id,list_n).equals("true")){					//�̹� �� �ߴ��� üũ
				address = src+"/fail_goodbad2.jsp";
				
			}else{
				dao.updategoodbad(member_id,list_n);						//�ߴٰ� goodbad���̺� �߰�
				good=good+1;			
				dao.updateGood(list_n, good);
				address="HoneyControl?action=viewlist&list_n="+list_n;
			}
		}else if(action.equals("updateBad")){									//�� 			�Ⱦ�� ���ϱ�
			String member_id=(String)session.getAttribute("member_id");		//�������� ���̵� ��� �ޱ�	
			int list_n = Integer.parseInt(request.getParameter("list_n"));
			int bad=Integer.parseInt(request.getParameter("bad"));	
			String list_member_id=dao.getListMemberid(list_n);				//�Խ��Ǿ� ���̵�
			if(member_id==null){										//�α��� ���Ѱ��
				address =src+"/fail_login_p.jsp";
			}
			else if(member_id.equals(list_member_id)){							//�ۼ��� �����ΰ��
				address =src+"/fail_goodbad_id.jsp";	
			}
			else if(dao.checkgoodbad(member_id,list_n).equals("true")){					//�̹� �� �ߴ��� üũ
				address = src+"/fail_goodbad2.jsp";
				
			}else{
				dao.updategoodbad(member_id,list_n);						//�ߴٰ� goodbad���̺� �߰�
				bad=bad+1;			
				dao.updateBad(list_n, bad);
				address="HoneyControl?action=viewlist&list_n="+list_n;
			}
		}else if(action.equals("upload")){									//�� �Խ��� ���ε�
			String member_id=(String)session.getAttribute("member_id");		//�������� ���̵� �ޱ�		
			ArrayList<HoneyBean> list = dao.getMyhoneycomb(member_id);
			request.setAttribute("eventlist", list);
			address = src+"/H_listUpload.jsp";
		}
		else if(action.equals("list_upload")){							//�� �Խ��� ���ε�
			if(Pattern.matches("^[0-9]+$",request.getParameter("hc_id"))){//���ڷ� �Է��Ѱ��
				HoneyBean event = new HoneyBean();
				String member_id=(String)session.getAttribute("member_id");		//�������� ���̵� �ޱ�		
			
				event.setMember_id(member_id);
				event.setHc_id(Integer.parseInt(request.getParameter("hc_id")));
				event.setList_title(request.getParameter("list_title"));
				event.setList_contents(request.getParameter("list_contents"));
				dao.addList(event);
			
				address="HoneyControl?action=newvideo";
			}else{
				address=src+"/fail_hcid.jsp";
			}
			
		}else if(action.equals("hccreate")){														//�� ���� ����
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
