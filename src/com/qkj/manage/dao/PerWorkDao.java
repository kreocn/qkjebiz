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
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("personal_getPerWorks", map);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}

}
