package com.qkjsys.ebiz.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class WareDAO extends AbstractDAO {

	public Object add(Object parameters) {
		return super.add("ebiz_addWare", parameters);
	}

	public int save(Object parameters) {
		return super.save("ebiz_mdyWare", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("ebiz_delWare", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("ebiz_getWares", map);
	}
	
	public List listByPower(Map<String, Object> map) {
		return super.list("ebiz_getPower", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
