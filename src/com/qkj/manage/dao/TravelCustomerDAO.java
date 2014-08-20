package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class TravelCustomerDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getTravelCustomersCounts");
		return super.list("qkjmanage_getTravelCustomers", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getTravelCustomers", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addTravelCustomer", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyTravelCustomer", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delTravelCustomer", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
