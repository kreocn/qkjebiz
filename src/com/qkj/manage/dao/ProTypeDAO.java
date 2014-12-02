package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class ProTypeDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getProTypesCounts");
		return super.list("qkjmanage_getProTypes", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getProTypes", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addProType", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyProType", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delProType", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
