package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class TravelProductDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getTravelProductsCounts");
		return super.list("qkjmanage_getTravelProducts", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getTravelProducts", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addTravelProduct", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyTravelProduct", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delTravelProduct", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
