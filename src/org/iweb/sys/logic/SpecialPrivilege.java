package org.iweb.sys.logic;

import java.util.List;

import org.iweb.rpt.domain.ListObject;

public class SpecialPrivilege {
	private String privilege_id; // 关联的权限名称
	private String special_name; // 关联的特殊权限说明
	private Integer show_type; // 表现形式 0:checkbox 1:radio 2:select 3:text
	private String form_name; // 表单获取值名称
	private List<ListObject> value_list; // 如果是checkbox/radio/select,所取的值
	private String show_value; // 当前值,多个值用逗号','隔开

	public String getPrivilege_id() {
		return privilege_id;
	}

	public void setPrivilege_id(String privilege_id) {
		this.privilege_id = privilege_id;
	}

	public String getSpecial_name() {
		return special_name;
	}

	public void setSpecial_name(String special_name) {
		this.special_name = special_name;
	}

	public Integer getShow_type() {
		return show_type;
	}

	public void setShow_type(Integer show_type) {
		this.show_type = show_type;
	}

	public String getForm_name() {
		return form_name;
	}

	public void setForm_name(String form_name) {
		this.form_name = form_name;
	}

	public List<ListObject> getValue_list() {
		return value_list;
	}

	public void setValue_list(List<ListObject> value_list) {
		this.value_list = value_list;
	}

	public String getShow_value() {
		return show_value;
	}

	public void setShow_value(String show_value) {
		this.show_value = show_value;
	}

}
