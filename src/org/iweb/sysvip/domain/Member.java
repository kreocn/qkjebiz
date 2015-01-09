package org.iweb.sysvip.domain;

import java.util.Date;

public class Member {
	private String uuid;// (varchar)会员号
	private String passwords;// (varchar) 0
	private String title;// (varchar)会员帐号/登录别名
	private String mobile;// (varchar)会员手机
	private Integer is_mobile_check;// (int)手机号是否已验证 0:未验证 1:已验证
	private String email;// (varchar)会员EMAIL
	private Integer is_email_check;// (int)EMAIL是否验证 0:未验证 1:已验证
	private String member_name;// (varchar)会员姓名
	private String user_type;// (varchar)会员级别/权限 对应s_sys_role中的会员角色
	private Date reg_time;// (datetime)注册时间
	private Integer reg_type;// (int)注册方式 0 自行注册 1 管理员添加 2 批量导入
	private Date last_login_time;// (datetime)最后登录时间
	private String dept_code; // 部门代码
	private String manager; // 客户经理
	private String contact;// 联系人
	// 以下为非数据库字段
	private String user_type_name;
	private String dept_name;
	private String manager_name;
	private String manager_mobile;

	private Double money;
	private Integer score;
	private Integer re_score;
	private Integer with_score;

	// 查询专用字段
	// 客户经理查询方式 0 默认 1 查询客户经理为空的情况
	private Integer manager_search_type;
	private String is_sub_dept;

	public Integer getWith_score() {
		return with_score;
	}

	public void setWith_score(Integer with_score) {
		this.with_score = with_score;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getManager_mobile() {
		return manager_mobile;
	}

	public void setManager_mobile(String manager_mobile) {
		this.manager_mobile = manager_mobile;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getRe_score() {
		return re_score;
	}

	public void setRe_score(Integer re_score) {
		this.re_score = re_score;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getManager_name() {
		return manager_name;
	}

	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}

	public Integer getManager_search_type() {
		return manager_search_type;
	}

	public void setManager_search_type(Integer manager_search_type) {
		this.manager_search_type = manager_search_type;
	}

	public String getUser_type_name() {
		return user_type_name;
	}

	public void setUser_type_name(String user_type_name) {
		this.user_type_name = user_type_name;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPasswords() {
		return passwords;
	}

	public void setPasswords(String passwords) {
		this.passwords = passwords;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Integer getIs_mobile_check() {
		return is_mobile_check;
	}

	public void setIs_mobile_check(Integer is_mobile_check) {
		this.is_mobile_check = is_mobile_check;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getIs_email_check() {
		return is_email_check;
	}

	public void setIs_email_check(Integer is_email_check) {
		this.is_email_check = is_email_check;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public Date getReg_time() {
		return reg_time;
	}

	public void setReg_time(Date reg_time) {
		this.reg_time = reg_time;
	}

	public Integer getReg_type() {
		return reg_type;
	}

	public void setReg_type(Integer reg_type) {
		this.reg_type = reg_type;
	}

	public Date getLast_login_time() {
		return last_login_time;
	}

	public void setLast_login_time(Date last_login_time) {
		this.last_login_time = last_login_time;
	}

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}
	
}
