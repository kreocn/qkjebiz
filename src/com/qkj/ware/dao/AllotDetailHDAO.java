package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class AllotDetailHDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("ware_getAllotDetailHsCounts");
		return super.list("ware_getAllotDetailHs", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("ware_getAllotDetailHs", map);
	}

	public Object add(Object parameters) {
		return super.add("ware_addAllotDetailH", parameters);
	}

	public int save(Object parameters) {
		return super.save("ware_mdyAllotDetailH", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ware_delAllotDetailH", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
