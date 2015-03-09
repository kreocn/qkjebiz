package org.iweb.sys.domain;

import java.util.Date;

public class UserPrivilege {
	private String uuid;
	private String privilege_name;
	private String parent_privilege;
	private String descriptions;
	private String privilege_id;
	private Integer privilege_type; // 权限类别 0用户权限 1管理员权限
	private Integer is_ajax;
	private String ajax_map_id;
	private Integer is_menu;
	private String menu_url;
	private String menu_target;
	private Integer menu_priority;
	private String menu_title;
	private String lm_user;
	private Date lm_time;
	private Integer module;

	public Integer getModule() {
		return module;
	}

	public void setModule(Integer module) {
		this.module = module;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPrivilege_name() {
		return privilege_name;
	}

	public void setPrivilege_name(String privilege_name) {
		this.privilege_name = privilege_name;
	}

	public String getParent_privilege() {
		return parent_privilege;
	}

	public void setParent_privilege(String parent_privilege) {
		this.parent_privilege = parent_privilege;
	}

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}

	public String getPrivilege_id() {
		return privilege_id;
	}

	public void setPrivilege_id(String privilege_id) {
		this.privilege_id = privilege_id;
	}

	public Integer getPrivilege_type() {
		return privilege_type;
	}

	public void setPrivilege_type(Integer privilege_type) {
		this.privilege_type = privilege_type;
	}

	public Integer getIs_ajax() {
		return is_ajax;
	}

	public void setIs_ajax(Integer is_ajax) {
		this.is_ajax = is_ajax;
	}

	public String getAjax_map_id() {
		return ajax_map_id;
	}

	public void setAjax_map_id(String ajax_map_id) {
		this.ajax_map_id = ajax_map_id;
	}

	public Integer getIs_menu() {
		return is_menu;
	}

	public void setIs_menu(Integer is_menu) {
		this.is_menu = is_menu;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getMenu_target() {
		return menu_target;
	}

	public void setMenu_target(String menu_target) {
		this.menu_target = menu_target;
	}

	public Integer getMenu_priority() {
		return menu_priority;
	}

	public void setMenu_priority(Integer menu_priority) {
		this.menu_priority = menu_priority;
	}

	public String getMenu_title() {
		return menu_title;
	}

	public void setMenu_title(String menu_title) {
		this.menu_title = menu_title;
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

}
