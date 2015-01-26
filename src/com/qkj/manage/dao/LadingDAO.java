package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class LadingDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getLadingsCounts");
		return super.list("qkjmanage_getLadings", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getLadings", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addLading", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyLading", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delLading", parameters);
	}

	public int mdyLadingStatus(Object parameters) {
		return super.save("qkjmanage_mdyLadingStatus", parameters);
	}

	public int mdyLadingManagerCheck(Object parameters) {
		return super.save("qkjmanage_mdyLadingManagerCheck", parameters);
	}

	public int mdyLadingSDCheck(Object parameters) {
		return super.save("qkjmanage_mdyLadingSDCheck", parameters);
	}

	public int mdyLadingMDCheck(Object parameters) {
		return super.save("qkjmanage_mdyLadingMDCheck", parameters);
	}

	public int mdyLadingFDCheck(Object parameters) {
		return super.save("qkjmanage_mdyLadingFDCheck", parameters);
	}

	public int mdyLadingCOOCheck(Object parameters) {
		return super.save("qkjmanage_mdyLadingCOOCheck", parameters);
	}

	public int mdyLadingTotalPrice(Integer lading_id) {
		return super.save("qkjmanage_mdyLadingTotalPrice", lading_id);
	}

	public int mdyLadingTotalPriceg(Integer lading_id) {
		return super.save("qkjmanage_mdyLadingTotalPriceg", lading_id);
	}

	public int mdyLadingOutFlag(Object parameters) {
		return super.save("qkjmanage_mdyLadingOutFlag", parameters);
	}

	public int mdyLadingRebatesFlag(Object parameters) {
		return super.save("qkjmanage_mdyLadingRebatesFlag", parameters);
	}

	public int mdyLadingRebatesFlagByRebatesID(Map<String, Object> map) {
		return super.save("qkjmanage_mdyLadingRebatesFlagByRebatesID", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
