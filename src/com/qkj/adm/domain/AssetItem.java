package com.qkj.adm.domain;

import java.util.Date;

public class AssetItem {
	private String uuid;// (varchar)编号
	private Integer asset_id;// (int)所属资产
	private String model;// (varchar)型号
	private String spec;// (varchar)规格
	private Double price;// 单价
	private String position;// (varchar)所在位置
	private Integer is_use;// (int)是否已领用
	private String own_user;// (varchar)所属人
	private Date use_time;// (datetime)领用时间
	private String op_user;// (varchar)执行人
	private Date op_time;// (datetime)执行时间
	private String add_user;// (varchar)添加人
	private Date add_time;// (datetime)添加时间
	private String lm_user;// (varchar)修改人
	private Date lm_time;// (timestamp)修改时间

	// 非数据库字段
	private String own_user_name;
	private String nuuid;
	private String atype;
	private String btype;
	private String ctype;
	private String tname;
	private String stype;
	private String norms;
	private String adresss;
	private String allpeo;
	private String company;
	private Date lm_time_item;

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getOwn_user_name() {
		return own_user_name;
	}

	public void setOwn_user_name(String own_user_name) {
		this.own_user_name = own_user_name;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Integer getAsset_id() {
		return asset_id;
	}

	public void setAsset_id(Integer asset_id) {
		this.asset_id = asset_id;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getIs_use() {
		return is_use;
	}

	public void setIs_use(Integer is_use) {
		this.is_use = is_use;
	}

	public String getOwn_user() {
		return own_user;
	}

	public void setOwn_user(String own_user) {
		this.own_user = own_user;
	}

	public Date getUse_time() {
		return use_time;
	}

	public void setUse_time(Date use_time) {
		this.use_time = use_time;
	}

	public String getOp_user() {
		return op_user;
	}

	public void setOp_user(String op_user) {
		this.op_user = op_user;
	}

	public Date getOp_time() {
		return op_time;
	}

	public void setOp_time(Date op_time) {
		this.op_time = op_time;
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

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getAtype() {
		return atype;
	}

	public void setAtype(String atype) {
		this.atype = atype;
	}

	public String getBtype() {
		return btype;
	}

	public void setBtype(String btype) {
		this.btype = btype;
	}

	public String getCtype() {
		return ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getStype() {
		return stype;
	}

	public void setStype(String stype) {
		this.stype = stype;
	}

	public String getNorms() {
		return norms;
	}

	public void setNorms(String norms) {
		this.norms = norms;
	}

	public String getAdresss() {
		return adresss;
	}

	public void setAdresss(String adresss) {
		this.adresss = adresss;
	}

	public String getAllpeo() {
		return allpeo;
	}

	public void setAllpeo(String allpeo) {
		this.allpeo = allpeo;
	}

	public String getNuuid() {
		return nuuid;
	}

	public void setNuuid(String nuuid) {
		this.nuuid = nuuid;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public Date getLm_time_item() {
		return lm_time_item;
	}

	public void setLm_time_item(Date lm_time_item) {
		this.lm_time_item = lm_time_item;
	}

	

}
