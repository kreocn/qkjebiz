package org.iweb.sys.domain;

/**
 * 用户特殊权限
 * 
 * @author kreo
 * 
 */
public class UserPrvg {
	private String uuid; // 内部编号
	private String user_id; // 角色id
	private String privilege_id; // 权限id
	private Integer type; // 类型
	private String function; // 其他功能

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
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

}
