package com.qkj.adm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class LeaveDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("adm_getLeavesCounts");
		return super.list("adm_getLeaves", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("adm_getLeaves", map);
	}

	public Object add(Object parameters) {
		return super.add("adm_addLeave", parameters);
	}

	public int save(Object parameters) {
		return super.save("adm_mdyLeave", parameters);
	}

	public int check(Object parameters) {
		return super.save("adm_mdyLeaveCheck", parameters);
	}

	public int acheck(Object parameters) {
		return super.save("adm_mdyLeaveACheck", parameters);
	}

	public int allowance(Object parameters) {
		return super.save("adm_mdyLeaveAllowance", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("adm_delLeave", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
