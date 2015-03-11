package com.qkj.manage.dao;
import java.util.*;

import org.iweb.sys.AbstractDAO;
public class CloseOrderDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getCloseOrdersCounts");
		return super.list("qkjmanage_getCloseOrders", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getCloseOrders", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addCloseOrder", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyCloseOrder", parameters);
	}
	
	public int updateTotal(int order_id) {
		return super.save("qkjmanage_mdyCloseOrdertotelPrice", order_id);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delCloseOrder", parameters);
	}
	
	public int check(Object parameters) {
		return super.save("qkjmanage_mdyCloseCheck", parameters);
	}
	
	public int checknd(Object parameters) {
		return super.save("qkjmanage_mdyClosendCheck", parameters);
	}

	public List allsign(Map<String, Object> map) {
		return super.list("qkjmanage_getallclosesign", map);
	}
	
	public Object sign(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("biz_id", uuid);
		return super.get("qkjmanage_getclosesign", map);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}
