package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class CloseOrderProDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getCloseOrderProsCounts");
		return super.list("qkjmanage_getCloseOrderPros", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getCloseOrderPros", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addCloseOrderPro", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyCloseOrderPro", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delCloseOrderPro", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
