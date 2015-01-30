package org.iweb.sys.domain;


public class RolePrvg {
	private String uuid; // 内部编号
	private String role_id; // 角色id
	private String privilege_id; // 权限id
	private Integer type; // 类型
	private String function; // 其他功能

	// 非数据库字段
	private String role_name;
	private String parent_privilege;
	private String privilege_name;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getRole_id() {
		return role_id;
	}

	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}

	public String getPrivilege_id() {
		return privilege_id;
	}

	public void setPrivilege_id(String privilege_id) {
		this.privilege_id = privilege_id;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getParent_privilege() {
		return parent_privilege;
	}

	public void setParent_privilege(String parent_privilege) {
		this.parent_privilege = parent_privilege;
	}

	public String getPrivilege_name() {
		return privilege_name;
	}

	public void setPrivilege_name(String privilege_name) {
		this.privilege_name = privilege_name;
	}

}
