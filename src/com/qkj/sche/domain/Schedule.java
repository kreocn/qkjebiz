package com.qkj.sche.domain;

import java.util.Date;


public class Schedule {
	private Integer uuid;// (int)
	private Integer guuid;
	private String title;// 标题
	private String content;// 内容
	private String sdate;// 日期
	private String type;//信息类型0:部门手册1:公司制度和章程2:公司文件3：更新公告
	private String r_uuid;//接收人
	private String puuid;
	private String r_name;
	private String p_name;
	private String usename;
	private String user_name;
	
	private String lm_user;
	private Date lm_time;
	
	private String flag;//是否已读
	private String r_dept;
	private String lm_user_name;
	
	
	public String getLm_user_name() {
		return lm_user_name;
	}
	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}
	public String getLm_user() {
		return lm_user;
	}
	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}
	
	public Date getLm_time() {
		return lm_time;
	}
	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getUsename() {
		return usename;
	}
	public void setUsename(String usename) {
		this.usename = usename;
	}
	public Integer getGuuid() {
		return guuid;
	}
	public void setGuuid(Integer guuid) {
		this.guuid = guuid;
	}
	public String getR_dept() {
		return r_dept;
	}
	public void setR_dept(String r_dept) {
		this.r_dept = r_dept;
	}
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPuuid() {
		return puuid;
	}
	public void setPuuid(String puuid) {
		this.puuid = puuid;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
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
	public String getR_uuid() {
		return r_uuid;
	}
	public void setR_uuid(String r_uuid) {
		this.r_uuid = r_uuid;
	}
	
	

}
