package honey;

import java.util.ArrayList;


public interface HoneyDAO {


	
	//회원정보
	public void addMember(HoneyBean event);								//멤버추가 회원가입
	public void updateMember(HoneyBean event);							//회원정보 변경
	
	public HoneyBean memberCheck(String member_id, String member_pwd);	//로그인체크 	로그인시 아이디와 비밀번호 체크
	public HoneyBean joinCheck(String member_id);						//회원가입체크	회원가입시 아이디 중복여부 체크
	
	//벌꿀집
	public ArrayList<HoneyBean> getHoneytitle(String search);			//벌꿀집 제목 검색
	 
	public ArrayList<HoneyBean> getMyhoneycomb(String member_id);		//자기의 벌꿀집 리스트
	public ArrayList<HoneyBean> getFvhoneycomb(String member_id);		//찍어놓은 벌꿀집 리스트
	public boolean isGoodHC_ID(int newId);								//동 hc아이디 중복 체크
	public Mgr_bean getHC(int hc_id);									//동 해당hc_id벌집 리턴
	public String getHcpwd(int hc_id);									//해당hc_id의 pwd만 가져온다
	public void addFvhoneycomb(HoneyBean fvhoney);						//찍은벌꿀통 추가하기
	public void addHC(Mgr_bean bean);									//동 db에 벌집 생성
	public void removeHC(int hc_id);									//벌꿀집 삭제
	
	
	//게시판
	public ArrayList<HoneyBean> getListtitle(String search);			//게시판 제목 검색
	public ArrayList<HoneyBean> getListcontents(String search);			//게시판 내용 검색
	
	public ArrayList<HoneyBean> getHoneyVideo();						//주 최신비디오
	public ArrayList<HoneyBean> getHoneyRanking();						//주 랭킹 
	public ArrayList<HoneyBean> getMylist(String member_id);			//자기의 게시글 리스트
	
	public void addList(HoneyBean event); 								//주  리스트 업로드용
	public void removeList(int list_n);									//해당 게시판 삭제
	public void updateList(HoneyBean event);							//해당 게시판 수정
	
	public HoneyBean getList(int list_n);								//해당 리스트의 내용물을 갖는용
	public String getListMemberid(int list_n);							//게시판의 멤버아이디를 얻는 쿼리
	
	
	
	//좋아요싫어요 평가
	public void updateGood(int list_n, int list_good);					//주 달아요 점수 증가 업데이트용
	public void updateBad(int list_n, int list_bad);					//주 써요 점수 증가 업데이트용
	public void updategoodbad(String member_id,int list_n);				//누가 좋아요누른지 확인용 디비
	public String checkgoodbad(String member_id,int list_n);			//좋아요싫어요 중복 체크
	
	//댓글
	public ArrayList<HoneyBean> getComment(int list_n);					//댓글 불러오기
	public void addComment(HoneyBean comment);							//댓글 입력
	public void updateComment(HoneyBean comment);						//댓글 수정
	public void deleteComment(int comment_n);							//댓글 삭제

	
	
			  
}