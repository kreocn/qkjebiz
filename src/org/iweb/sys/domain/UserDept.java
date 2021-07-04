package org.iweb.sys.domain;

import java.util.Date;
import java.util.List;

public class UserDept {
	private Integer uuid;
	private String user_id;
	private String dept_code;
	private String position;
	private Integer subover;
	private Integer depsubover;
	private String roles;
	private String prvgs;
	private Date lm_time;

	private String dept_cname;
	private String position_name;

	private List<UserRole> user_roles_list;
	
	private Date login_time;

	public Integer getDepsubover() {
		return depsubover;
	}

	public void setDepsubover(Integer depsubover) {
		this.depsubover = depsubover;
	}

	public List<UserRole> getUser_roles_list() {
		return user_roles_list;
	}

	public void setUser_roles_list(List<UserRole> user_roles_list) {
		this.user_roles_list = user_roles_list;
	}

	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	public String getDept_cname() {
		return dept_cname;
	}

	public void setDept_cname(String dept_cname) {
		this.dept_cname = dept_cname;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getSubover() {
		return subover;
	}

	public void setSubover(Integer subover) {
		this.subover = subover;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	public String getPrvgs() {
		return prvgs;
	}

	public void setPrvgs(String prvgs) {
		this.prvgs = prvgs;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public Date getLogin_time() {
		return login_time;
	}

	public void setLogin_time(Date login_time) {
		this.login_time = login_time;
	}

}
