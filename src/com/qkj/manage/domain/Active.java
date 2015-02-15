package com.qkj.manage.domain;

import java.util.Date;

public class Active {
	private Integer uuid;// (int)主键自增
	private String uid;// (varchar)申请编号
	private String apply_dept;// (varchar)申请部门
	private String apply_user;// (varchar)申请人
	private String theme;// (varchar)主题
	private String purpose;// (varchar)目的
	private Date plan_start;// (date)计划开始时间
	private Date plan_end;// (date)计划结束时间
	private String address;// (varchar)活动地点
	private String person;// (varchar)执行人
	private Double it_price;// 公司合计费用
	private Double mt_price;// 经销商合计费用
	private String note;// (text)方案说明
	private String expect;// (varchar)活动预期
	private Integer status;// (int)申请单状态 0:新申请 1:申请审批中 2:申请通过 3:开始结案 4:结案审批中
							// 5:结案通过
	// (int)销售部-审核状态 0:初始状态 5:审核退回 10:待审核 20:办事处经理审核通过 30:大区经理审核通过 40:运营总监审核通过
	// 50:业务副总审核通过 60:总经理审核通过
	private Integer sd_status;
	private Date sd_time;// (datetime)销售部审核状态最后操作时间
	private Integer smd_status;// (int)销售管理部-审核状态 0:未签收 5:审核退回 10:已签收 20:主管已审
								// 30:经理已审 40:销管部经理已审 50:副总已审
	private Date smd_time;// (datetime)销售管理部审核状态最后操作时间
	private String add_user;// (varchar)添加人
	private Date add_time;// (datetime)添加时间
	private String lm_user;// (varchar)修改人
	private Date lm_time;// (timestamp)修改时间
	private Date close_start;// 开始结案日期
	private String close_note;// 活动概况
	private Integer close_sd_status;// 销售部-审核状态 0:不能审核 1:审核不通过 2:审核通过
	private Date close_sd_time;// 销售部审核状态最后操作时间
	private Integer close_smd_status;// 销售管理部-审核状态 0:不能审核 1:审核不通过 2:审核通过
	private Date close_smd_time;// 销售管理部审核状态最后操作时间
	private Double close_it_price;// 公司合计费用
	private Double close_mt_price;// 经销商合计费用
	private String remark; // 备注
	private String sd_user;// 最后销售部审核人
	private String smd_user;// 最后销管部审核人
	private String close_sd_user;// 最后销售部审核人
	private String close_smd_user;// 最后销管部审核人
	private Date pass_time; // 申请通过时间
	private Date close_pass_time; // 结案通过时间
	private Integer ship_status;// 发货状态
	private Integer ship_ware;// 发货仓库
	private Date ship_date;// 发货时间
	private String ship_no;// 运单号码
	private String ship_type;// 物流名称
	private String ship_phone;// 物流单号
	private Integer fd_status;
	private String fd_user;
	private Date fd_time;
	private Integer close_fd_status;
	private String close_fd_user;
	private Date close_fd_time;
	private Integer close_nd_status;
	private String close_nd_user;
	private Date close_nd_time;
	private String spe_remark;
	private Double m_upprice;
	private Double m_price;
	private Double m_bprice;
	private Double f_upprice;
	private Double f_price;
	private Double f_bprice;
	
	private Double close_m_upprice;
	private Double close_m_price;
	private Double close_m_bprice;
	private Double close_f_upprice;
	private Double close_f_price;
	private Double close_f_bprice;
	private Integer active_type;

