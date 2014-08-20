package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class CustomerRecodeDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getCustomerRecodesCounts");
		return super.list("qkjmanage_getCustomerRecodes", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getCustomerRecodes", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addCustomerRecode", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyCustomerRecode", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delCustomerRecode", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
