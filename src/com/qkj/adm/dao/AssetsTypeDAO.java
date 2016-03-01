package com.qkj.adm.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class AssetsTypeDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("adm_getAssetsTypesCounts");
		return super.list("adm_getAssetsTypes", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("adm_getAssetsTypes", map);
	}

	public Object add(Object parameters) {
		return super.add("adm_addAssetsType", parameters);
	}

	public int save(Object parameters) {
		return super.save("adm_mdyAssetsType", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("adm_delAssetsType", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
