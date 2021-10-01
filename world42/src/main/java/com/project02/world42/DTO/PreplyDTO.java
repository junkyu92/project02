package com.project02.world42.DTO;

public class PreplyDTO {
	
	private int pid;
	private int phid;
	private String mname;
	private String phcomment;
	private String memid;
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getPhid() {
		return phid;
	}
	public void setPhid(int phid) {
		this.phid = phid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getPhcomment() {
		return phcomment;
	}
	public void setPhcomment(String phcomment) {
		this.phcomment = phcomment;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	
	@Override
	public String toString() {
		return "PreplyDTO [pid=" + pid + ", phid=" + phid + ", mname=" + mname + ", phcomment=" + phcomment + ", memid="
				+ memid + "]";
	}
	
}
