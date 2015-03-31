package org.iweb.sys.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class UserDeptDAO extends AbstractDAO {

	public void add(Object parameters) {
		super.add("sys_addUser", parameters);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("sys_getUser", map);
	}

	public void save(Object parameters) {
		super.save("sys_mdyUser", parameters);
	}

	public void delete(Object parameters) {
		super.delete("sys_delUser", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sys_getUser", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}

}
