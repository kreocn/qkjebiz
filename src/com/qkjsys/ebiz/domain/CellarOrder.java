package com.qkjsys.ebiz.domain;

import java.util.Date;

public class CellarOrder {
	private String uuid;// (varchar)取酒订单号
	private Integer member_cellar_id;// (int)取酒位置 qkj_r_order_cellar.uuid
	/**
	 * @Deprecated replace by member_cellar_id
	 */
	@Deprecated
	private Integer order_cellar;// (int)取酒位置 qkj_r_order_cellar.uuid
	private Double order_num;// (decimal)
	private String con_name;// (varchar)收货人姓名
	private String con_province;// (varchar)省/直辖市
	private String con_city;// (varchar)市/区
	private String con_area;// (varchar)县
	private String con_post;// (varchar)邮编
	private String con_street;// (text)街道地址
	private String con_mobile;// (varchar)手机/联系电话
	private String con_note;// (text)客户备注
	private Integer express_type;// (int)配送方式
	private String express_no;// (varchar)快递单号
	private String order_video;// (varchar)视频地址
	private String order_video_pass;// 视频提取密码
	private Integer order_source;// (int)订单来源 0客户自助下单 1代客下单
	private Integer status;// (int)订单状态 0 作废订单 10 新订单 20 已灌装 30 已发货 40 已收货 50 已评价
	private String add_user;// (varchar)
	private Date add_time;// (datetime)
	private String lm_user;// (varchar)
	private Date lm_time;// (datetime)

	// 以下为非数据库字段
	private String add_user_name;
	private String lm_user_name;
	private String cellar_unit;
	private Integer ware_id;
	private String cellar_no;
	private String cellar_position;

	public String getCellar_position() {
		return cellar_position;
	}

	public void setCellar_position(String cellar_position) {
		this.cellar_position = cellar_position;
	}

	public Integer getMember_cellar_id() {
		return member_cellar_id;
	}

	public void setMember_cellar_id(Integer member_cellar_id) {
		this.member_cellar_id = member_cellar_id;
	}

	public Integer getWare_id() {
		return ware_id;
	}

	public void setWare_id(Integer ware_id) {
		this.ware_id = ware_id;
	}

	public String getCellar_no() {
		return cellar_no;
	}

	public void setCellar_no(String cellar_no) {
		this.cellar_no = cellar_no;
	}

	public String getCellar_unit() {
		return cellar_unit;
	}

	public void setCellar_unit(String cellar_unit) {
		this.cellar_unit = cellar_unit;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

	public String getOrder_video_pass() {
		return order_video_pass;
	}

	public void setOrder_video_pass(String order_video_pass) {
		this.order_video_pass = order_video_pass;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Integer getOrder_cellar() {
		return order_cellar;
	}

	public void setOrder_cellar(Integer order_cellar) {
		this.order_cellar = order_cellar;
	}

	public Double getOrder_num() {
		return order_num;
	}

	public void setOrder_num(Double order_num) {
		this.order_num = order_num;
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

	public String getOrder_video() {
		return order_video;
	}

	public void setOrder_video(String order_video) {
		this.order_video = order_video;
	}

	public Integer getOrder_source() {
		return order_source;
	}

	public void setOrder_source(Integer order_source) {
		this.order_source = order_source;
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
