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
	
	public List listM(Map<String, Object> map) {
		return super.list("qkjmanage_getActiveM", map);
	}
	
	public List listF(Map<String, Object> map) {
		return super.list("qkjmanage_getActiveF", map);
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
	
	public int deleteM(Object parameters) {
		return super.delete("qkjmanage_delActiveM", parameters);
	}
	
	public int deleteF(Object parameters) {
		return super.delete("qkjmanage_delActiveF", parameters);
	}
	
	public int saveM(Object parameters) {
		return super.save("qkjmanage_addActiveM", parameters);
	}
	
	public int saveF(Object parameters) {
		return super.save("qkjmanage_addActiveF", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
