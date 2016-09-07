package com.qkj.manage.domain;

import java.util.Date;

public class EntertainProduct {
	private Integer uuid;// (int)主键ID
	private String enter_id;// (varchar)申请单ID
	private Integer product_id;// (int)产品ID
	private Double per_price;// (decimal)单价
	private Integer num;// (int)数量
	private Double total_price;// (decimal)总价
	private String remark;
	private String product_name;
	private Integer case_spec; 
	
	private Integer proNum;
	private String apply_dept_name;
	private String apply_user_name;
	private Date apply_date;// (varchar)主题
	private Integer euuid;// (int)主键ID
	private Integer estate;
	
	public Integer getEstate() {
		return estate;
	}

	public void setEstate(Integer estate) {
		this.estate = estate;
	}

	public String getApply_user_name() {
		return apply_user_name;
	}

	public void setApply_user_name(String apply_user_name) {
		this.apply_user_name = apply_user_name;
	}

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}

	public Integer getEuuid() {
		return euuid;
	}

	public void setEuuid(Integer euuid) {
		this.euuid = euuid;
	}

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

	public Integer getProNum() {
		return proNum;
	}

	public void setProNum(Integer proNum) {
		this.proNum = proNum;
	}

	public Integer getCase_spec() {
		return case_spec;
	}

	public void setCase_spec(Integer case_spec) {
		this.case_spec = case_spec;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getEnter_id() {
		return enter_id;
	}

	public void setEnter_id(String enter_id) {
		this.enter_id = enter_id;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Double getPer_price() {
		return per_price;
	}

	public void setPer_price(Double per_price) {
		this.per_price = per_price;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

}
