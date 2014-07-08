package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class LadingItemDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getLadingItemsCounts");
		return super.list("qkjmanage_getLadingItems", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addLadingItem", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyLadingItem", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delLadingItem", parameters);
	}

	public List listSumByRebatesID(Integer rebates_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("rebates_id", rebates_id);
		return super.list("qkjmanage_getLadingItemSumByRebatesID", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
