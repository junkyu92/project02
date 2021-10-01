package com.project02.world42.DTO;

public class UsersDTO {
	private String memid; // 아이디
	private String mempw; // 비밀번호
	private String mname; // 이름
	private String mbday; // 생년월일
	private String tel; // 전화번호
	private String m1chon; // 일촌 목록
	private String macorn; // 소지 도토리
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getMempw() {
		return mempw;
	}
	public void setMempw(String mempw) {
		this.mempw = mempw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMbday() {
		return mbday;
	}
	public void setMbday(String mbday) {
		this.mbday = mbday;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getM1chon() {
		return m1chon;
	}
	public void setM1chon(String m1chon) {
		this.m1chon = m1chon;
	}
	public String getMacorn() {
		return macorn;
	}
	public void setMacorn(String macorn) {
		this.macorn = macorn;
	}
	@Override
	public String toString() {
		return "UsersDTO [memid=" + memid + ", mempw=" + mempw + ", mname=" + mname + ", mbday=" + mbday + ", tel="
				+ tel + ", m1chon=" + m1chon + ", macorn=" + macorn + "]";
	}
	
	
}
