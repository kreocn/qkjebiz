package com.qkj.manage.domain;

import java.util.Date;

public class CloseOrder {
	private Integer uuid;// (int)
	private String close_num;// 编号
	private String salPro_id;// 促销方案
	private Date close_time;// (date)结案时间
	private String content;// (text)内容
	private String theme;// (varchar)主题
	private String member_id;// (varchar)收货人
	private String member_address;// (varchar)收货地址
	private String member_phone;// (varchar)手机号
	private String member_title;
	private String member_note;
	private Double totel_price;// (decimal)商品总价格
	private Double mt_price;
	private String apply_dept;
	private String add_user;// (varchar)填加人
	private Date add_time;// (datetime)填加时间
	private Integer type;
	private Integer typeO;
	private Integer apply_id;
	private String m_name;

	private Integer state;
	private Integer sd_state;
	private String sd_user;
	private Date sd_time;
	private Integer smd_status;
	private String smd_user;
	private Date smd_time;
	private Integer fd_check_state;
	private String fd_check_user;
	private Date fd_check_time;

	private Integer nd_check_state;// (int)数据中心审核状态0：未审核5：退回10：通过
	private Date nd_check_time;// (datetime)数据中心审核时间
	private String nd_check_user;// (varchar)操作人
	private Date lm_time;// (datetime)修改时间
	private String lm_user;// (varchar)修改人

	private Integer ship_status;// 发货状态
	private Integer ship_ware;// 发货仓库
	private Date ship_date;// 发货时间
	private String ship_no;// 运单号码
	private String ship_cloud;
	private String ship_type;// 物流名称
	private String ship_phone;// 物流单号
	private String remark;
	private String close_note;
	private Integer goflag;

	private Double m_upprice;
	private Double m_price;
	private Double m_bprice;
	private Double f_upprice;
	private Double f_price;
	private Double f_bprice;
	private Integer is_fullcheck;

	// 以下为非数据库字段
	private String member_name;
	private String lm_user_name;
	private String add_user_name;
	private String nd_check_user_name;
	private String check_user_name;
	private String is_sub_dept;
	private String apply_dept_name;
	private String puser_name;
	private String puser_sign;
	private Date biz_time;
	private String sd_user_name;
	private String smd_user_name;
	private String fd_user_name;
	private String nd_user_name;

	private String sign20;
	private String sign30;
	private String sign40;
	private String sign50;
	private String sign60;
	private String sign70;
	private String sign80;

	private Date time20;
	private Date time30;
	private Date time40;
	private Date time50;
	private Date time60;
	private Date time70;
	private Date time80;

	
	public Integer getTypeO() {
		return typeO;
	}

