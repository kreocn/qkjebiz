package org.iweb.sys.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class DepartmentDAO extends AbstractDAO {

	public void add(Object parameters) {
		super.add("sys_addDept", parameters);
	}

	public void save(Object parameters) {
		super.save("sys_mdyDept", parameters);
	}

	public void delete(Object parameters) {
		super.delete("sys_delDept", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sys_getDepts", map);
	}

	public List listPermit(Map<String, Object> map) {
		return super.list("sys_getPermitDepts", map);
	}
}
