package com.qkj.manage.domain;

public class EntertMember {
	private Integer uuid;// (int)主键ID
	private String enter_id;// (varchar)活动申请ID
	private String member_id;// (varchar)会员号
	private String title;// (varchar)名目
	private String note;// (varchar)说明(数量,金额等)
	private Double total_price;// (decimal)金额
	private String member_mobile;
	private String member_address;
	// 非数据库字段
	private String member_name;
	
	private Integer member_with_score;

	
	public String getEnter_id() {
		return enter_id;
	}

	public void setEnter_id(String enter_id) {
		this.enter_id = enter_id;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

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


}
