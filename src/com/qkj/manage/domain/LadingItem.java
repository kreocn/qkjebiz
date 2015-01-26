package com.qkj.manage.domain;

public class LadingItem {
	private Integer uuid;// (int)
	private Integer lading_id;// (varchar)
	private Integer product_id;// (int)
	private Double per_price;// (decimal)
	private Integer num;// (int)
	private Double total_price;// (decimal)

	// 以下为非数据库字段
	private String product_name;
	private Integer case_spec;// (int)数量(件)

	private Double group_rebates; // 团购返利点

	public Double getGroup_rebates() {
		return group_rebates;
	}

	public void setGroup_rebates(Double group_rebates) {
		this.group_rebates = group_rebates;
	}

	public Integer getCase_spec() {
		return case_spec;
	}

	public void setCase_spec(Integer case_spec) {
		this.case_spec = case_spec;
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

	public Integer getLading_id() {
		return lading_id;
	}

	public void setLading_id(Integer lading_id) {
		this.lading_id = lading_id;
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
