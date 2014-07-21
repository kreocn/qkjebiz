package com.qkj.sche.domain;

import java.util.Date;

public class Schedule {
	private Integer ssid;// (int)
	private String title;// 标题
	private String content;// 内容
	private String sdate;// 日期
	public Integer getSsid() {
		return ssid;
	}
	public void setSsid(Integer ssid) {
		this.ssid = ssid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	
	

}
