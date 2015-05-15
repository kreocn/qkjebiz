package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class StoresOrderDAO extends AbstractDAO{
	
	public List list(Map<String, Object> map) {
		super.setDb_num(1);
		return super.list("qkjStores_getStoresOrder", map);
	}
	public Object add(Object parameters) {
		super.setDb_num(1);
		Object ob=super.add("qkjStores_addStoresOrder", parameters);
		return ob;
	}
	public int save(Object parameters) {
		super.setDb_num(1);
		return super.save("qkjStores_SaveStoresOrder", parameters);
	}
	public int getResultCount() {
	
		return super.getResultCount();
	}
}
