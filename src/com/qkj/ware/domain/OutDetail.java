package com.qkj.ware.domain;

import java.util.*;

public class OutDetail {
	private Integer uuid;// (int)
	private String lading_id;// (varchar)
	private Integer product_id;// (int)
	private Integer num;// (int)
	private Double price;// (decimal)
	private Integer totel;// (int)

	// 以下为非数据库字段
	private String product_name;
	private Integer case_spec;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getLading_id() {
		return lading_id;
	}

	public void setLading_id(String lading_id) {
		this.lading_id = lading_id;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getTotel() {
		return totel;
	}

	public void setTotel(Integer totel) {
		this.totel = totel;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public Integer getCase_spec() {
		return case_spec;
	}

	public void setCase_spec(Integer case_spec) {
		this.case_spec = case_spec;
	}

}
