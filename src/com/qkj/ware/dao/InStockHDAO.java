package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class InStockHDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("ware_getInStockHsCounts");
		return super.list("ware_getInStockHs", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("ware_getInStockHs", map);
	}

	public Object add(Object parameters) {
		return super.add("ware_addInStockH", parameters);
	}

	public int save(Object parameters) {
		return super.save("ware_mdyInStockH", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ware_delInStockH", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
