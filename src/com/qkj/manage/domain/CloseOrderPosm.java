package com.qkj.manage.domain;

public class CloseOrderPosm {
	private Integer uuid;// (int)主键ID
	private Integer closeOrder_id;// (varchar)活动申请ID
	private String title;// (varchar)名目
	private String note;// (varchar)说明(数量,金额等)
	private Double total_price;// (decimal)金额
	private Integer status;// (int)状态 1 申请列表 2结案列表

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getCloseOrder_id() {
		return closeOrder_id;
	}

	public void setCloseOrder_id(Integer closeOrder_id) {
		this.closeOrder_id = closeOrder_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

}
