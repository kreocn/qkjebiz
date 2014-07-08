package com.qkjsys.ebiz.domain;

import java.util.Date;

public class OrderActn {
	private Integer uuid;// (int)主键ID
	private String order_id;// (varchar)订单编号
	private Integer goods_id;// (int)订单商品号
	private String action_type;// (varchar)操作类型
	private String original_value;// (varchar)旧值
	private String new_value;// (varchar)新值
	private String note;// (varchar)备注
	private String add_ip;// (varchar)操作人IP
	private String add_user;// (varchar)操作人
	private Date add_time;// (datetime)操作时间

	// 以下为非数据库字段
	private String add_user_name;
	private String goods_name;

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
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

	public String getAction_type() {
		return action_type;
	}

	public void setAction_type(String action_type) {
		this.action_type = action_type;
	}

	public String getOriginal_value() {
		return original_value;
	}

	public void setOriginal_value(String original_value) {
		this.original_value = original_value;
	}

	public String getNew_value() {
		return new_value;
	}

	public void setNew_value(String new_value) {
		this.new_value = new_value;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getAdd_ip() {
		return add_ip;
	}

	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public final static String ADD_ORDER = "ADD_ORDER";
	public final static String MDY_ORDER = "MDY_ORDER";
	public final static String CHANGE_STATUS = "CHANGE_STATUS";
	public final static String CHANGE_PAYSTATUS = "CHANGE_PAYSTATUS";
	public final static String DEL_ORDER = "DEL_ORDER";
	public final static String ADD_ORDERGOODS = "ADD_ORDERGOODS";
	public final static String MDY_ORDERGOODS = "MDY_ORDERGOODS";
	public final static String DEL_ORDERGOODS = "MDY_ORDERGOODS";

}
