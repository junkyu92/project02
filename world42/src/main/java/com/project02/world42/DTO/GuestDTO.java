package com.project02.world42.DTO;

public class GuestDTO {
	private int no;
	private String writer;
	private String content;
	private String gdate;
	private String comments;
	private String redate;
	private String owner;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getGdate() {
		return gdate;
	}
	public void setGdate(String gdate) {
		this.gdate = gdate;
	}
	public String getcomments() {
		return comments;
	}
	public void setcomments(String comments) {
		this.comments = comments;
	}
	public String getRedate() {
		return redate;
	}
	public void setRedate(String redate) {
		this.redate = redate;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	@Override
	public String toString() {
		return "GuestDTO [no=" + no + ", writer=" + writer + ", content=" + content + ", gdate=" + gdate + ", comments="
				+ comments + ", redate=" + redate + ", owner=" + owner + "]";
	}
	
	
	
}         
