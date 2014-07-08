package org.iweb.sys.domain;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class UserLoginInfo {
	private String uuid;
	private String title;
	private String keys;
	private String dept_code;
	private String user_roles;
	private String user_type;
	private String extra_prvg;
	private String work_id;
	private String user_name;
	private Integer sex;
	private String email;
	private Integer is_email_check;
	private String phone;
	private String mobile;
	private Integer is_mobile_check;
	private String position;
	private String descriptions;
	private String filesystem_root;
	private Integer status;
	private String user_sign; // 用户个性签名链接
	private String lm_user;
	private Date lm_time;

	private String senior_name;

	private String org_name;
	private String dept_cname;

	private List<String> permit_depts;

	private List<UserRole> user_roles_list;
	// private Set<String> user_prov_set;

	private HashMap<String, Integer> member_prvg_map;
	private HashMap<String, String> member_function_map;

	private HashMap<String, Integer> user_prvg_map;
	private HashMap<String, String> user_function_map;

	private String sex_name;
	private String status_name;
	private String position_name;

	public String getUser_sign() {
		return user_sign;
	}

	public void setUser_sign(String user_sign) {
		this.user_sign = user_sign;
	}

	public List<String> getPermit_depts() {
		return permit_depts;
	}

	public void setPermit_depts(List<String> permit_depts) {
		this.permit_depts = permit_depts;
	}

	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public HashMap<String, String> getUser_function_map() {
		return user_function_map;
	}

	public void setUser_function_map(HashMap<String, String> user_function_map) {
		this.user_function_map = user_function_map;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeys() {
		return keys;
	}

	public void setKeys(String keys) {
		this.keys = keys;
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

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}

	public String getFilesystem_root() {
		return filesystem_root;
	}

	public void setFilesystem_root(String filesystem_root) {
		this.filesystem_root = filesystem_root;
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

	public String getSenior_name() {
		return senior_name;
	}

	public void setSenior_name(String senior_name) {
		this.senior_name = senior_name;
	}

	public List<UserRole> getUser_roles_list() {
		return user_roles_list;
	}

	public void setUser_roles_list(List<UserRole> user_roles_list) {
		this.user_roles_list = user_roles_list;
	}

	public HashMap<String, Integer> getMember_prvg_map() {
		return member_prvg_map;
	}

	public void setMember_prvg_map(HashMap<String, Integer> member_prvg_map) {
		this.member_prvg_map = member_prvg_map;
	}

	public HashMap<String, String> getMember_function_map() {
		return member_function_map;
	}

	public void setMember_function_map(HashMap<String, String> member_function_map) {
		this.member_function_map = member_function_map;
	}

	public HashMap<String, Integer> getUser_prvg_map() {
		return user_prvg_map;
	}

	public void setUser_prvg_map(HashMap<String, Integer> user_prvg_map) {
		this.user_prvg_map = user_prvg_map;
	}

	public String getSex_name() {
		return sex_name;
	}

	public void setSex_name(String sex_name) {
		this.sex_name = sex_name;
	}

	public String getStatus_name() {
		return status_name;
	}

	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

}
