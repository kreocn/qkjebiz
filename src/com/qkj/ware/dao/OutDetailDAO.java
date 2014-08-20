package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class OutDetailDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("outDetail_getOutDetailsCounts");
		return super.list("outDetail_getOutDetails", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("outDetail_getOutDetails", map);
	}

	public Object add(Object parameters) {
		return super.add("outDetail_addOutDetail", parameters);
	}

	public int save(Object parameters) {
		return super.save("outDetail_mdyOutDetail", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("outDetail_delOutDetail", parameters);
	}
	public int deleteByLading(Map<String, Object> map) {
		return super.delete("outDetail_delLading", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
