package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class AllotDetailDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("allot_getAllotDetailsCounts");
		return super.list("allot_getAllotDetails", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("allot_getAllotDetails", map);
	}

	public Object add(Object parameters) {
		return super.add("allot_addAllotDetail", parameters);
	}

	public int save(Object parameters) {
		return super.save("allot_mdyAllotDetail", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("allot_delAllotDetail", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