	// 非数据库字段
	private String apply_dept_name;
	private String apply_user_name;
	private String sd_user_name;
	private String smd_user_name;
	private String close_sd_user_name;
	private String close_smd_user_name;
	private String sd_user_sign;
	private String smd_user_sign;
	private String close_sd_user_sign;
	private String close_smd_user_sign;
	private String biz_user;
	private String puser_sign;
	private String puser_name;
	private Date biz_time;
	private Date baotime;
	private Date stars;
	private Date sing;
	private Date spass;
	private Date starj;
	private Date jing;
	private Date jpass;
	// 查询使用字段
	private String is_sub_dept;
	private Date plan_start_begin;
	private Date plan_start_end;
	private Date pass_time_start;
	private Date pass_time_end;
	private Date close_pass_time_start;
	private Date close_pass_time_end;
	private String fd_user_name;
	private String close_fd_name;
	private String close_nd_name;
	private String member_id;
	
	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getStars() {
		return stars;
	}

	public void setStars(Date stars) {
		this.stars = stars;
	}

	public Date getSing() {
		return sing;
	}

	public void setSing(Date sing) {
		this.sing = sing;
	}

	public Date getSpass() {
		return spass;
	}

	public void setSpass(Date spass) {
		this.spass = spass;
	}

	public Date getStarj() {
		return starj;
	}

	public void setStarj(Date starj) {
		this.starj = starj;
	}

	public Date getJing() {
		return jing;
	}

	public void setJing(Date jing) {
		this.jing = jing;
	}

	public Date getJpass() {
		return jpass;
	}

	public void setJpass(Date jpass) {
		this.jpass = jpass;
	}

	public Date getBaotime() {
		return baotime;
	}

	public void setBaotime(Date baotime) {
		this.baotime = baotime;
	}

	public Double getClose_m_upprice() {
		return close_m_upprice;
	}

	public void setClose_m_upprice(Double close_m_upprice) {
		this.close_m_upprice = close_m_upprice;
	}

	public Double getClose_m_price() {
		return close_m_price;
	}

	public void setClose_m_price(Double close_m_price) {
		this.close_m_price = close_m_price;
	}

	public Double getClose_m_bprice() {
		return close_m_bprice;
	}

	public void setClose_m_bprice(Double close_m_bprice) {
		this.close_m_bprice = close_m_bprice;
	}

	public Double getClose_f_upprice() {
		return close_f_upprice;
	}

	public void setClose_f_upprice(Double close_f_upprice) {
		this.close_f_upprice = close_f_upprice;
	}

	public Double getClose_f_price() {
		return close_f_price;
	}

	public void setClose_f_price(Double close_f_price) {
		this.close_f_price = close_f_price;
	}

	public Double getClose_f_bprice() {
		return close_f_bprice;
	}

	public void setClose_f_bprice(Double close_f_bprice) {
		this.close_f_bprice = close_f_bprice;
	}

	public String getSpe_remark() {
		return spe_remark;
	}

	public void setSpe_remark(String spe_remark) {
		this.spe_remark = spe_remark;
	}

	public Date getBiz_time() {
		return biz_time;
	}

	public void setBiz_time(Date biz_time) {
		this.biz_time = biz_time;
	}

	public Integer getFd_status() {
		return fd_status;
	}

	public void setFd_status(Integer fd_status) {
		this.fd_status = fd_status;
	}

	public String getFd_user() {
		return fd_user;
	}

	public void setFd_user(String fd_user) {
		this.fd_user = fd_user;
	}

	public Date getFd_time() {
		return fd_time;
	}

	public void setFd_time(Date fd_time) {
		this.fd_time = fd_time;
	}

	public Integer getClose_fd_status() {
		return close_fd_status;
	}

	public void setClose_fd_status(Integer close_fd_status) {
		this.close_fd_status = close_fd_status;
	}

	public String getClose_fd_user() {
		return close_fd_user;
	}

	public void setClose_fd_user(String close_fd_user) {
		this.close_fd_user = close_fd_user;
	}

	public Date getClose_fd_time() {
		return close_fd_time;
	}

	public void setClose_fd_time(Date close_fd_time) {
		this.close_fd_time = close_fd_time;
	}

	public Integer getClose_nd_status() {
		return close_nd_status;
	}

	public void setClose_nd_status(Integer close_nd_status) {
		this.close_nd_status = close_nd_status;
	}

