package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ApplyDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getApplysCounts");
		return super.list("qkjmanage_getApplys", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getApplys", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addApply", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyApply", parameters);
	}

	public int check(Object parameters) {
		return super.save("qkjmanage_checkApply", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delApply", parameters);
	}

	public int spcheck(Object parameters) {
		return super.save("qkjmanage_spcheckApply", parameters);
	}

	// 发货信息修改
	public int mdyShipInfo(Object parameters) {
		return super.save("qkjmanage_mdyApplyShipInfo", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
