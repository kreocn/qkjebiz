package com.qkj.adm.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class FixAssetsDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("adm_getFixAssetssCounts");
		return super.list("adm_getFixAssetss", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("adm_getFixAssetss", map);
	}

	public Object add(Object parameters) {
		return super.add("adm_addFixAssets", parameters);
	}

	public int save(Object parameters) {
		return super.save("adm_mdyFixAssets", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("adm_delFix Assets", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
