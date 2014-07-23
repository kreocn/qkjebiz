package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ActiveMemcostDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getActiveMemcostsCounts");
		return super.list("qkjmanage_getActiveMemcosts", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getActiveMemcosts", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addActiveMemcost", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delActiveMemcost", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
