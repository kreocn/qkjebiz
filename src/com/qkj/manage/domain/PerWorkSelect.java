package com.qkj.manage.domain;

public class PerWorkSelect {
	private String table_name;// 表名
	private String table_field;// 查询的字段
	private String table_condition;// 查询条件
	private String loginUser;//登录人
	private String loginPower;//职位
	public PerWorkSelect() {

	}

	public PerWorkSelect(String table_name, String table_field, String table_condition) {
		this.setTable_name(table_name);
		this.setTable_field(table_field);
		this.setTable_condition(table_condition);

	}
	
	public PerWorkSelect(String loginUser,String loginPower){
		this.setLoginUser(loginUser);
		this.setLoginPower(loginPower);
	}

	public String getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(String loginUser) {
		this.loginUser = loginUser;
	}

	public String getLoginPower() {
		return loginPower;
	}

	public void setLoginPower(String loginPower) {
		this.loginPower = loginPower;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public String getTable_field() {
		return table_field;
	}

	public void setTable_field(String table_field) {
		this.table_field = table_field;
	}

	public String getTable_condition() {
		return table_condition;
	}

	public void setTable_condition(String table_condition) {
		this.table_condition = table_condition;
	}

}
