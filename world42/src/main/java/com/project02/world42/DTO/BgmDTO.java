package com.project02.world42.DTO;

public class BgmDTO {
	private int bgmid;
	private String bgm_title;
	private String bgm_artist;
	private String bgm_url;
	public int getBgmid() {
		return bgmid;
	}
	public void setBgmid(int bgmid) {
		this.bgmid = bgmid;
	}
	public String getBgm_title() {
		return bgm_title;
	}
	public void setBgm_title(String bgm_title) {
		this.bgm_title = bgm_title;
	}
	public String getBgm_artist() {
		return bgm_artist;
	}
	public void setBgm_artist(String bgm_artist) {
		this.bgm_artist = bgm_artist;
	}
	public String getBgm_url() {
		return bgm_url;
	}
	public void setBgm_url(String bgm_url) {
		this.bgm_url = bgm_url;
	}
	@Override
	public String toString() {
		return "BgmDTO [bgmid=" + bgmid + ", bgm_title=" + bgm_title + ", bgm_artist=" + bgm_artist + ", bgm_url="
				+ bgm_url + "]";
	}
	
}
