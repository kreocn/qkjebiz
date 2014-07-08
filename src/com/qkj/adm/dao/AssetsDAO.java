package com.qkj.adm.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class AssetsDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("adm_getAssetssCounts");
		return super.list("adm_getAssetss", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("adm_getAssetss", map);
	}

	public Object add(Object parameters) {
		return super.add("adm_addAssets", parameters);
	}

	public int save(Object parameters) {
		return super.save("adm_mdyAssets", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("adm_delAssets", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
