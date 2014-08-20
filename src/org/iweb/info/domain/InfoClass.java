package org.iweb.info.domain;

import java.util.Date;

public class InfoClass {
	private String uuid;
	private String title;
	private String title2;
	private String parent_id;
	private String class_template_id;
	private String info_template_id;
	private String info_html_dir;
	private String lm_user;
	private Date lm_time;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle2() {
		return title2;
	}

	public void setTitle2(String title2) {
		this.title2 = title2;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	public String getClass_template_id() {
		return class_template_id;
	}

	public void setClass_template_id(String class_template_id) {
		this.class_template_id = class_template_id;
	}

	public String getInfo_template_id() {
		return info_template_id;
	}

	public void setInfo_template_id(String info_template_id) {
		this.info_template_id = info_template_id;
	}

	public String getInfo_html_dir() {
		return info_html_dir;
	}

	public void setInfo_html_dir(String info_html_dir) {
		this.info_html_dir = info_html_dir;
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
}
