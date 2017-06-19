package com.qkj.ware.domain;

import java.util.*;

public class OutDetail {
	private Integer uuid;// (int)
	private Integer lading_id;// (varchar)
	private Integer product_id;// (int)
	private Double num;// (int)
	private Double price;// (decimal)
	private Double totel;// (int)

	// 以下为非数据库字段
	private String product_name;
	private Integer case_spec;
	private String flag;
	private String ordernum;
	private Integer goldUuid;
	private Integer goreason;
	private String spec;
	private String ware_name;
	private Integer store_id;
	private String remark;
	private Date datea;
	
	private Date out_time_start;
	private Date out_time_end;

	
	public Date getOut_time_start() {
		return out_time_start;
	}

	public void setOut_time_start(Date out_time_start) {
		this.out_time_start = out_time_start;
	}

	public Date getOut_time_end() {
		return out_time_end;
	}

	public void setOut_time_end(Date out_time_end) {
		this.out_time_end = out_time_end;
	}

	public Date getDatea() {
		return datea;
	}

	public void setDatea(Date datea) {
		this.datea = datea;
	}

	public Integer getStore_id() {
		return store_id;
	}

	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public Integer getGoldUuid() {
		return goldUuid;
	}

	public void setGoldUuid(Integer goldUuid) {
		this.goldUuid = goldUuid;
	}

	public Integer getGoreason() {
		return goreason;
	}

	public void setGoreason(Integer goreason) {
		this.goreason = goreason;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
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

	

	public Double getNum() {
		return num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getTotel() {
		return totel;
	}

	public void setTotel(Double totel) {
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
