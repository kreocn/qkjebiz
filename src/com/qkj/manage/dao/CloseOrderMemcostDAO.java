package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class CloseOrderMemcostDAO extends AbstractDAO {
	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getCloseOrderMemcostsCounts");
		return super.list("qkjmanage_getCloseOrderMemcosts", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getCloseOrderMemcosts", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addCloseOrderMemcost", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delCloseOrderMemcost", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
