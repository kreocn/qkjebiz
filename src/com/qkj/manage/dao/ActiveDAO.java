package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ActiveDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getActivesCounts");
		return super.list("qkjmanage_getActives", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getActives", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addActive", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyActive", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delActive", parameters);
	}

	public int mdyActiveStatus(Object parameters) {
		return super.save("qkjmanage_mdyActiveStatus", parameters);
	}

	public int mdyActiveSDStatus(Object parameters) {
		return super.save("qkjmanage_mdyActiveSDStatus", parameters);
	}

	public int mdyActiveSMDStatus(Object parameters) {
		return super.save("qkjmanage_mdyActiveSMDStatus", parameters);
	}

	public int mdyActiveItPrice(String active_id) {
		return super.save("qkjmanage_mdyActiveItPrice", active_id);
	}

	public int mdyActiveMtPrice(String active_id) {
		return super.save("qkjmanage_mdyActiveMtPrice", active_id);
	}

	public int mdyActivePass(Object parameters) {
		return super.save("qkjmanage_mdyActivePass", parameters);
	}

	public int mdyCloseActivePass(Object parameters) {
		return super.save("qkjmanage_mdyCloseActivePass", parameters);
	}

	/********** 结案流程开始 **********/
	public int startActiveCloseFlow(Object parameters) {
		return super.save("qkjmanage_startActiveCloseFlow", parameters);
	}

	public int mdyCloseActive(Object parameters) {
		return super.save("qkjmanage_mdyCloseActive", parameters);
	}

	public int mdyCloseActiveSDStatus(Object parameters) {
		return super.save("qkjmanage_mdyCloseActiveSDStatus", parameters);
	}

	public int mdyCloseActiveSMDStatus(Object parameters) {
		return super.save("qkjmanage_mdyCloseActiveSMDStatus", parameters);
	}

	public int mdyActiveCloseItPrice(String active_id) {
		return super.save("qkjmanage_mdyActiveCloseItPrice", active_id);
	}

	public int mdyActiveCloseMtPrice(String active_id) {
		return super.save("qkjmanage_mdyActiveCloseMtPrice", active_id);
	}

	// 发货信息修改
	public int mdyShipInfo(Object parameters) {
		return super.save("qkjmanage_mdyShipInfo", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
