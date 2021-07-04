package com.qkj.ware.domain;

import java.util.Date;

public class Bordetail {
	private Integer uuid;// (int)
	private Integer product_id;// (int)商品
	private Integer bstore_id;// (int)还仓库
	private Integer sstor_id;// (int)借仓库
	private Integer bnum;// (int)还货数量
	private Date bdate;// (datetime)还货时间
	private Integer back_id;// (int)还货单号
	private Integer land_id;// (int)借货单号

	// 以下为非数据库字段
	private String product_name;
	private String bware;
	private String sware;
	
	
	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getBware() {
		return bware;
	}

	public void setBware(String bware) {
		this.bware = bware;
	}

	public String getSware() {
		return sware;
	}

	public void setSware(String sware) {
		this.sware = sware;
	}

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

	public Integer getBstore_id() {
		return bstore_id;
	}

	public void setBstore_id(Integer bstore_id) {
		this.bstore_id = bstore_id;
	}

	public Integer getSstor_id() {
		return sstor_id;
	}

	public void setSstor_id(Integer sstor_id) {
		this.sstor_id = sstor_id;
	}

	public Integer getBnum() {
		return bnum;
	}

	public void setBnum(Integer bnum) {
		this.bnum = bnum;
	}

	public Date getBdate() {
		return bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}

	public Integer getBack_id() {
		return back_id;
	}

	public void setBack_id(Integer back_id) {
		this.back_id = back_id;
	}

	public Integer getLand_id() {
		return land_id;
	}

	public void setLand_id(Integer land_id) {
		this.land_id = land_id;
	}

}
