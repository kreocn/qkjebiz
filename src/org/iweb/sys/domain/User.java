package org.iweb.sys.domain;

import java.util.Date;

public class User {

	private String uuid;
	private String title;
	private String passwords;
	private String ukeys;
	private String dept_code;
	private String user_roles;
	private String extra_prvg;
	private String user_type;
	private String work_id;
	private String user_name;
	private Integer sex;
	private String email;
	private Integer is_email_check;
	private String phone;
	private String mobile;
	private Integer is_mobile_check;
	private String position;
	// private String position_grade;
	// private String position_attribute;
	// private String position_note;
	private String senior;// 上级人员(汇报对象)
	private String descriptions;
	private Integer status;
	private String filesystem_root;
	private Date reg_time;
	private String user_sign; // 用户个性签名链接
	private String lm_user;
	private Date lm_time;

	// 以下为非数据库字段
	private String dept_cname;
	private String senior_name;
	private String type_name;
	private String position_name;

	// 以下为查询专用字段
	private String[] positions;

	public String getUser_sign() {
		return user_sign;
	}

	public void setUser_sign(String user_sign) {
		this.user_sign = user_sign;
	}

	public String[] getPositions() {
		return positions;
	}

	public void setPositions(String[] positions) {
		this.positions = positions;
	}

	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Date getReg_time() {
		return reg_time;
	}

	public void setReg_time(Date reg_time) {
		this.reg_time = reg_time;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPasswords() {
		return passwords;
	}

	public void setPasswords(String passwords) {
		this.passwords = passwords;
	}

	public String getUkeys() {
		return ukeys;
	}

	public void setUkeys(String ukeys) {
		this.ukeys = ukeys;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getUser_roles() {
		return user_roles;
	}

	public void setUser_roles(String user_roles) {
		this.user_roles = user_roles;
	}

	public String getExtra_prvg() {
		return extra_prvg;
	}

	public void setExtra_prvg(String extra_prvg) {
		this.extra_prvg = extra_prvg;
	}

	public String getWork_id() {
		return work_id;
	}

	public void setWork_id(String work_id) {
		this.work_id = work_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getSenior() {
		return senior;
	}

	public void setSenior(String senior) {
		this.senior = senior;
	}

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}

	public Integer getIs_email_check() {
		return is_email_check;
	}

	public void setIs_email_check(Integer is_email_check) {
		this.is_email_check = is_email_check;
	}

	public Integer getIs_mobile_check() {
		return is_mobile_check;
	}

	public void setIs_mobile_check(Integer is_mobile_check) {
		this.is_mobile_check = is_mobile_check;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public String getDept_cname() {
		return dept_cname;
	}

	public void setDept_cname(String dept_cname) {
		this.dept_cname = dept_cname;
	}

	public String getFilesystem_root() {
		return filesystem_root;
	}

	public void setFilesystem_root(String filesystem_root) {
		this.filesystem_root = filesystem_root;
	}

	public String getSenior_name() {
		return senior_name;
	}

	public void setSenior_name(String senior_name) {
		this.senior_name = senior_name;
	}

}
