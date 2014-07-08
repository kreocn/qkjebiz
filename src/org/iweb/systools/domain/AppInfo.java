package org.iweb.systools.domain;

import java.util.Map;

public class AppInfo {
	private String app_name; // 应用名称
	private String name_space; // 应用命名
	private String app_code; // 应用前缀
	private String db_name; // 数据库名称
	private String table_name; // 表名,xxx_xxx格式
	private String app_en; // 生成的文件名参照,一般是表名的最后2位
	private String package_name;// JAVA 包名
	private String jsp_path;// JSP存放路径
	private Map<String, TableColumn> tcs; // table对应的column设置<column_name,TableColumn>

	public String getApp_code() {
		return app_code;
	}

	public void setApp_code(String app_code) {
		this.app_code = app_code;
	}

	public String getName_space() {
		return name_space;
	}

	public void setName_space(String name_space) {
		this.name_space = name_space;
	}

	public String getDb_name() {
		return db_name;
	}

	public void setDb_name(String db_name) {
		this.db_name = db_name;
	}

	public String getApp_en() {
		return app_en;
	}

	public void setApp_en(String app_en) {
		this.app_en = app_en;
	}

	public String getApp_name() {
		return app_name;
	}

	public void setApp_name(String app_name) {
		this.app_name = app_name;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public String getPackage_name() {
		return package_name;
	}

	public void setPackage_name(String package_name) {
		this.package_name = package_name;
	}

	public String getJsp_path() {
		return jsp_path;
	}

	public void setJsp_path(String jsp_path) {
		this.jsp_path = jsp_path;
	}

	public Map<String, TableColumn> getTcs() {
		return tcs;
	}

	public void setTcs(Map<String, TableColumn> tcs) {
		this.tcs = tcs;
	}
}
