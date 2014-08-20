package com.qkj.manage.domain;

public class TravelCustomer {
	private Integer uuid;// (int)主键自增
	private Integer travel_id;// (int)旅游单ID
	private String cus_name;// (varchar)客户姓名
	private Integer cus_sex;// (int)性别
	private String cus_company;// (varchar)单位名称
	private Integer cus_type;// (int)客户类别
	private String cus_phone;// (varchar)联系电话
	private String cus_idcard;// (varchar)身份证号
	private String note;// (varchar)备注

	// 以下为非数据库字段

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getTravel_id() {
		return travel_id;
	}

	public void setTravel_id(Integer travel_id) {
		this.travel_id = travel_id;
	}

	public String getCus_name() {
		return cus_name;
	}

	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}

	public Integer getCus_sex() {
		return cus_sex;
	}

	public void setCus_sex(Integer cus_sex) {
		this.cus_sex = cus_sex;
	}

	public String getCus_company() {
		return cus_company;
	}

	public void setCus_company(String cus_company) {
		this.cus_company = cus_company;
	}

	public Integer getCus_type() {
		return cus_type;
	}

	public void setCus_type(Integer cus_type) {
		this.cus_type = cus_type;
	}

	public String getCus_phone() {
		return cus_phone;
	}

	public void setCus_phone(String cus_phone) {
		this.cus_phone = cus_phone;
	}

	public String getCus_idcard() {
		return cus_idcard;
	}

	public void setCus_idcard(String cus_idcard) {
		this.cus_idcard = cus_idcard;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