	public void setTypeO(Integer typeO) {
		this.typeO = typeO;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getMember_title() {
		return member_title;
	}

	public void setMember_title(String member_title) {
		this.member_title = member_title;
	}

	public String getMember_note() {
		return member_note;
	}

	public void setMember_note(String member_note) {
		this.member_note = member_note;
	}

	public Integer getIs_fullcheck() {
		return is_fullcheck;
	}

	public void setIs_fullcheck(Integer is_fullcheck) {
		this.is_fullcheck = is_fullcheck;
	}

	public Double getM_upprice() {
		return m_upprice;
	}

	public void setM_upprice(Double m_upprice) {
		this.m_upprice = m_upprice;
	}

	public Double getM_price() {
		return m_price;
	}

	public void setM_price(Double m_price) {
		this.m_price = m_price;
	}

	public Double getM_bprice() {
		return m_bprice;
	}

	public void setM_bprice(Double m_bprice) {
		this.m_bprice = m_bprice;
	}

	public Double getF_upprice() {
		return f_upprice;
	}

	public void setF_upprice(Double f_upprice) {
		this.f_upprice = f_upprice;
	}

	public Double getF_price() {
		return f_price;
	}

	public void setF_price(Double f_price) {
		this.f_price = f_price;
	}

	public Double getF_bprice() {
		return f_bprice;
	}

	public void setF_bprice(Double f_bprice) {
		this.f_bprice = f_bprice;
	}

	public Double getMt_price() {
		return mt_price;
	}

	public void setMt_price(Double mt_price) {
		this.mt_price = mt_price;
	}

	public String getShip_cloud() {
		return ship_cloud;
	}

	public void setShip_cloud(String ship_cloud) {
		this.ship_cloud = ship_cloud;
	}

	public Integer getGoflag() {
		return goflag;
	}

	public void setGoflag(Integer goflag) {
		this.goflag = goflag;
	}

	public String getClose_note() {
		return close_note;
	}

	public void setClose_note(String close_note) {
		this.close_note = close_note;
	}

	public String getRemark() {
		return remark;
	}

	public String getSign80() {
		return sign80;
	}

	public void setSign80(String sign80) {
		this.sign80 = sign80;
	}

	public Date getTime80() {
		return time80;
	}

	public void setTime80(Date time80) {
		this.time80 = time80;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getShip_status() {
		return ship_status;
	}

	public void setShip_status(Integer ship_status) {
		this.ship_status = ship_status;
	}

	public Integer getShip_ware() {
		return ship_ware;
	}

	public void setShip_ware(Integer ship_ware) {
		this.ship_ware = ship_ware;
	}

	public Date getShip_date() {
		return ship_date;
	}

	public void setShip_date(Date ship_date) {
		this.ship_date = ship_date;
	}

	public String getShip_no() {
		return ship_no;
	}

	public void setShip_no(String ship_no) {
		this.ship_no = ship_no;
	}

	public String getShip_type() {
		return ship_type;
	}

	public void setShip_type(String ship_type) {
		this.ship_type = ship_type;
	}

	public String getShip_phone() {
		return ship_phone;
	}

	public void setShip_phone(String ship_phone) {
		this.ship_phone = ship_phone;
	}

	public Integer getApply_id() {
		return apply_id;
	}

	public void setApply_id(Integer apply_id) {
		this.apply_id = apply_id;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getSd_user_name() {
		return sd_user_name;
	}

	public void setSd_user_name(String sd_user_name) {
		this.sd_user_name = sd_user_name;
	}

	public String getSmd_user_name() {
		return smd_user_name;
	}

	public void setSmd_user_name(String smd_user_name) {
		this.smd_user_name = smd_user_name;
	}

	public String getFd_user_name() {
		return fd_user_name;
	}

	public void setFd_user_name(String fd_user_name) {
		this.fd_user_name = fd_user_name;
	}

	public String getNd_user_name() {
		return nd_user_name;
	}

	public void setNd_user_name(String nd_user_name) {
		this.nd_user_name = nd_user_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getClose_num() {
		return close_num;
	}

	public void setClose_num(String close_num) {
		this.close_num = close_num;
	}

	public Date getClose_time() {
		return close_time;
	}

	public void setClose_time(Date close_time) {
		this.close_time = close_time;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public Double getTotel_price() {
		return totel_price;
	}

	public void setTotel_price(Double totel_price) {
		this.totel_price = totel_price;
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

	public Integer getNd_check_state() {
		return nd_check_state;
	}

	public void setNd_check_state(Integer nd_check_state) {
		this.nd_check_state = nd_check_state;
	}

	public Date getNd_check_time() {
		return nd_check_time;
	}

	public void setNd_check_time(Date nd_check_time) {
		this.nd_check_time = nd_check_time;
	}

	public String getNd_check_user() {
		return nd_check_user;
	}

	public void setNd_check_user(String nd_check_user) {
		this.nd_check_user = nd_check_user;
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

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getSalPro_id() {
		return salPro_id;
	}

	public void setSalPro_id(String salPro_id) {
		this.salPro_id = salPro_id;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getNd_check_user_name() {
		return nd_check_user_name;
	}

	public void setNd_check_user_name(String nd_check_user_name) {
		this.nd_check_user_name = nd_check_user_name;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

	public String getSign20() {
		return sign20;
	}

	public void setSign20(String sign20) {
		this.sign20 = sign20;
	}

	public String getSign30() {
		return sign30;
	}

	public void setSign30(String sign30) {
		this.sign30 = sign30;
	}

	public String getSign40() {
		return sign40;
	}

	public void setSign40(String sign40) {
		this.sign40 = sign40;
	}

	public String getSign50() {
		return sign50;
	}

	public void setSign50(String sign50) {
		this.sign50 = sign50;
	}

	public String getSign60() {
		return sign60;
	}

	public void setSign60(String sign60) {
		this.sign60 = sign60;
	}

	public String getSign70() {
		return sign70;
	}

	public void setSign70(String sign70) {
		this.sign70 = sign70;
	}

	public Date getTime20() {
		return time20;
	}

	public void setTime20(Date time20) {
		this.time20 = time20;
	}

	public Date getTime30() {
		return time30;
	}

	public void setTime30(Date time30) {
		this.time30 = time30;
	}

	public Date getTime40() {
		return time40;
	}

	public void setTime40(Date time40) {
		this.time40 = time40;
	}

	public Date getTime50() {
		return time50;
	}

	public void setTime50(Date time50) {
		this.time50 = time50;
	}

	public Date getTime60() {
		return time60;
	}

	public void setTime60(Date time60) {
		this.time60 = time60;
	}

	public Date getTime70() {
		return time70;
	}

	public void setTime70(Date time70) {
		this.time70 = time70;
	}

	public String getPuser_name() {
		return puser_name;
	}

	public void setPuser_name(String puser_name) {
		this.puser_name = puser_name;
	}

	public String getPuser_sign() {
		return puser_sign;
	}

	public void setPuser_sign(String puser_sign) {
		this.puser_sign = puser_sign;
	}

	public Date getBiz_time() {
		return biz_time;
	}

	public void setBiz_time(Date biz_time) {
		this.biz_time = biz_time;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getSd_state() {
		return sd_state;
	}

	public void setSd_state(Integer sd_state) {
		this.sd_state = sd_state;
	}

	public String getSd_user() {
		return sd_user;
	}

	public void setSd_user(String sd_user) {
		this.sd_user = sd_user;
	}

	public Date getSd_time() {
		return sd_time;
	}

	public void setSd_time(Date sd_time) {
		this.sd_time = sd_time;
	}

	public Integer getSmd_status() {
		return smd_status;
	}

	public void setSmd_status(Integer smd_status) {
		this.smd_status = smd_status;
	}

	public String getSmd_user() {
		return smd_user;
	}

	public void setSmd_user(String smd_user) {
		this.smd_user = smd_user;
	}

	public Date getSmd_time() {
		return smd_time;
	}

	public void setSmd_time(Date smd_time) {
		this.smd_time = smd_time;
	}

	public Integer getFd_check_state() {
		return fd_check_state;
	}

	public void setFd_check_state(Integer fd_check_state) {
		this.fd_check_state = fd_check_state;
	}

	public String getFd_check_user() {
		return fd_check_user;
	}

	public void setFd_check_user(String fd_check_user) {
		this.fd_check_user = fd_check_user;
	}

	public Date getFd_check_time() {
		return fd_check_time;
	}

	public void setFd_check_time(Date fd_check_time) {
		this.fd_check_time = fd_check_time;
	}

}