	public String getClose_nd_user() {
		return close_nd_user;
	}

	public void setClose_nd_user(String close_nd_user) {
		this.close_nd_user = close_nd_user;
	}

	public Date getClose_nd_time() {
		return close_nd_time;
	}

	public void setClose_nd_time(Date close_nd_time) {
		this.close_nd_time = close_nd_time;
	}

	public String getShip_type() {
		return ship_type;
	}

	public void setShip_type(String ship_type) {
		this.ship_type = ship_type;
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

	public String getShip_phone() {
		return ship_phone;
	}

	public void setShip_phone(String ship_phone) {
		this.ship_phone = ship_phone;
	}

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}

	public Date getPass_time_start() {
		return pass_time_start;
	}

	public void setPass_time_start(Date pass_time_start) {
		this.pass_time_start = pass_time_start;
	}

	public Date getPass_time_end() {
		return pass_time_end;
	}

	public void setPass_time_end(Date pass_time_end) {
		this.pass_time_end = pass_time_end;
	}

	public Date getClose_pass_time_start() {
		return close_pass_time_start;
	}

	public void setClose_pass_time_start(Date close_pass_time_start) {
		this.close_pass_time_start = close_pass_time_start;
	}

	public Date getClose_pass_time_end() {
		return close_pass_time_end;
	}

	public void setClose_pass_time_end(Date close_pass_time_end) {
		this.close_pass_time_end = close_pass_time_end;
	}

	public Date getPass_time() {
		return pass_time;
	}

	public void setPass_time(Date pass_time) {
		this.pass_time = pass_time;
	}

	public Date getClose_pass_time() {
		return close_pass_time;
	}

	public void setClose_pass_time(Date close_pass_time) {
		this.close_pass_time = close_pass_time;
	}

	public String getClose_sd_user_sign() {
		return close_sd_user_sign;
	}

	public void setClose_sd_user_sign(String close_sd_user_sign) {
		this.close_sd_user_sign = close_sd_user_sign;
	}

	public String getClose_smd_user_sign() {
		return close_smd_user_sign;
	}

	public void setClose_smd_user_sign(String close_smd_user_sign) {
		this.close_smd_user_sign = close_smd_user_sign;
	}

	public String getSd_user_sign() {
		return sd_user_sign;
	}

	public void setSd_user_sign(String sd_user_sign) {
		this.sd_user_sign = sd_user_sign;
	}

	public String getSmd_user_sign() {
		return smd_user_sign;
	}

	public void setSmd_user_sign(String smd_user_sign) {
		this.smd_user_sign = smd_user_sign;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}

	public String getApply_user() {
		return apply_user;
	}

