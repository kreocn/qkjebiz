package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class AllotHDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("ware_getAllotHsCounts");
		return super.list("ware_getAllotHs", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("ware_getAllotHs", map);
	}

	public Object add(Object parameters) {
		return super.add("ware_addAllotH", parameters);
	}

	public int save(Object parameters) {
		return super.save("ware_mdyAllotH", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ware_delAllotH", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
