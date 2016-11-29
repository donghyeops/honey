package honey;

import java.util.ArrayList;

public class HoneyBean {
	//계정
	private int member_n;//멤버 번호
	private String member_id;//멤버 아이디
	private String member_pwd;
	private String member_name;
	private String member_mail;
	
	//꿀집
	private int hc_id;//꿀집 아이디 - 각 꿀집의 번호
	private String hc_pwd;//꿀집 비밀번호- 꿀집 작성시 쓰는 비번 로그인시 멤버 비밀번호로 작성
	private String hc_title;//꿀집 제목
	//private String member_id;
	
	//비디오
	private int video_id;//각 비디오 아이디 
	private String video_url;//비디오의 태그 url
	//private int hc_id;
	
	//게시판
	private int list_n;//게시판 번호
	private String list_title;//게시판 제목
	private String list_contents;//게시판 내용
	private String list_time;//게시판 시간
	private int list_good;//달다
	private int list_bad;//쓰다
	//private int hc_id;
	////private String member_id;
	
	//댓글
	private int comment_n;				//댓글 하나하나의 번호
	private String comment_contents;	//댓글 내용
	private String comment_time;		//댓글 시간
	//list_n
	//member_id
	//댓글 표시를 위한 배열들

	
	public String getComment_time() {
		return comment_time;
	}
	public void setComment_time(String comment_time) {
		this.comment_time = comment_time;
	}
	public int getComment_n() {
		return comment_n;
	}
	public void setComment_n(int comment_n) {
		this.comment_n = comment_n;
	}
	public String getComment_contents() {
		return comment_contents;
	}
	public void setComment_contents(String comment_contents) {
		this.comment_contents = comment_contents;
	}
	
	public int getMember_n() {
		return member_n;
	}
	public void setMember_n(int member_n) {
		this.member_n = member_n;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_mail() {
		return member_mail;
	}
	public void setMember_mail(String member_mail) {
		this.member_mail = member_mail;
	}
	public int getHc_id() {
		return hc_id;
	}
	public void setHc_id(int hc_id) {
		this.hc_id = hc_id;
	}
	public String getHc_pwd() {
		return hc_pwd;
	}
	public void setHc_pwd(String hc_pwd) {
		this.hc_pwd = hc_pwd;
	}
	public String getHc_title() {
		return hc_title;
	}
	public void setHc_title(String hc_title) {
		this.hc_title = hc_title;
	}
	public int getVideo_id() {
		return video_id;
	}
	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	public String getVideo_url() {
		return video_url;
	}
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	public int getList_n() {
		return list_n;
	}
	public void setList_n(int list_n) {
		this.list_n = list_n;
	}
	public String getList_title() {
		return list_title;
	}
	public void setList_title(String list_title) {
		this.list_title = list_title;
	}
	public String getList_contents() {
		return list_contents;
	}
	public void setList_contents(String list_contents) {
		this.list_contents = list_contents;
	}
	public String getList_time() {
		return list_time;
	}
	public void setList_time(String list_time) {
		this.list_time = list_time;
	}
	public int getList_good() {
		return list_good;
	}
	public void setList_good(int list_good) {
		this.list_good = list_good;
	}
	public int getList_bad() {
		return list_bad;
	}
	public void setList_bad(int list_bad) {
		this.list_bad = list_bad;
	}
}
	


