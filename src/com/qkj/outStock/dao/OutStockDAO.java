package com.qkj.outStock.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class OutStockDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("outStock_getOutStocksCounts");
		return super.list("outStock_getOutStocks", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("outStock_getOutStocks", map);
	}

	public Object add(Object parameters) {
		return super.add("outStock_addOutStock", parameters);
	}

	public int save(Object parameters) {
		return super.save("outStock_mdyOutStock", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("outStock_delOutStock", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
