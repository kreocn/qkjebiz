package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class OutDetailHDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("ware_getOutDetailHsCounts");
		return super.list("ware_getOutDetailHs", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("ware_getOutDetailHs", map);
	}

	public Object add(Object parameters) {
		return super.add("ware_addOutDetailH", parameters);
	}

	public int save(Object parameters) {
		return super.save("ware_mdyOutDetailH", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ware_delOutDetailH", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
