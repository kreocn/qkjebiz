package com.qkj.ware.domain;

import java.util.Date;


public class Check {
	private Integer uuid;// (int)
	private Integer stock_id;
	private Integer product_id;// (int)商品名称
	private Integer store_id;// (int)所在仓库
	private Date date;
	private Integer quantity;// (int)库存数量
	private Integer num;// (int)盘点实际数量
	private Integer zdnum;
	private Integer znum;
	private Integer snum;
	private Integer qnum;
	private Integer jnum;
	
	//数据库以外
	private String product_name;
	private String ware_name;
	private String state;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getStore_id() {
		return store_id;
	}

	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getStock_id() {
		return stock_id;
	}

	public void setStock_id(Integer stock_id) {
		this.stock_id = stock_id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getZdnum() {
		return zdnum;
	}

	public void setZdnum(Integer zdnum) {
		this.zdnum = zdnum;
	}

	public Integer getZnum() {
		return znum;
	}

	public void setZnum(Integer znum) {
		this.znum = znum;
	}

	public Integer getSnum() {
		return snum;
	}

	public void setSnum(Integer snum) {
		this.snum = snum;
	}

	public Integer getQnum() {
		return qnum;
	}

	public void setQnum(Integer qnum) {
		this.qnum = qnum;
	}

	public Integer getJnum() {
		return jnum;
	}

	public void setJnum(Integer jnum) {
		this.jnum = jnum;
	}
	
	

}
