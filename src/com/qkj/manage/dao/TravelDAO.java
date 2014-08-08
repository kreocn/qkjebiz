package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class TravelDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getTravelsCounts");
		return super.list("qkjmanage_getTravels", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getTravels", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addTravel", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyTravel", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delTravel", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
