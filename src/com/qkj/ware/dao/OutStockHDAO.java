package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class OutStockHDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("ware_getOutStockHsCounts");
		return super.list("ware_getOutStockHs", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("ware_getOutStockHs", map);
	}

	public Object add(Object parameters) {
		return super.add("ware_addOutStockH", parameters);
	}

	public int save(Object parameters) {
		return super.save("ware_mdyOutStockH", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ware_delOutStockH", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
