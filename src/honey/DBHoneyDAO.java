package honey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


public class DBHoneyDAO implements HoneyDAO{
	private String jdbc_driver = "com.mysql.jdbc.Driver";
	private String jdbc_url =  "jdbc:mysql://localhost:3306/mydb?characterEncoding=utf8&autoReconnect=true&useSSL=false";
	private Connection conn;
	private Statement stmt;
	
	private void connect(){
		try{
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,"root","sjb378");
			stmt = conn.createStatement();
		}catch(Exception e){}
		
	}
	private void disconnect(){
		try{
			stmt.close();
			conn.close();
		}catch(Exception e){}
		
	}
	
	//회원가입하는 디비
	public void addMember(HoneyBean event){
		String sql="insert into member (member_id,member_pwd,member_name,member_mail)values('"
				+event.getMember_id()+"','"
				+event.getMember_pwd()+"','"
				+event.getMember_name()+"','"
				+event.getMember_mail()+"')";
		try{
			connect();
			stmt.executeUpdate(sql);
			disconnect();
		}catch(Exception e){}
	}
	
	//회원정보 변경
	public void updateMember(HoneyBean event){
		String sql ="update member set member_pwd='"+ event.getMember_pwd() + "',member_name='"+ event.getMember_name() + "',member_mail='"+ event.getMember_mail() + "'  where member_id='"+event.getMember_id()+"'";
		try{
			connect();
			stmt.executeUpdate(sql);
			disconnect();
		}catch(Exception e){}
	}
	
	//아이디가 있는지 없는지 검사하는 디비
	public HoneyBean memberCheck(String member_id, String member_pwd){
		String sql ="select * from member where member_id='"+ member_id + "' AND member_pwd='"+member_pwd+"'";
		HoneyBean event = new HoneyBean();
		try{
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			event.setMember_id(rs.getString("member_id"));
			event.setMember_pwd(rs.getString("member_pwd"));
			event.setMember_name(rs.getString("member_name"));
			event.setMember_mail(rs.getString("member_mail"));
			rs.close();
			disconnect();
		}catch(Exception e){}
		return event;
	}
	
	public HoneyBean joinCheck(String member_id){
		String sql ="select * from member where member_id='"+ member_id + "'";
		HoneyBean event = new HoneyBean();
		try{
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			event.setMember_id(rs.getString("member_id"));
			rs.close();
			disconnect();
		}catch(Exception e){}
		return event;
	}
	

	
	public ArrayList<HoneyBean> getMyhoneycomb(String member_id){		//자기의 벌꿀집 리스트
		String sql = "select * from hc where member_id='"+ member_id +"'";
		ArrayList<HoneyBean> myhoney = new ArrayList<HoneyBean>();
		try{
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				HoneyBean event = new HoneyBean();
				event.setHc_id(rs.getInt("hc_id"));
				event.setHc_pwd(rs.getString("hc_pwd"));
				event.setHc_title(rs.getString("hc_title"));
				myhoney.add(event);
			}
			rs.close();
			disconnect();
		}catch(Exception e){}
		return myhoney;
	}
	
	public ArrayList<HoneyBean> getMylist(String member_id){			//자기의 게시글 리스트
		String sql = "select * from list where member_id='"+ member_id +"'";
		ArrayList<HoneyBean> list = new ArrayList<HoneyBean>();
		try{
			
			connect();
		
			ResultSet rs = stmt.executeQuery(sql);
	
			while(rs.next()){
				HoneyBean event = new HoneyBean();
				event.setList_n(rs.getInt("list_n"));
				event.setList_title(rs.getString("list_title"));
				event.setList_contents(rs.getString("list_contents"));
				event.setList_time(rs.getString("list_time"));
				event.setList_good(rs.getInt("list_good"));
				event.setList_bad(rs.getInt("list_bad"));
				event.setHc_id(rs.getInt("hc_id"));
				list.add(event);
			}
			
			rs.close();
			disconnect();
		}catch(Exception e){}
		return list;
	}
	public void updategoodbad(String member_id,int list_n){					//goodbad에 추가하기
		String sql="insert into goodbad (member_id,list_n) values('"+member_id+"',"+list_n+")";
		try{
			connect();
			stmt.executeUpdate(sql);		
			disconnect();
		}catch(Exception e){
		}
	}
	public String checkgoodbad(String member_id,int list_n){				//goodbad에 있는지 확인하기
		String check="false";
		String sql="select * from goodbad where member_id='"+member_id+"' AND list_n="+list_n+"";
		try{
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()){	//만일 좋아요 누른경우
				check="true";	//이미 평가함
			}
			else{
				check="false";	//아직 평가 안함
			}
			rs.close();
			disconnect();
		}catch(Exception e){
			
		}
		return check;
	}
	public String getListMemberid(int list_n){
		String sql="select member_id from list where list_n="+list_n+"";
		String member_id=null;
		try{
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()){								//리스트의 작성자 아이디;
				member_id=rs.getString("member_id");
			}
			rs.close();
			disconnect();
		}catch(Exception e){
		}
		return member_id;
	}
	
	//주식 db
	public ArrayList<HoneyBean> getHoneyVideo() {	
		   String sql = "select * from member, list where member.member_id=list.member_id order by list_time DESC";
		   ArrayList<HoneyBean> list = new ArrayList<HoneyBean>();
		   try{
			   connect();
			   ResultSet rs = stmt.executeQuery(sql);
			   while(rs.next()){
				   HoneyBean event = new HoneyBean();
				   event.setList_title(rs.getString("list_title"));
				   event.setMember_name(rs.getString("Member_name"));
				   event.setMember_id(rs.getString("Member_id"));
				   event.setList_time(rs.getString("list_time"));
				   event.setList_good(rs.getInt("list_good"));
				   event.setList_bad(rs.getInt("list_bad"));
				   event.setList_n(rs.getInt("list_n"));
				   event.setList_contents(rs.getString("list_contents"));
				   event.setHc_id(rs.getInt("hc_id"));
				   list.add(event);
			   }
			   rs.close();
			   disconnect();
		   } catch(Exception e){ }
		   return list;
	   }
	   
	   public ArrayList<HoneyBean> getHoneyRanking() {	
		   String sql = "select * from member, list where member.member_id=list.member_id order by list_good-list_bad desc";
		   ArrayList<HoneyBean> list = new ArrayList<HoneyBean>();
		   try{
			   connect();
			   ResultSet rs = stmt.executeQuery(sql);
			   while(rs.next()){
				   HoneyBean event = new HoneyBean();
				   event.setList_title(rs.getString("list_title"));
				   event.setMember_name(rs.getString("Member_name"));
				   event.setMember_id(rs.getString("Member_id"));
				   event.setList_time(rs.getString("list_time"));
				   event.setList_good(rs.getInt("list_good"));
				   event.setList_bad(rs.getInt("list_bad"));
				   event.setList_n(rs.getInt("list_n"));
				   event.setHc_id(rs.getInt("hc_id"));
				   event.setList_contents(rs.getString("list_contents"));
				   list.add(event);
			   }
			   rs.close();
			   disconnect();
		   } catch(Exception e){ }
		   return list;
	   }
	   public void updateGood(int list_n, int list_good){
			String sql ="update list set list_good=" + list_good+" where list_n="+list_n+"";
			try {
				connect();
				stmt.executeUpdate(sql);
				disconnect();
			} catch (Exception e) {
			}
		}
			
		public void updateBad(int list_n, int list_bad){
			String sql ="update list set list_bad=" + list_bad+" where list_n="+list_n;
			try {
				connect();
				stmt.executeUpdate(sql);
				disconnect();
			} catch (Exception e) {
			}
		}
		public void addList(HoneyBean event) {
			String sql = "insert into list (list_title, list_contents, list_time, list_good, list_bad, hc_id, member_id)values('" + event.getList_title()
					+ "','" + event.getList_contents() + "', now() ," + 0 + "," + 0 + "," + event.getHc_id() + ",'" + event.getMember_id() + "')";
			System.out.println(sql);
			try {
				connect();
				stmt.executeUpdate(sql);
				disconnect();
			} catch (Exception e) {
			}
		}
	   
	   //동협 db
	 	
		// HC의 아이디 중복 체크
		public boolean isGoodHC_ID(int newId) {
			String sql = "select hc_id from hc where hc_id=" + newId;
			boolean isGood = false;
			try {
				connect();
				ResultSet rs = stmt.executeQuery(sql);
				isGood = !rs.next();
				rs.close();
				System.out.println("isGoodHC_ID 성공");
				disconnect();
			} catch (Exception e) {
				System.out.println("isGoodHC_ID 에러");
			}
			
			return isGood;
		}

		// DB에 벌집 생성
		public void addHC(Mgr_bean bean) {
			String member_id = null;
			int hc_id = bean.getHc_id();
			
			// 멤버 아이디가 없으면 null로 값을 넣음
			if (bean.getMember_id() != null) {
				member_id = "'" + bean.getMember_id() + "'";
			}
			String sql = "insert into hc values(" + hc_id + ", '" + bean.getHc_pwd() + "', '" + bean.getHc_title()
				+ "', " + member_id + ")";
			
			ArrayList<String> URLs = bean.getURLs();
			try {
				connect();
				stmt.executeUpdate(sql);	// hc 생성
				System.out.println("hc 생성");
				// 동영상 테이블 생성
				for (int i=0; i<URLs.size(); i++) {
					String url = URLs.get(i);
					url = url.replace("'", "''");
					
					sql = "insert into video_list values(" + i + ", '" + url + "', "
							+ hc_id + ")";
					stmt.executeUpdate(sql);
				}
				System.out.println("video_list 생성");
				disconnect();
			} catch (Exception e) {
				System.out.println("addHC Exception !!");
			}
			
		}

		// 해당 hc_id의 벌집 제거
		public void removeHC(int hc_id) {
			String sql = "delete from hc where hc_id=" + hc_id;
			   try{
				   connect();
				   stmt.executeUpdate(sql);
				   System.out.println("지우기HC성공 !!");
				   disconnect();
			   } catch(Exception e){
				   System.out.println("지우기HC Exception !!"+sql);
			   }
		}
		
		// 해당 hc_id의 벌집 리턴
		public Mgr_bean getHC(int hc_id) {
			Mgr_bean HC = new Mgr_bean();
			
			String sql = "select * from hc where hc_id=" + hc_id;
			ResultSet rs;
			try {
				connect();
				rs = stmt.executeQuery(sql);
				
				// 해당 아이디 없음.
				if (!rs.next()) {
					return null;
				}
				
				// 벌집 값 설정
				HC.setHc_id(hc_id);
				HC.setHc_pwd(rs.getString("hc_pwd"));
				HC.setHc_title(rs.getString("hc_title"));
				HC.setMember_id(rs.getString("member_id"));
				rs.close();
				
				// 해당되는 비디오 리스트들 출력
				sql = "select * from video_list where hc_id=" + hc_id;
				rs = stmt.executeQuery(sql);
				
				ArrayList<String> URLs = new ArrayList<String>();
				while (rs.next()) {
					URLs.add(rs.getString("video_url"));
				}
				HC.setURLs(URLs);
				
				rs.close();
				System.out.println("getHC성공 !!");
				disconnect();
			} catch (Exception e) {
				System.out.println("getHC Exception !!");
				return null;
			}
			
			return HC;
		}
		
		
		/*
		    * 겨우 만들었지만 다른거로 대체하개되서 없어진거 hc에서 영상불러오는 gethc와 겹쳐서
		    * 사라지는대 그냥 남김
		    * */
		   public String getHcpwd(int hc_id) { 				 //해당 hc의 비밀번호만 가져오는 쿼리
			   String sql = "select * from hc where hc_id=" + hc_id;
			   String hc_pwd =null;
			   try{
				   connect();
				   ResultSet rs = stmt.executeQuery(sql);			   
				   if(rs.next()){
					   hc_pwd=rs.getString("hc_pwd");
				   }
				   disconnect();
			   } catch(Exception e){ }
			   return hc_pwd;
		   }
		   
		   public void removeList(int list_n){				//해당 리스트 삭제
			   String sql = "delete from list where list_n="+list_n;
			   System.out.println(sql);
			   try{
				   connect();
				   stmt.executeUpdate(sql);
				   System.out.println("지우기게시판성공 !!");
				   disconnect();
			   }catch(Exception e){
				   System.out.println("지우기게시판실패");
			   }		   
		   }
		   
		   public void updateList(HoneyBean event){				//해당 리스트 수정
			   int hc_id=event.getHc_id();
			   int list_n=event.getList_n();
			   String list_contents=event.getList_contents();		   
			   String list_title=event.getList_title();
			   
			   String sql ="update list set list_title='" + list_title+"', list_contents='"+list_contents+"', list_time = now(), hc_id="+hc_id+"  where list_n="+list_n;
			   System.out.println(sql);
			   try{
				   connect();
				   stmt.executeUpdate(sql);
				   System.out.println("게시판 수정 성공 !!");
				   disconnect();
			   }catch(Exception e){
				   System.out.println("게시판 수정 실패");
			   }

		   }
		   
		   public HoneyBean getList(int list_n){				//해당 리스트의 내용물 가져오기
			   String sql="select * from list where list_n="+list_n;
			   HoneyBean honey = new HoneyBean();
			   try{
				   connect();
				   ResultSet rs=stmt.executeQuery(sql);
				   
				   if(rs.next()){
					   honey.setList_n(list_n);
					   honey.setList_title(rs.getString("list_title"));
					   honey.setList_time(rs.getString("list_time"));
					   honey.setList_contents(rs.getString("list_contents"));
					   honey.setMember_id(rs.getString("member_id"));
					   honey.setList_good(rs.getInt("list_good"));
					   honey.setList_bad(rs.getInt("list_bad"));
					   honey.setHc_id(rs.getInt("hc_id"));
				   }
				   
				   System.out.println("게시판 불러오기 성공 !!");
				   rs.close();
				   disconnect();
			   
			   }catch(Exception e){
				   System.out.println("게시판 불러오기 실패");
			   }	   
			   return honey;
		   }
		   
		   //addcomment 댓글 추가
		   public void addComment(HoneyBean comment){
			   String sql="insert into comment (list_n,member_id,comment_contents,comment_time) values("+comment.getList_n()+",'"+comment.getMember_id()+"','"+comment.getComment_contents()+"',now())";
			   System.out.println(sql);
			   try{
				   System.out.println("접속");
				   connect();
				   System.out.println("실행");
				   stmt.executeUpdate(sql);	
				   System.out.println("완료 접속종료");
				   disconnect();
			   }catch(Exception e){
				   System.out.println("댓글작성실패");
			   }
		   }
		   //deletecomment
		   public void deleteComment(int comment_n){
			   String sql="delete from comment where comment_n="+comment_n;
			   System.out.println(sql);
			   try{
				   connect();
				   stmt.executeUpdate(sql);				   
				   disconnect();
			   }catch(Exception e){
				   System.out.println("댓글삭제실패");
			   }
		   }
		   //updatecomment
		   public void updateComment(HoneyBean comment){
			   String sql="update comment set comment_contents='"+comment.getComment_contents()+"' where comment_n="+comment.getComment_n();
			   System.out.println(sql);
			   try{
				   connect();
				   stmt.executeUpdate(sql);				   
				   disconnect();
			   }catch(Exception e){
				   System.out.println("댓글수정실패");
			   }
		   }
		   //getcomment 댓글 불러오기
		   public ArrayList<HoneyBean> getComment(int list_n){
			   String sql="select * from comment where list_n="+list_n;
			   ArrayList<HoneyBean> comment = new ArrayList<HoneyBean>();
			   System.out.println("이게 댓글불러오기 명령어"+sql);
			   try{
				   connect();
				   System.out.println("실행전");
				   ResultSet rs = stmt.executeQuery(sql);
				   System.out.println("실행");
				   while(rs.next()){
					   HoneyBean honey = new HoneyBean();
					   honey.setComment_n(rs.getInt("comment_n"));
					   System.out.println("실행"+rs.getInt("comment_n"));
					   honey.setComment_contents(rs.getString("comment_contents"));
					   System.out.println("실행"+rs.getString("comment_contents"));
					   honey.setComment_time(rs.getString("comment_time"));
					   System.out.println("실행"+rs.getString("comment_time"));
					   honey.setMember_id(rs.getString("member_id"));
					   System.out.println("실행"+rs.getString("member_id"));
					   comment.add(honey);
				   }   
				   rs.close();
				   disconnect();
			   }catch(Exception e){
				   System.out.println("댓글불러오기실패");
			   }
			   return comment;
		   }
		   public void addFvhoneycomb(HoneyBean fvhoney){
			   String sql = "insert into hc_favorite (hc_id,member_id) values("+fvhoney.getHc_id()+",'"+fvhoney.getMember_id()+"')";
			   try{
				   connect();
				   
				   stmt.executeUpdate(sql);
				   
				   disconnect();
			   }catch(Exception e){
				   System.out.println("찍은 벌꿀통 추가하기실패");
			   }
			   
			   
		   }
		   
		   public ArrayList<HoneyBean> getFvhoneycomb(String member_id){					//찍어놓은 벌꿀집 리스트
				String sql = "select * from hc_favorite,hc where hc.hc_id=hc_favorite.hc_id AND hc_favorite.member_id='"+ member_id +"'";
				System.out.println("찍은 벌꿀 쿼리문"+sql);
				ArrayList<HoneyBean> fvhoney = new ArrayList<HoneyBean>();
				try{
					connect();
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						HoneyBean event = new HoneyBean();
						event.setHc_id(rs.getInt("hc_id"));
						event.setHc_title(rs.getString("hc_title"));
						event.setMember_id(rs.getString("hc.member_id"));
						System.out.println(rs.getString("hc.member_id"));
						fvhoney.add(event);
					}
					rs.close();
					disconnect();
				}catch(Exception e){
					 System.out.println("찍은 벌꿀통 불러오기실패");
				}
				return fvhoney;
			}
		   
		   //검색을 위한 디비들의 모음입니다.
		   //꿀통 제목
		   public ArrayList<HoneyBean> getHoneytitle(String search){					
				String sql = "select * from hc where hc_title like '%"+search+"%'";
				System.out.println("꿀통제목 검색문"+sql);
				ArrayList<HoneyBean> honey = new ArrayList<HoneyBean>();
				try{
					connect();
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						HoneyBean event = new HoneyBean();
						event.setHc_id(rs.getInt("hc_id"));
						event.setHc_title(rs.getString("hc_title"));
						event.setMember_id(rs.getString("member_id"));
						honey.add(event);
					}
					rs.close();
					disconnect();
				}catch(Exception e){
					 System.out.println("꿀통제목검색실패");
				}
				return honey;
			}
			//게시글제목
		   public ArrayList<HoneyBean> getListtitle(String search){					
				String sql = "select * from list where list_title like'%"+ search +"%'";
				System.out.println("게시글제목 검색"+sql);
				ArrayList<HoneyBean> honey = new ArrayList<HoneyBean>();
				try{
					connect();
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						HoneyBean event = new HoneyBean();
						event.setList_n(rs.getInt("list_n"));
						event.setList_title(rs.getString("list_title"));
						event.setList_contents(rs.getString("list_contents"));
						event.setList_time(rs.getString("list_time"));
						event.setMember_id(rs.getString("member_id"));
						honey.add(event);
					}
					rs.close();
					disconnect();
				}catch(Exception e){
					 System.out.println("게시판 제목 검색 실패");
				}
				return honey;
			}
			//게시글내용
		   public ArrayList<HoneyBean> getListcontents(String search){					//찍어놓은 벌꿀집 리스트
				String sql = "select * from list where list_contents like '%"+ search +"%'";
				System.out.println("게시글제목 검색"+sql);
				ArrayList<HoneyBean> honey = new ArrayList<HoneyBean>();
				try{
					connect();
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						HoneyBean event = new HoneyBean();
						event.setList_n(rs.getInt("list_n"));
						event.setList_title(rs.getString("list_title"));
						event.setList_contents(rs.getString("list_contents"));
						event.setList_time(rs.getString("list_time"));
						event.setMember_id(rs.getString("member_id"));
						honey.add(event);
					}
					rs.close();
					disconnect();
				}catch(Exception e){
					 System.out.println("게시판 제목 검색 실패");
				}
				return honey;
			}
		   
		   
		    
		

}
