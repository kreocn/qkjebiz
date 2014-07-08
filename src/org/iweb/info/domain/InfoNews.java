package org.iweb.info.domain;

import java.util.Date;

public class InfoNews {
	private String uuid;
	private String class_id;
	private String title;
	private String redirect_url;
	private String keywords;
	private String shortcontent;
	private String content;
	private Integer isimgnews;
	private String smallimg;
	private String bigimg;
	private Integer counts;
	private String speciality_id;
	private Integer iscreated;
	private String file_path;
	private Integer istop;
	private Integer ischecked;
	private Integer isdel;
	private String new_source;
	private String add_user;
	private Date add_time;
	private String add_ip;
	private String lm_user;
	private Date lm_time;
	private String lm_ip;

	private String first_check_note; // 初审意见
	private String final_check_note; // 终审意见

	// 添加人的部门
	private String add_dept;
	private String add_user_name;

	// 修改人的部门
	private String lm_dept;
	private String lm_user_name;

	// 一下为非数据库字段
	private String class_name; // 新闻类别名

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRedirect_url() {
		return redirect_url;
	}

	public void setRedirect_url(String redirect_url) {
		this.redirect_url = redirect_url;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getShortcontent() {
		return shortcontent;
	}

	public void setShortcontent(String shortcontent) {
		this.shortcontent = shortcontent;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getIsimgnews() {
		return isimgnews;
	}

	public void setIsimgnews(Integer isimgnews) {
		this.isimgnews = isimgnews;
	}

	public String getSmallimg() {
		return smallimg;
	}

	public void setSmallimg(String smallimg) {
		this.smallimg = smallimg;
	}

	public String getBigimg() {
		return bigimg;
	}

	public void setBigimg(String bigimg) {
		this.bigimg = bigimg;
	}

	public Integer getCounts() {
		return counts;
	}

	public void setCounts(Integer counts) {
		this.counts = counts;
	}

	public String getSpeciality_id() {
		return speciality_id;
	}

	public void setSpeciality_id(String speciality_id) {
		this.speciality_id = speciality_id;
	}

	public Integer getIscreated() {
		return iscreated;
	}

	public void setIscreated(Integer iscreated) {
		this.iscreated = iscreated;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public Integer getIstop() {
		return istop;
	}

	public void setIstop(Integer istop) {
		this.istop = istop;
	}

	public Integer getIschecked() {
		return ischecked;
	}

	public void setIschecked(Integer ischecked) {
		this.ischecked = ischecked;
	}

	public Integer getIsdel() {
		return isdel;
	}

	public void setIsdel(Integer isdel) {
		this.isdel = isdel;
	}

	public String getNew_source() {
		return new_source;
	}

	public void setNew_source(String new_source) {
		this.new_source = new_source;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public String getAdd_ip() {
		return add_ip;
	}

	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
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

	public String getLm_ip() {
		return lm_ip;
	}

	public void setLm_ip(String lm_ip) {
		this.lm_ip = lm_ip;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getFirst_check_note() {
		return first_check_note;
	}

	public void setFirst_check_note(String first_check_note) {
		this.first_check_note = first_check_note;
	}

	public String getFinal_check_note() {
		return final_check_note;
	}

	public void setFinal_check_note(String final_check_note) {
		this.final_check_note = final_check_note;
	}

	public String getAdd_dept() {
		return add_dept;
	}

	public void setAdd_dept(String add_dept) {
		this.add_dept = add_dept;
	}

	public String getLm_dept() {
		return lm_dept;
	}

	public void setLm_dept(String lm_dept) {
		this.lm_dept = lm_dept;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

}
