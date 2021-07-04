package com.qkj.sche.domain;

public class Scheduser {
	private Integer uuid;// id
	private String p_uuid;//发布者id
	private String r_uuid;//接收者id
	private Integer infor_uuid;// 信息
	
	
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}
	
	public String getP_uuid() {
		return p_uuid;
	}
	public void setP_uuid(String p_uuid) {
		this.p_uuid = p_uuid;
	}
	public String getR_uuid() {
		return r_uuid;
	}
	public void setR_uuid(String r_uuid) {
		this.r_uuid = r_uuid;
	}
	public Integer getInfor_uuid() {
		return infor_uuid;
	}
	public void setInfor_uuid(Integer infor_uuid) {
		this.infor_uuid = infor_uuid;
	}
	
	
}
