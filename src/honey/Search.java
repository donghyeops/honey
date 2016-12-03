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
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
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
		
		//검색을 실행
		if(request.getParameter("search")==null){
			address=src+"/fail_contents.jsp";
		}else{
		
			String search = request.getParameter("search");//문자
		if(Pattern.matches("^[0-9]+$", search)){
			int search_int= Integer.parseInt(search);//숫자로 
			System.out.println("검색할것들 문자"+search);
			System.out.println("검색할것들 숫자"+search_int);
			
			
			//꿀통 아이디
			Mgr_bean HC_id=dao.getHC(search_int);		//동 해당hc_id벌집 리턴
			
			
			//꿀통 제목
			 ArrayList<HoneyBean> HC_title = dao.getHoneytitle(search);
				
				//게시글제목
				 ArrayList<HoneyBean> LIST_title=dao.getListtitle(search);			//게시판 제목 검색
					
				//게시글내용
				ArrayList<HoneyBean> LIST_contents=dao.getListcontents(search);			//게시판 내용 검색
				
				
				request.setAttribute("HC_id", HC_id);
				request.setAttribute("HC_title", HC_title);
				request.setAttribute("LIST_title", LIST_title);
				request.setAttribute("LIST_contents", LIST_contents);
			
			address=src+"/H_search_result.jsp";
			//숫자임
		}else{
			//숫자아님		
			System.out.println("검색할것들 "+search);
			
			
			
			
			//꿀통 제목
			 ArrayList<HoneyBean> HC_title = dao.getHoneytitle(search);
			
			//게시글제목
			 ArrayList<HoneyBean> LIST_title=dao.getListtitle(search);			//게시판 제목 검색
				
			//게시글내용
			ArrayList<HoneyBean> LIST_contents=dao.getListcontents(search);			//게시판 내용 검색
			
			
			
			request.setAttribute("HC_title", HC_title);
			request.setAttribute("LIST_title", LIST_title);
			request.setAttribute("LIST_contents", LIST_contents);
			
			
			address=src+"/H_search_result.jsp";
			
			
			
		}
	
		
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
