package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class MarketDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getMarketsCout");
		return super.list("qkjmanage_getMarkets", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getMarkets", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addMarket", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyMarket", parameters);
	}
	
	public int saveay(Object parameters) {
		return super.save("qkjmanage_mdyMarketay", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delMarket", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
