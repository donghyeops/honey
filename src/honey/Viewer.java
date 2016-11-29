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

import honey.DBHoneyDAO;
import honey.HoneyDAO;

/**
 * Servlet implementation class Viewer
 */
@WebServlet("/Viewer")
public class Viewer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Viewer() {
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
		String src="./comb";
		String address= null;
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		int hc_id = Integer.parseInt(request.getParameter("hc_id"));
		
		HoneyDAO dao = new DBHoneyDAO();	
		Mgr_bean HC = dao.getHC(hc_id);
		
		
		String ok=(String)request.getAttribute("fvhcok");
		request.setAttribute("HC",HC);
		request.setAttribute("fvhcok",ok);
		
		address = src+"/H_viewHc.jsp";
		
		
		// forward
		RequestDispatcher dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
