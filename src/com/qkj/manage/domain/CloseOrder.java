package com.qkj.manage.domain;

import java.util.*;

public class CloseOrder {
	private Integer uuid;// (int)
	private String salPro_id;// 促销方案
	private Date close_time;// (date)结案时间
	private String content;// (text)内容
	private String theme;// (varchar)主题
	private String member_id;// (varchar)收货人
	private String member_address;// (varchar)收货地址
	private String member_phone;// (varchar)手机号
	private Double totel_price;// (decimal)商品总价格
	private String apply_dept;
	private String add_user;// (varchar)填加人
	private Date add_time;// (datetime)填加时间
	private Integer check_state;// (int)审核状态0：新单1：待审核，5：退回10：招商主管通过20：招商经理30大区40财务50总监60副总70总经理
	private Date check_time;// (datetime)审核时间
	private String check_user;// (varchar)操作人
	private Integer nd_check_state;// (int)数据中心审核状态0：未审核5：退回10：通过
	private Date nd_check_time;// (datetime)数据中心审核时间
	private String nd_check_user;// (varchar)操作人
	private Date lm_time;// (datetime)修改时间
	private String lm_user;// (varchar)修改人

	// 以下为非数据库字段
	private String member_name;
	private String lm_user_name;
	private String add_user_name;
	private String nd_check_user_name;
	private String check_user_name;
	private String is_sub_dept;
	private String apply_dept_name;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Date getClose_time() {
		return close_time;
	}

	public void setClose_time(Date close_time) {
		this.close_time = close_time;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public Double getTotel_price() {
		return totel_price;
	}

	public void setTotel_price(Double totel_price) {
		this.totel_price = totel_price;
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

	public Integer getCheck_state() {
		return check_state;
	}

	public void setCheck_state(Integer check_state) {
		this.check_state = check_state;
	}

	public Date getCheck_time() {
		return check_time;
	}

	public void setCheck_time(Date check_time) {
		this.check_time = check_time;
	}

	public String getCheck_user() {
		return check_user;
	}

	public void setCheck_user(String check_user) {
		this.check_user = check_user;
	}

	public Integer getNd_check_state() {
		return nd_check_state;
	}

	public void setNd_check_state(Integer nd_check_state) {
		this.nd_check_state = nd_check_state;
	}

	public Date getNd_check_time() {
		return nd_check_time;
	}

	public void setNd_check_time(Date nd_check_time) {
		this.nd_check_time = nd_check_time;
	}

	public String getNd_check_user() {
		return nd_check_user;
	}

	public void setNd_check_user(String nd_check_user) {
		this.nd_check_user = nd_check_user;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getSalPro_id() {
		return salPro_id;
	}

	public void setSalPro_id(String salPro_id) {
		this.salPro_id = salPro_id;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getNd_check_user_name() {
		return nd_check_user_name;
	}

	public void setNd_check_user_name(String nd_check_user_name) {
		this.nd_check_user_name = nd_check_user_name;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

}
