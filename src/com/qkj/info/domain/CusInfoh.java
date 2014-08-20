package com.qkj.info.domain;

import java.util.Date;

public class CusInfoh {
	private Integer uuid;// (int)系统编号
	private String linkid;// (varchar)外联主键,比如投票的联系,就是投票ID
	private String fullname;// (varchar)姓名
	private String xinlang;// (varchar)新浪微博昵称
	private String mobile;// (varchar)联系手机
	private Integer sex;// (smallint)性别 0:男 1:女
	private Integer ages;// (smallint)年龄层 0:18岁以下 1:18-25 2:26-35 4:36-45
							// 6:46-55 7: 55以上
	private String address;// (varchar)地址
	private String postno;// (varchar)邮编
	private String works;// (varchar)职业
	private Integer zodiac;// (smallint)星座
	private String security;// (varchar)证券
	private String add_ip;// (varchar)添加人IP
	private Date add_time;// (datetime)添加时间
	private Integer express_status;// (smallint)是否已快递
	private String express_type;// (varchar)快递类型
	private String express_no;// (varchar)快递单号
	private Date express_date;// (datetime)快递时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (datetime)最后修改时间

	public Integer getExpress_status() {
		return express_status;
	}

	public void setExpress_status(Integer express_status) {
		this.express_status = express_status;
	}

	public String getExpress_type() {
		return express_type;
	}

	public void setExpress_type(String express_type) {
		this.express_type = express_type;
	}

	public String getExpress_no() {
		return express_no;
	}

	public void setExpress_no(String express_no) {
		this.express_no = express_no;
	}

	public Date getExpress_date() {
		return express_date;
	}

	public void setExpress_date(Date express_date) {
		this.express_date = express_date;
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

	public String getAdd_ip() {
		return add_ip;
	}

	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getLinkid() {
		return linkid;
	}

	public void setLinkid(String linkid) {
		this.linkid = linkid;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getXinlang() {
		return xinlang;
	}

	public void setXinlang(String xinlang) {
		this.xinlang = xinlang;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getAges() {
		return ages;
	}

	public void setAges(Integer ages) {
		this.ages = ages;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostno() {
		return postno;
	}

	public void setPostno(String postno) {
		this.postno = postno;
	}

	public String getWorks() {
		return works;
	}

	public void setWorks(String works) {
		this.works = works;
	}

	public Integer getZodiac() {
		return zodiac;
	}

	public void setZodiac(Integer zodiac) {
		this.zodiac = zodiac;
	}

	public String getSecurity() {
		return security;
	}

	public void setSecurity(String security) {
		this.security = security;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

}
