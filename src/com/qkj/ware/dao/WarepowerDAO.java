package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class WarepowerDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("warepower_getWarepowersCounts");
		return super.list("warepower_getWarepowers", map);
	}
	
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("warepower_getWarepowers", map);
	}

	public Object add(Object parameters) {
		return super.add("warepower_addWarepower", parameters);
	}

	public int save(Object parameters) {
		return super.save("warepower_mdyWarepower", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("warepower_delWarepower", parameters);
	}
	
	public List listUser(Map<String, Object> map) {
		return super.list("warepower_getUsers", map);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}
