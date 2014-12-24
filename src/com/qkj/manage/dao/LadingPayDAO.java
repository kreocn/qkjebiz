package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class LadingPayDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanager_getLadingPaysCounts");
		return super.list("qkjmanager_getLadingPays", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanager_getLadingPays", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanager_addLadingPay", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanager_mdyLadingPay", parameters);
	}

	public int fd_check(Object parameters) {
		return super.save("qkjmanager_LadingPay_FdCheck", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanager_delLadingPay", parameters);
	}

	public Double getLadingPaysMoneys(Integer lading_id) {
		return (Double) super.get("qkjmanager_getLadingPaysMoneys", lading_id);
	}

	//

	public int getResultCount() {
		return super.getResultCount();
	}
}
