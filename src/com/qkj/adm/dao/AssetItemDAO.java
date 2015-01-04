package com.qkj.adm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class AssetItemDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("adm_getAssetItemsCounts");
		return super.list("adm_getAssetItems", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("adm_getAssetItems", map);
	}

	public Object add(Object parameters) {
		return super.add("adm_addAssetItem", parameters);
	}

	public Object addSimilar(Object parameters) {
		return super.add("adm_addAssetItemSimilar", parameters);
	}

	public int save(Object parameters) {
		return super.save("adm_mdyAssetItem", parameters);
	}

	public int own(Object parameters) {
		return super.save("adm_ownAssetItem", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("adm_delAssetItem", parameters);
	}
	
	public List getPrint(Map<String, Object> map) {
		return super.list("adm_getAssetItemsPrint", map);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}
