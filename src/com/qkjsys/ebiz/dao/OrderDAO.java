package com.qkjsys.ebiz.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class OrderDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getOrdersCounts");
		return super.list("sysebiz_getOrders", map);
	}

	public Object get(Map<String, Object> map) {
		return super.get("sysebiz_getOrders", map);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addOrder", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyOrder", parameters);
	}

	public int saveStatus(Object parameters) {
		return super.save("sysebiz_mdyStatus", parameters);
	}

	public int savePayStatus(Object parameters) {
		return super.save("sysebiz_mdyPayStatus", parameters);
	}

	public int saveTotalPrice(String order_id) {
		return super.save("sysebiz_mdyTotalPrice", order_id);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delOrder", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
