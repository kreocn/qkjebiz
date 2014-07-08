package com.qkjsys.ebiz.domain;

import java.util.Date;

public class Order {
	private String uuid;// (varchar)订单号,采用日期+序号的方式
	private Integer order_type;// (int)订单类型 0 正常 1团购 等等
	private String user_id;// (varchar)购货人
	private Double total_price;// (double)订单总价(修改商品信息时重新计算,不能修改)
	private Integer pay_type;// (int)支付方式 0 余额支付 1 网上银行支付 2 货到付款 3 银行打款 4 当面收取 5 积分付款
	private Integer pay_status;// (int)付款状态 0 未支付 1 已支付
	private Date pay_time;// (datetime)支付时间
	private Integer express_type;// (int)配送方式
	private String express_no;// (varchar)快递单号
	private Date ship_time;// (datetime)成交时间
	private Integer order_source;// (int)订单来源 0本站 1代客下单 2淘宝
	private String note;// (text)备注
	private String con_name;// (varchar)收货人姓名
	private String con_province;// (varchar)省/直辖市
	private String con_city;// (varchar)市/区
	private String con_area;// (varchar)县
	private String con_post;// (varchar)邮编
	private String con_street;// (varchar)街道地址
	private String con_mobile;// (varchar)手机/联系电话
	private String con_note;// (text)客户备注
	private Integer invoice_status;// (int)开票状态 0 未开票 1 已开票
	private Integer invoice_type;// (int)0普通发票 1专业发票 2增值税专用发票
	private String invoice_head;// (varchar)发票抬头
	private String invoice_details;// (varchar)发票内容
	private Integer status;// (int)订单状态 0 作废订单 10 新订单 20 已受理 30 已审核 40 已发货 50 已送达 60 交易不成功 70 交易成功 80 已评价
	private String add_user;// (varchar)
	private Date add_time;// (datetime)
	private String lm_user;// (varchar)
	private Date lm_time;// (datetime)

	// 以下为非数据库字段
	private String user_name;
	private String user_mobile;
	private String add_user_name;

	private String dept_code;
	private String dept_name;
	private String manager;
	private String manager_name;

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getManager_name() {
		return manager_name;
	}

	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_mobile() {
		return user_mobile;
	}

	public void setUser_mobile(String user_mobile) {
		this.user_mobile = user_mobile;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Integer getOrder_type() {
		return order_type;
	}

	public void setOrder_type(Integer order_type) {
		this.order_type = order_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

	public Integer getPay_type() {
		return pay_type;
	}

	public void setPay_type(Integer pay_type) {
		this.pay_type = pay_type;
	}

	public Integer getPay_status() {
		return pay_status;
	}

	public void setPay_status(Integer pay_status) {
		this.pay_status = pay_status;
	}

	public Date getPay_time() {
		return pay_time;
	}

	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}

	public Integer getExpress_type() {
		return express_type;
	}

	public void setExpress_type(Integer express_type) {
		this.express_type = express_type;
	}

	public String getExpress_no() {
		return express_no;
	}

	public void setExpress_no(String express_no) {
		this.express_no = express_no;
	}

	public Date getShip_time() {
		return ship_time;
	}

	public void setShip_time(Date ship_time) {
		this.ship_time = ship_time;
	}

	public Integer getOrder_source() {
		return order_source;
	}

	public void setOrder_source(Integer order_source) {
		this.order_source = order_source;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCon_name() {
		return con_name;
	}

	public void setCon_name(String con_name) {
		this.con_name = con_name;
	}

	public String getCon_province() {
		return con_province;
	}

	public void setCon_province(String con_province) {
		this.con_province = con_province;
	}

	public String getCon_city() {
		return con_city;
	}

	public void setCon_city(String con_city) {
		this.con_city = con_city;
	}

	public String getCon_area() {
		return con_area;
	}

	public void setCon_area(String con_area) {
		this.con_area = con_area;
	}

	public String getCon_post() {
		return con_post;
	}

	public void setCon_post(String con_post) {
		this.con_post = con_post;
	}

	public String getCon_street() {
		return con_street;
	}

	public void setCon_street(String con_street) {
		this.con_street = con_street;
	}

	public String getCon_mobile() {
		return con_mobile;
	}

	public void setCon_mobile(String con_mobile) {
		this.con_mobile = con_mobile;
	}

	public String getCon_note() {
		return con_note;
	}

	public void setCon_note(String con_note) {
		this.con_note = con_note;
	}

	public Integer getInvoice_status() {
		return invoice_status;
	}

	public void setInvoice_status(Integer invoice_status) {
		this.invoice_status = invoice_status;
	}

	public Integer getInvoice_type() {
		return invoice_type;
	}

	public void setInvoice_type(Integer invoice_type) {
		this.invoice_type = invoice_type;
	}

	public String getInvoice_head() {
		return invoice_head;
	}

	public void setInvoice_head(String invoice_head) {
		this.invoice_head = invoice_head;
	}

	public String getInvoice_details() {
		return invoice_details;
	}

	public void setInvoice_details(String invoice_details) {
		this.invoice_details = invoice_details;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

}
