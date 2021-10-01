package com.project02.world42.DTO;

import java.util.Date;

public class PhotoDTO {
	
	private int phid;
	private String phcontent;
	private String phtitle;
	private String phday;
	private String phphoto;
	private String memid;
	
	public int getPhid() {
		return phid;
	}
	public void setPhid(int phid) {
		this.phid = phid;
	}
	public String getPhcontent() {
		return phcontent;
	}
	public void setPhcontent(String phcontent) {
		this.phcontent = phcontent;
	}
	public String getPhtitle() {
		return phtitle;
	}
	public void setPhtitle(String phtitle) {
		this.phtitle = phtitle;
	}
	public String getPhday() {
		return phday;
	}
	public void setPhday(String phday) {
		this.phday = phday;
	}
	public String getPhphoto() {
		return phphoto;
	}
	public void setPhphoto(String phphoto) {
		this.phphoto = phphoto;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	
	@Override
	public String toString() {
		return "PhotoDTO [phid=" + phid + ", phcontent=" + phcontent + ", phtitle=" + phtitle + ", phday=" + phday
				+ ", phphoto=" + phphoto + ", memid=" + memid + "]";
	}
	
	
	
}
