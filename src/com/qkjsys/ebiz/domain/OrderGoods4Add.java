package com.qkjsys.ebiz.domain;

import java.util.Date;

public class OrderGoods4Add {
	private Integer uuid; // order_goods_id
	private String order_id;
	private Integer goods_id;
	private Double per_price;
	private Integer order_num;
	private Double total_price;
	private Double storage_fees;
	private Date storage_date;
	private String goods_name;
	private String ware_name;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public Integer getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(Integer goods_id) {
		this.goods_id = goods_id;
	}

	public Double getPer_price() {
		return per_price;
	}

	public void setPer_price(Double per_price) {
		this.per_price = per_price;
	}

	public Integer getOrder_num() {
		return order_num;
	}

	public void setOrder_num(Integer order_num) {
		this.order_num = order_num;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

	public Double getStorage_fees() {
		return storage_fees;
	}

	public void setStorage_fees(Double storage_fees) {
		this.storage_fees = storage_fees;
	}

	public Date getStorage_date() {
		return storage_date;
	}

	public void setStorage_date(Date storage_date) {
		this.storage_date = storage_date;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}
}
