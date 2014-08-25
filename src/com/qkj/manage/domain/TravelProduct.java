package com.qkj.manage.domain;

public class TravelProduct {
	private Integer uuid;// (int)主键ID
	private Integer travel_id;// (int)旅游申请ID
	private Integer product_id;// (int)产品ID
	private Integer num;// (int)数量

	// 以下为非数据库字段
	private String product_name;

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

	public Integer getTravel_id() {
		return travel_id;
	}

	public void setTravel_id(Integer travel_id) {
		this.travel_id = travel_id;
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

}
