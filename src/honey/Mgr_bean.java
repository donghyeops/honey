package honey;

import java.util.ArrayList;

public class Mgr_bean {
	private String member_id = null;
	
	private int hc_id = 0;	// 생성모드인지, 편집모드인지 확인하려고 0으로 초기화함. 바꾸면 안됨
	private String hc_pwd;
	private String hc_title;
	private String result = "";
	
	private ArrayList<String> URLs = new ArrayList<String>();
	
	public Mgr_bean() {}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id; 
	}
	public String getMember_id() {
		return member_id;
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
	
	public ArrayList<String> getURLs() {
		return URLs;
	}
	public void setURLs(ArrayList<String> uRLs) {
		URLs = uRLs;
	}
	public void addURL(String URL) {
		URLs.add(URL);
	}
	public void delURL(int index) {
		URLs.remove(index);
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getResult() {
		return result;
	}
}