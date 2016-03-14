package com.qkj.adm.domain;

import java.util.Date;

public class FixAssets {
	private String uuid;// (int)
	private String title;// (varchar)资产名称
	private Integer typea;
	private String model;// (varchar)参考型号
	private String spec;// (varchar)参考规格
	private Double price;// 参考单价
	private Integer num;// (int)数量
	private Double price_scope;// (decimal)总价
	private Integer company;// (int)所属公司
	private Date p_time;// (datetime)采购时间
	private Integer p_scrap;// (int)报废时限(月)
	private Date add_time;// (datetime)添加时间
	private String add_user;// (varchar)添加人
	private Date lm_time;// (timestamp)修改时间
	private String lm_user;// (varchar)修改人

	private String warrantytime;
	private String p_mobile;
	private String p_company;
	private Date use_time;
	private String own_user;
	private String position;
	private String own_userdept;

	// 非数据库字段
	private Integer residue_num;// 剩余数量
	private String type_title;// 类型名称
	private String own_user_name;

	private String own_userdept_name;
	// 查询字段
	private Integer residue_num_begin;
	private Integer residue_num_end;
	private Date p_time_start;// (datetime)采购时间
	private Date p_time_end;// (datetime)采购时间

	public String getOwn_userdept() {
		return own_userdept;
	}

	public void setOwn_userdept(String own_userdept) {
		this.own_userdept = own_userdept;
	}

	public String getOwn_userdept_name() {
		return own_userdept_name;
	}

	public void setOwn_userdept_name(String own_userdept_name) {
		this.own_userdept_name = own_userdept_name;
	}

	public String getOwn_user_name() {
		return own_user_name;
	}

	public void setOwn_user_name(String own_user_name) {
		this.own_user_name = own_user_name;
	}

	public Date getUse_time() {
		return use_time;
	}

	public void setUse_time(Date use_time) {
		this.use_time = use_time;
	}

	public String getOwn_user() {
		return own_user;
	}

	public void setOwn_user(String own_user) {
		this.own_user = own_user;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getType_title() {
		return type_title;
	}

	public void setType_title(String type_title) {
		this.type_title = type_title;
	}

	public Integer getTypea() {
		return typea;
	}

	public void setTypea(Integer typea) {
		this.typea = typea;
	}

	public Date getP_time_start() {
		return p_time_start;
	}

	public void setP_time_start(Date p_time_start) {
		this.p_time_start = p_time_start;
	}

	public Date getP_time_end() {
		return p_time_end;
	}

	public void setP_time_end(Date p_time_end) {
		this.p_time_end = p_time_end;
	}

	public Integer getResidue_num() {
		return residue_num;
	}

	public void setResidue_num(Integer residue_num) {
		this.residue_num = residue_num;
	}

	public Integer getResidue_num_begin() {
		return residue_num_begin;
	}

	public void setResidue_num_begin(Integer residue_num_begin) {
		this.residue_num_begin = residue_num_begin;
	}

	public Integer getResidue_num_end() {
		return residue_num_end;
	}

	public void setResidue_num_end(Integer residue_num_end) {
		this.residue_num_end = residue_num_end;
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

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getWarrantytime() {
		return warrantytime;
	}

	public void setWarrantytime(String warrantytime) {
		this.warrantytime = warrantytime;
	}

	public String getP_mobile() {
		return p_mobile;
	}

	public void setP_mobile(String p_mobile) {
		this.p_mobile = p_mobile;
	}

	public String getP_company() {
		return p_company;
	}

	public void setP_company(String p_company) {
		this.p_company = p_company;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getCompany() {
		return company;
	}

	public void setCompany(Integer company) {
		this.company = company;
	}

	public Date getP_time() {
		return p_time;
	}

	public void setP_time(Date p_time) {
		this.p_time = p_time;
	}

	public Integer getP_scrap() {
		return p_scrap;
	}

	public void setP_scrap(Integer p_scrap) {
		this.p_scrap = p_scrap;
	}

	public Double getPrice_scope() {
		return price_scope;
	}

	public void setPrice_scope(Double price_scope) {
		this.price_scope = price_scope;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

}
