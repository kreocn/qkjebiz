package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class InDetailHDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("ware_getInDetailHsCounts");
		return super.list("ware_getInDetailHs", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("ware_getInDetailHs", map);
	}

	public Object add(Object parameters) {
		return super.add("ware_addInDetailH", parameters);
	}

	public int save(Object parameters) {
		return super.save("ware_mdyInDetailH", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ware_delInDetailH", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
