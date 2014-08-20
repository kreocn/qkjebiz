package com.qkjsys.ebiz.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class OrderGoodsDAO extends AbstractDAO {

	@SuppressWarnings("rawtypes")
	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getOrderGoodssCounts");
		return super.list("sysebiz_getOrderGoodss", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("sysebiz_getOrderGoodss", map);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addOrderGoods", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyOrderGoods", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delOrderGoods", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
