package honey;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import honey.DBHoneyDAO;
import honey.HoneyDAO;

/**
 * Servlet implementation class Creator
 */
@WebServlet("/Creator")
public class Creator extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Creator() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Mgr_bean HC = (Mgr_bean) session.getAttribute("HC");
		
		String address = null;
		String src="./comb";
		String mode=request.getParameter("mode");
		String type=request.getParameter("type");
		
		
		// edit 모드면 리퀘스트에 edit등록
		if (mode.equals("edit")) {
			request.setAttribute("mode", "edit");	// 리퀘스트에 edit 등록
		}
		
		// URL 추가 버튼을 눌렀을때 (mgr_bean에만 추가 db연동x)
		if (type.equals("addUrl")) {
			
			
			Mgr_bean a = (Mgr_bean)session.getAttribute("HC");
			ArrayList b = a.getURLs();
			int s= b.size();
			System.out.println("이게 추가하기전"+s);
			HC.addURL(request.getParameter("URL")); // 해당URL추가
			session.setAttribute("HC", HC);
			a = (Mgr_bean)session.getAttribute("HC");
			 b = a.getURLs();
			 s= b.size();
			 System.out.println("이게 추가한후"+s);
			// forward
			 address = src+"/manager/createHC.jsp";

		}
		// URL 제거버튼 눌렀을때 (Mgr_bean에만 추가 db연동x)
		else if (type.equals("delUrl")) {
			
			
																		
			
			Mgr_bean a = (Mgr_bean)session.getAttribute("HC");
			ArrayList b = a.getURLs();
			int s= b.size();
			System.out.println("이게 삭제전"+s);
			
			HC.delURL(Integer.parseInt(request.getParameter("index"))); // 해당// URL// 제거
			session.setAttribute("HC", HC);
			
			a = (Mgr_bean)session.getAttribute("HC");
			 b = a.getURLs();
			 s= b.size();
			 System.out.println("이게 삭 제한후"+s);
			
			// forward
			 address = src+"/manager/createHC.jsp";
		}
		// 제출 버튼을 눌렀을때
		else if (type.equals("viewHC")) {
			out = response.getWriter();
			
			String member_id=(String)session.getAttribute("member_id");
			HC.setMember_id(member_id);
			System.out.println("이게 아이디이다."+member_id);
			
			String hc_title = request.getParameter("hc_title");
			String hc_pwd = request.getParameter("hc_pwd");
			if (hc_title != null)
				HC.setHc_title(hc_title.replace("'", "''"));	// 제목
			if (hc_pwd != null)
				HC.setHc_pwd(hc_pwd.replace("'", "''"));	// 패스워드
			
			
			isReady(HC);	// 만들기 위한 최소 값이 있는 지 체크
	
			
			HoneyDAO DB = new DBHoneyDAO();	// DAO클래스 생성
			
			if (mode.equals("create"))	//생성 모드면 
				makeID(HC, DB);	// 벌집 아이디 부여
			else {
				DB.removeHC(HC.getHc_id());
				System.out.println("지웠다");
			}
			
			
			
			
			insertToDB(HC, DB);	// 현자 hc로 db에 벌집 생성
			
			// 결과 주소 출력
			String result = "http://hcvideo.mooo.com:8081/honey/Viewer?hc_id="+HC.getHc_id();
			
			
			
			
			address = src+"/manager/createHC.jsp";
			session.removeAttribute("HC");
			request.setAttribute("result", result);//??어디다 씀이거 뭐야  어디다 보내는거야
			
			

			// session.setAttribute("HC", HC);
			// String address = "manager/viewHC.jsp";
			// RequestDispatcher dispatcher =
			// request.getRequestDispatcher(address);
			// dispatcher.forward(request, response);
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request, response);
	}

	// 추가할 준비가 다 되어있는지 체크
	private void isReady(Mgr_bean HC) {
		if (HC == null) {
			out.println("<script>alert('에러 (HC=null in isReady)');history.back();</script>");
			out.flush();
			return;
		}
		// 자료가 있는 지 체크
		if (HC.getURLs().size() == 0) {
			out.println("<script>alert('자료를 등록하세요');history.back();</script>");
			out.flush();
			return;
		}
		//비밀 번호가 입력되이있는지 체크
		if (HC.getHc_pwd() == null) {
			out.println("<script>alert('비밀번호를 입력하세요');history.back();</script>");
			out.flush();
			return;
		}
	}

	// 벌집 아이디를 만들어서 mgr_bean에 부여
	private void makeID(Mgr_bean HC, HoneyDAO DB) {
		int newId = 0;
		// id 생성& 중복검사
		do {
			newId = (int) (Math.random() * 100000);
		} while (!(DB.isGoodHC_ID(newId)));

		// 아이디 설정
		HC.setHc_id(newId);
	}

	//현재 mgr_bean를 db에 추가
	private void insertToDB(Mgr_bean HC, HoneyDAO DB) {
		// 아이디가 부여되있는지 체크
		if (HC.getHc_id() == 0) {
			out.println("<script>alert('오류: hc_id가 부여되지 않았습니다.');history.back();</script>");
			out.flush();
			return;
		}
		DB.addHC(HC);	// hc�� video_list 紐⑸줉 �깮�꽦
	}
}
