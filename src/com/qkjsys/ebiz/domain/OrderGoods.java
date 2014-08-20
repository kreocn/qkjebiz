package com.qkjsys.ebiz.domain;

import java.util.Date;

public class OrderGoods {
	private Integer uuid;// (int)
	private String order_id;// (varchar)
	private Integer goods_id;// (int)
	private Double per_price;// (decimal)单价
	private Integer order_num;// (int)订单数量
	private Double total_price;// (decimal)实际价格
	private Double storage_fees;// 保管费custody
	private Date storage_date;// 保管终止期限

	// 以下为非数据库字段
	private String order_user;
	private String goods_name;
	private Integer goods_type;
	private Integer goods_class;
	private String goods_type_name;
	private String goods_class_name;
	private String goods_unit;

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

	public String getGoods_unit() {
		return goods_unit;
	}

	public void setGoods_unit(String goods_unit) {
		this.goods_unit = goods_unit;
	}

	public String getOrder_user() {
		return order_user;
	}

	public void setOrder_user(String order_user) {
		this.order_user = order_user;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public Integer getGoods_type() {
		return goods_type;
	}

	public void setGoods_type(Integer goods_type) {
		this.goods_type = goods_type;
	}

	public Integer getGoods_class() {
		return goods_class;
	}

	public void setGoods_class(Integer goods_class) {
		this.goods_class = goods_class;
	}

	public String getGoods_type_name() {
		return goods_type_name;
	}

	public void setGoods_type_name(String goods_type_name) {
		this.goods_type_name = goods_type_name;
	}

	public String getGoods_class_name() {
		return goods_class_name;
	}

	public void setGoods_class_name(String goods_class_name) {
		this.goods_class_name = goods_class_name;
	}

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

}
