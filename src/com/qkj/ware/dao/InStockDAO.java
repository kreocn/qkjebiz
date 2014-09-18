package com.qkj.ware.dao;
import java.util.*;

import org.iweb.sys.AbstractDAO;
public class InStockDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("inStock_getInStocksCounts");
		return super.list("inStock_getInStocks", map);
	}
	
	public List listbypo(Map<String, Object> map) {
		setCountMapid("inStock_getInStocksCountsByPower");
		return super.list("inStock_getIn", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("inStock_getInStocks", map);
	}

	public Object add(Object parameters) {
		return super.add("inStock_addInStock", parameters);
	}

	public int save(Object parameters) {
		return super.save("inStock_mdyInStock", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("inStock_delInStock", parameters);
	}
	
	public int mdyTotalPrice(String lading_id) {
		return super.save("qkjmanage_mdyTotalPrice", lading_id);
	}
	
	public int sure(Object parameters) {
		return super.save("inStock_mdySure", parameters);
	}
	public int send(Object parameters) {
		return super.save("inStock_mdySend", parameters);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}
