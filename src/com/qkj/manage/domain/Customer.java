package com.qkj.manage.domain;

import java.util.Date;

public class Customer {
	private Integer uuid;// (int)客户编号
	private String dept_code;// (varchar)所属部门
	private Integer stage;// (int)所属阶段
	private String failed_reason;// (varchar)未成交原因
	private Integer source;// (int)客户来源
	private String cus_name;// (varchar)客户名称
	private String phone;// (varchar)联系电话
	private String email;// (varchar)电子邮箱
	private String sale_province;// (varchar)经销区域-省
	private String sale_city;// (varchar)经销区域-市/区
	private String sale_area;// (varchar)经销区域-县
	private String m_province;// (varchar)邮寄地址-省/直辖市
	private String m_city;// (varchar)邮寄地址-市/区
	private String m_area;// (varchar)邮寄地址-县
	private String m_post;// (varchar)邮寄地址-邮编
	private String m_street;// (varchar)邮寄地址-街道地址
	private String trade;// (varchar)所属行业
	private String mind;// (varchar)经营思路
	private String financial;// (varchar)资金实力
	private String distribution;// (varchar)销售网络
	private String remark;// (text)备注
	private Date add_time;// (datetime)添加时间
	private String add_user;// (varchar)添加人
	private Date lm_time;// (datetime)修改时间
	private String lm_user;// (varchar)修改人
	private String i_product;// (varchar)感兴趣的产品
	private String first_pay;// (varchar)客户能承受的首单量
	private String n_product;// (varchar)客户需要的产品
	private String doubt;// (varchar)客户的疑虑
	private String qa;// (text)客户的问题和解答
	private String manager;// (varchar)管理者
	private String con_name;// (varchar)联系人
	private String qq;// (varchar)联系QQ
	private String fax;// (varchar)传真
	private String mobile;// (varchar)手机
	private Date contract_end;// (date)合同截止期(已成交才有)
	private Double rating;// (decimal)深度了解星级
	private String cus_back;// (text)客户背景概述
	private String cus_now;// (text)客户现状概述
	private Double ware_square;// (decimal)仓库面积
	private Integer ware_type;// (int)仓储归属 1租赁 2自有
	private Integer vehicle_num;// (int)配送车辆
	private Integer in_wholesaler;// (int)自有批发商
	private Integer in_shop;// (int)自有直供店
	private Integer out_wholesaler;// (int)二级批发商
	private Integer out_shop;// (int)下级直供店
	private Integer sale_type;// (int)市场类型 0:省会 1市级 2县级

	private String dept_name;
	private String add_user_name;
	private Integer recode_count; // 当前客户的回访次数
	private String is_sub_dept;

	//
	private String[] distributions;
	private String[] failed_reasons;
	private String is_recode;

	public Integer getRecode_count() {
		return recode_count;
	}

