package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class CheckDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		//setCountMapid("check_getChecksCounts");
		return super.list("check_getChecks", map);
	}
	
	public List listGroByDate(Map<String, Object> map) {
		//setCountMapid("check_getChecksCounts");
		return super.list("check_getGroupByDate", map);
	}
	
	public List listGroByDatePower(Map<String, Object> map) {
		//setCountMapid("check_getChecksCounts");
		return super.list("check_getGroupByDatePower", map);
	}
	
	public List listByDate(Map<String, Object> map) {
		return super.list("check_getChecksByDate", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("check_getChecks", map);
	}

	public Object add(Object parameters) {
		return super.add("check_addCheck", parameters);
	}

	public int save(Object parameters) {
		return super.save("check_mdyCheck", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("check_delCheck", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
