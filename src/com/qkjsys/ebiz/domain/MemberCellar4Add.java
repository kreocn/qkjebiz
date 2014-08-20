package com.qkjsys.ebiz.domain;

import java.util.Date;

public class MemberCellar4Add implements Cloneable {
	private Integer uuid;// (int)主键ID
	private String member_id; // 所属会员
	private Double num;// (decimal)初始库存
	private Double stock;// (decimal)剩余库存
	private String cellar_position;// (varchar)藏酒位置号

	private String order_id; // 订单ID
	private Integer goods_id;// (int)商品ID
	private Integer order_goods_id;// (int)所属订单细项

	private Date storage_date;// 服务截至日期(保管时间)

	public Date getStorage_date() {
		return storage_date;
	}

	public void setStorage_date(Date storage_date) {
		this.storage_date = storage_date;
	}

	public Integer getOrder_goods_id() {
		return order_goods_id;
	}

	public void setOrder_goods_id(Integer order_goods_id) {
		this.order_goods_id = order_goods_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
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

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Double getNum() {
		return num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public Double getStock() {
		return stock;
	}

	public void setStock(Double stock) {
		this.stock = stock;
	}

	public String getCellar_position() {
		return cellar_position;
	}

	public void setCellar_position(String cellar_position) {
		this.cellar_position = cellar_position;
	}

	public MemberCellar4Add clone() {
		MemberCellar4Add o = null;
		try {
			o = (MemberCellar4Add) super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return o;
	}

}
