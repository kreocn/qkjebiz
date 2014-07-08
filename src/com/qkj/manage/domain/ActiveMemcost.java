package com.qkj.manage.domain;

public class ActiveMemcost {
	private Integer uuid;// (int)主键ID
	private String active_id;// (varchar)活动申请ID
	private String member_id;// (varchar)会员号
	private String title;// (varchar)名目
	private String note;// (varchar)说明(数量,金额等)
	private Double total_price;// (decimal)金额
	private Integer with_score;// (int)使用随量积分
	private Integer status;// (int)状态 1 申请列表 2结案列表

	// 非数据库字段
	private String member_name;
	private String member_mobile;
	private Integer member_with_score;

	public Integer getMember_with_score() {
		return member_with_score;
	}

	public void setMember_with_score(Integer member_with_score) {
		this.member_with_score = member_with_score;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_mobile() {
		return member_mobile;
	}

	public void setMember_mobile(String member_mobile) {
		this.member_mobile = member_mobile;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getActive_id() {
		return active_id;
	}

	public void setActive_id(String active_id) {
		this.active_id = active_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

	public Integer getWith_score() {
		return with_score;
	}

	public void setWith_score(Integer with_score) {
		this.with_score = with_score;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
