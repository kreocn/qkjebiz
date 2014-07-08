package org.iweb.sysvip.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class InfoDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getInfosCounts");
		return super.list("sysvip_getInfos", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("sysvip_getInfos", map);
	}

	public Object add(Object parameters) {
		return super.add("sysvip_addInfo", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyInfo", parameters);
	}

	public int reMsg(Object parameters) {
		return super.save("sysvip_reMsg", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delInfo", parameters);
	}

	public int checkInfo(Object parameters) {
		return super.save("sysvip_checkInfo", parameters);
	}

	public int recycleInfo(Object parameters) {
		return super.save("sysvip_recycleInfo", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
