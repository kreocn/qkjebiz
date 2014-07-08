package com.qkjsys.ebiz.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class GoodsTypeDAO extends AbstractDAO {

	public Object add(Object parameters) {
		return super.add("ebiz_addGoodsType", parameters);
	}

	public int save(Object parameters) {
		return super.save("ebiz_mdyGoodsType", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ebiz_delGoodsType", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("ebiz_getGoodsTypes", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
