package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class BordetailDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("bordetail_getBordetailsCounts");
		return super.list("bordetail_getBordetails", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("bordetail_getBordetails", map);
	}

	public Object add(Object parameters) {
		return super.add("bordetail_addBordetail", parameters);
	}

	public int save(Object parameters) {
		return super.save("bordetail_mdyBordetail", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("bordetail_delBordetail", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
