package org.iweb.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class CommonDAO extends AbstractDAO {
	public Object commonSelectObject(String sqltext) {
		Map map = new HashMap();
		map.put("sqltext", sqltext);
		return super.get("commonSelectObject", map);
	}

	public List commonSelectMapList(String sqltext) {
		Map map = new HashMap();
		map.put("sqltext", sqltext);
		return super.list("commonSelectMapList", map);
	}
	
	public List listbytime(Map<String, Object> map) {
		//setCountMapid("qkjmanage_getApplysCounts");
		return super.list("find_activetime", map);
	}
	public List listbynum(Map<String, Object> map) {
		//setCountMapid("qkjmanage_getApplysCounts");
		return super.list("find_activenum", map);
	}
	

	/**
	 * 结果集只有一行的情况下适用
	 * 
	 * @param sqltext
	 * @return
	 */
	public Map commonSelectMap(String sqltext) {
		Map map = new HashMap();
		map.put("sqltext", sqltext);
		return (Map) super.get("commonSelectMapList", map);
	}
}