	public void setRecode_count(Integer recode_count) {
		this.recode_count = recode_count;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String[] getFailed_reasons() {
		return failed_reasons;
	}

	public void setFailed_reasons(String[] failed_reasons) {
		this.failed_reasons = failed_reasons;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}

	public String[] getDistributions() {
		return distributions;
	}

	public void setDistributions(String[] distributions) {
		this.distributions = distributions;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public Integer getStage() {
		return stage;
	}

	public void setStage(Integer stage) {
		this.stage = stage;
	}

	public String getFailed_reason() {
		return failed_reason;
	}

	public void setFailed_reason(String failed_reason) {
		this.failed_reason = failed_reason;
	}

	public Integer getSource() {
		return source;
	}

	public void setSource(Integer source) {
		this.source = source;
	}

	public String getCus_name() {
		return cus_name;
	}

	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSale_province() {
		return sale_province;
	}

	public void setSale_province(String sale_province) {
		this.sale_province = sale_province;
	}

	public String getSale_city() {
		return sale_city;
	}

	public void setSale_city(String sale_city) {
		this.sale_city = sale_city;
	}

	public String getSale_area() {
		return sale_area;
	}

	public void setSale_area(String sale_area) {
		this.sale_area = sale_area;
	}

	public String getM_province() {
		return m_province;
	}

	public void setM_province(String m_province) {
		this.m_province = m_province;
	}

	public String getM_city() {
		return m_city;
	}

	public void setM_city(String m_city) {
		this.m_city = m_city;
	}

	public String getM_area() {
		return m_area;
	}

	public void setM_area(String m_area) {
		this.m_area = m_area;
	}

	public String getM_post() {
		return m_post;
	}

	public void setM_post(String m_post) {
		this.m_post = m_post;
	}

	public String getM_street() {
		return m_street;
	}

	public void setM_street(String m_street) {
		this.m_street = m_street;
	}

	public String getTrade() {
		return trade;
	}

	public void setTrade(String trade) {
		this.trade = trade;
	}

	public String getMind() {
		return mind;
	}

	public void setMind(String mind) {
		this.mind = mind;
	}

	public String getFinancial() {
		return financial;
	}

	public void setFinancial(String financial) {
		this.financial = financial;
	}

	public String getDistribution() {
		return distribution;
	}

	public void setDistribution(String distribution) {
		this.distribution = distribution;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getI_product() {
		return i_product;
	}

	public void setI_product(String i_product) {
		this.i_product = i_product;
	}

	public String getFirst_pay() {
		return first_pay;
	}

	public void setFirst_pay(String first_pay) {
		this.first_pay = first_pay;
	}

	public String getN_product() {
		return n_product;
	}

	public void setN_product(String n_product) {
		this.n_product = n_product;
	}

	public String getDoubt() {
		return doubt;
	}

	public void setDoubt(String doubt) {
		this.doubt = doubt;
	}

	public String getQa() {
		return qa;
	}

	public void setQa(String qa) {
		this.qa = qa;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getCon_name() {
		return con_name;
	}

	public void setCon_name(String con_name) {
		this.con_name = con_name;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Date getContract_end() {
		return contract_end;
	}

	public void setContract_end(Date contract_end) {
		this.contract_end = contract_end;
	}

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public String getCus_back() {
		return cus_back;
	}

	public void setCus_back(String cus_back) {
		this.cus_back = cus_back;
	}

	public String getCus_now() {
		return cus_now;
	}

	public void setCus_now(String cus_now) {
		this.cus_now = cus_now;
	}

	public Double getWare_square() {
		return ware_square;
	}

	public void setWare_square(Double ware_square) {
		this.ware_square = ware_square;
	}

	public Integer getWare_type() {
		return ware_type;
	}

	public void setWare_type(Integer ware_type) {
		this.ware_type = ware_type;
	}

	public Integer getVehicle_num() {
		return vehicle_num;
	}

	public void setVehicle_num(Integer vehicle_num) {
		this.vehicle_num = vehicle_num;
	}

	public Integer getIn_wholesaler() {
		return in_wholesaler;
	}

	public void setIn_wholesaler(Integer in_wholesaler) {
		this.in_wholesaler = in_wholesaler;
	}

	public Integer getIn_shop() {
		return in_shop;
	}

	public void setIn_shop(Integer in_shop) {
		this.in_shop = in_shop;
	}

	public Integer getOut_wholesaler() {
		return out_wholesaler;
	}

	public void setOut_wholesaler(Integer out_wholesaler) {
		this.out_wholesaler = out_wholesaler;
	}

	public Integer getOut_shop() {
		return out_shop;
	}

	public void setOut_shop(Integer out_shop) {
		this.out_shop = out_shop;
	}

	public Integer getSale_type() {
		return sale_type;
	}

	public void setSale_type(Integer sale_type) {
		this.sale_type = sale_type;
	}

	public String getIs_recode() {
		return is_recode;
	}

	public void setIs_recode(String is_recode) {
		this.is_recode = is_recode;
	}
	
}
