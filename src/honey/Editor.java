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
 * Servlet implementation class Editor
 */
@WebServlet("/Editor")
public class Editor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Editor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				// request의 파라미터
				// 1. String hc_id : 벌집의 아이디
				// 2. String input_pwd : 입력한 벌집의 비밀번호
				// 순서도 : (벌집 아이디로 Mgr_bean 가져옴) -> (벌집의 비밀번호와 입력 받은 비밀번호 값을 대조[틀리면 빽])
				//			-> (Mgr_bean을 createHC로 넘김))
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String src="./comb";
		PrintWriter out = response.getWriter();
		HoneyDAO DB = new DBHoneyDAO();
		String input_hc_id = request.getParameter("hc_id");
		String input_pwd = request.getParameter("input_pwd");
		// 입력받은 값이 없으면 빽
		
		
		
		if (input_hc_id == null || input_pwd == null) {
			out.println("<script>alert('can't find values');history.back();</script>");
			out.flush();
			return;
		}
		
		int hc_id = Integer.parseInt(input_hc_id);
		Mgr_bean HC = DB.getHC(hc_id);	
		
		// hc_id에 해당하는 값이 없으면 빽
		if (HC == null) {
			out.println("<script>alert('해당 hc_id는 존재하지 않습니다');history.back();</script>");
			out.flush();
			return;
		}
		
		// 비밀번호가 안맞으면 빽
		if (!HC.getHc_pwd().equals(input_pwd)) {
			out.println("<script>alert('비밀번호가 틀렸습니다');history.back();</script>');history.back();</script>");
			out.flush();
			return;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("HC", HC);	//세션에 Mgr_bean 등록
		request.setAttribute("mode", "edit");	// 리퀘스트에 edit 등록
		// forward
		String address = src+"/manager/createHC.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request, response);
	}

}
