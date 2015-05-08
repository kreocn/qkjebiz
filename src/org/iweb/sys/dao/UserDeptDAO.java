package org.iweb.sys.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class UserDeptDAO extends AbstractDAO {

	public void add(Object parameters) {
		super.add("sys_addUserDept", parameters);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("sys_getUsesrDept", map);
	}

	public void save(Object parameters) {
		super.save("sys_mdyUserDept", parameters);
	}

	public void delete(Object parameters) {
		super.delete("sys_delUserDept", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sys_getUsesrDept", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}

}
