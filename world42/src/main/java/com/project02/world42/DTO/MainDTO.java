package com.project02.world42.DTO;

public class MainDTO {

	private int mIdx;
	private String memid;
	private String sessionId;
	private String mTitle;
	private String mImg;
	private String mPro;
	private int mToday;
	private int mTotal;
	private String mName;
	private String mBday;
	private String m1chon;
	private byte if1chon;
	private int m1chonSize;
	private int macorn;
	private String bgm_list;
	private int bgmSize;
	
	
	
	public int getmIdx() {
		return mIdx;
	}
	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getmTitle() {
		return mTitle;
	}
	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}
	public String getmImg() {
		return mImg;
	}
	public void setmImg(String mImg) {
		this.mImg = mImg;
	}
	public String getmPro() {
		return mPro;
	}
	public void setmPro(String mPro) {
		this.mPro = mPro;
	}
	public int getmToday() {
		return mToday;
	}
	public void setmToday(int mToday) {
		this.mToday = mToday;
	}
	public int getmTotal() {
		return mTotal;
	}
	public void setmTotal(int mTotal) {
		this.mTotal = mTotal;
	}
	public String getM1chon() {
		return m1chon;
	}
	public void setM1chon(String m1chon) {
		this.m1chon = m1chon;
		this.m1chonSize = m1chon.split(",").length;
	}
	public byte isIf1chon() {
		return if1chon;
	}
	public void setIf1chon(byte if1chon) {
		this.if1chon = if1chon;
	}
	public int getM1chonSize() {
		return m1chonSize;
	}
	public int getMacorn() {
		return macorn;
	}
	public void setMacorn(int macorn) {
		this.macorn = macorn;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getmBday() {
		return mBday;
	}
	public void setmBday(String mBday) {
		this.mBday = mBday;
	}
	// 09.25 추가
		public String getBgm_list() {
			return bgm_list;
		}
		public void setBgm_list(String bgm_list) {
			this.bgm_list = bgm_list;
			this.bgmSize = bgm_list.split(",").length;
		}
		public int getBgmSize() {
			return bgmSize;
		}
}