	public void setApply_user(String apply_user) {
		this.apply_user = apply_user;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public Date getPlan_start() {
		return plan_start;
	}

	public void setPlan_start(Date plan_start) {
		this.plan_start = plan_start;
	}

	public Date getPlan_end() {
		return plan_end;
	}

	public void setPlan_end(Date plan_end) {
		this.plan_end = plan_end;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPerson() {
		return person;
	}

	public void setPerson(String person) {
		this.person = person;
	}

	public Double getIt_price() {
		return it_price;
	}

	public void setIt_price(Double it_price) {
		this.it_price = it_price;
	}

	public Double getMt_price() {
		return mt_price;
	}

	public void setMt_price(Double mt_price) {
		this.mt_price = mt_price;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getExpect() {
		return expect;
	}

	public void setExpect(String expect) {
		this.expect = expect;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getSd_status() {
		return sd_status;
	}

	public void setSd_status(Integer sd_status) {
		this.sd_status = sd_status;
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

	public Date getSmd_time() {
		return smd_time;
	}

	public void setSmd_time(Date smd_time) {
		this.smd_time = smd_time;
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

	public Date getClose_start() {
		return close_start;
	}

	public void setClose_start(Date close_start) {
		this.close_start = close_start;
	}

	public String getClose_note() {
		return close_note;
	}

	public void setClose_note(String close_note) {
		this.close_note = close_note;
	}

	public Integer getClose_sd_status() {
		return close_sd_status;
	}

	public void setClose_sd_status(Integer close_sd_status) {
		this.close_sd_status = close_sd_status;
	}

	public Date getClose_sd_time() {
		return close_sd_time;
	}

	public void setClose_sd_time(Date close_sd_time) {
		this.close_sd_time = close_sd_time;
	}

	public Integer getClose_smd_status() {
		return close_smd_status;
	}

	public void setClose_smd_status(Integer close_smd_status) {
		this.close_smd_status = close_smd_status;
	}

	public Date getClose_smd_time() {
		return close_smd_time;
	}

	public void setClose_smd_time(Date close_smd_time) {
		this.close_smd_time = close_smd_time;
	}

	public Double getClose_it_price() {
		return close_it_price;
	}

	public void setClose_it_price(Double close_it_price) {
		this.close_it_price = close_it_price;
	}

	public Double getClose_mt_price() {
		return close_mt_price;
	}

	public void setClose_mt_price(Double close_mt_price) {
		this.close_mt_price = close_mt_price;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSd_user() {
		return sd_user;
	}

	public void setSd_user(String sd_user) {
		this.sd_user = sd_user;
	}

	public String getSmd_user() {
		return smd_user;
	}

	public void setSmd_user(String smd_user) {
		this.smd_user = smd_user;
	}

	public String getClose_sd_user() {
		return close_sd_user;
	}

	public void setClose_sd_user(String close_sd_user) {
		this.close_sd_user = close_sd_user;
	}

	public String getClose_smd_user() {
		return close_smd_user;
	}

	public void setClose_smd_user(String close_smd_user) {
		this.close_smd_user = close_smd_user;
	}

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

	public String getApply_user_name() {
		return apply_user_name;
	}

	public void setApply_user_name(String apply_user_name) {
		this.apply_user_name = apply_user_name;
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

	public String getClose_sd_user_name() {
		return close_sd_user_name;
	}

	public void setClose_sd_user_name(String close_sd_user_name) {
		this.close_sd_user_name = close_sd_user_name;
	}

	public String getClose_smd_user_name() {
		return close_smd_user_name;
	}

	public void setClose_smd_user_name(String close_smd_user_name) {
		this.close_smd_user_name = close_smd_user_name;
	}

	public Date getPlan_start_begin() {
		return plan_start_begin;
	}

	public void setPlan_start_begin(Date plan_start_begin) {
		this.plan_start_begin = plan_start_begin;
	}

	public Date getPlan_start_end() {
		return plan_start_end;
	}

	public void setPlan_start_end(Date plan_start_end) {
		this.plan_start_end = plan_start_end;
	}

	public String getFd_user_name() {
		return fd_user_name;
	}

	public void setFd_user_name(String fd_user_name) {
		this.fd_user_name = fd_user_name;
	}

	public String getClose_fd_name() {
		return close_fd_name;
	}

	public void setClose_fd_name(String close_fd_name) {
		this.close_fd_name = close_fd_name;
	}

	public String getClose_nd_name() {
		return close_nd_name;
	}

	public void setClose_nd_name(String close_nd_name) {
		this.close_nd_name = close_nd_name;
	}

	public String getBiz_user() {
		return biz_user;
	}

	public void setBiz_user(String biz_user) {
		this.biz_user = biz_user;
	}

	public String getPuser_sign() {
		return puser_sign;
	}

	public void setPuser_sign(String puser_sign) {
		this.puser_sign = puser_sign;
	}

	public String getPuser_name() {
		return puser_name;
	}

	public void setPuser_name(String puser_name) {
		this.puser_name = puser_name;
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

	public Integer getActive_type() {
		return active_type;
	}

	public void setActive_type(Integer active_type) {
		this.active_type = active_type;
	}
	
	

}
