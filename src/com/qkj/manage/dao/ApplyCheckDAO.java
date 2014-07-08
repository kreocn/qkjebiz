package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class ApplyCheckDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getApplyChecksCounts");
		return super.list("qkjmanage_getApplyChecks", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getApplyChecks", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addApplyCheck", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyApplyCheck", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delApplyCheck", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
