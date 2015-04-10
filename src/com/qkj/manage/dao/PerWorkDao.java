package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class PerWorkDao extends AbstractDAO{
	
	public List list(Map<String, Object> map,String sqltext) {
		Map maps = new HashMap();
		maps.put("sqltext", sqltext);
		maps.putAll(map);
		return super.list("personal_getPerWorks", maps);
	}
	
	public List list(Map<String, Object> map) {
		//setCountMapid("personal_getPerWorkPowersCounts");
		return super.list("personal_getPerWorkPowers", map);
	}
	
	public Object addPower(Object parameters) {
		return super.add("personal_add", parameters);
	}
	
	public int savePower(Object parameters) {
		return super.save("personal_mdy", parameters);
	}
	
	public int deletePower(Object parameters) {
		return super.delete("personal_del", parameters);
	}
	
	public Object getPower(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("personal_getPerWorkPowers", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("personal_getPerWorks", map);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}

}
