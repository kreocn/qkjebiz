package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class EntertDAO extends AbstractDAO {
	
	public List list(Map<String, Object> map) {
		return super.list("qkjmanage_getEnterts", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getEnterts", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addEntert", parameters);
	}
	
	public int save(Object parameters) {
		return super.save("qkjmanage_mdyEntert", parameters);
	}
	
	public int savestate(Object parameters) {
		return super.save("qkjmanage_mdyEntertState", parameters);
	}
	
	public int delete(Object parameters) {
		return super.delete("qkjmanage_delEntert", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
	
}
