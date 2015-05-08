package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class StoresDao extends AbstractDAO {
	public List list(Map<String, Object> map) {
		super.setDb_num(1);
		List list=super.list("qkjStores_getProducts", map);
		return list;
	}
	public Object add(Object parameters) {
		super.setDb_num(1);
		Object ob=super.add("qkjStores_addProducts", parameters);
		return ob;
	}
	public Object addO(Object parameters) {
		super.setDb_num(1);
		Object ob=super.add("qkjStores_addOrder", parameters);
		return ob;
	}
}
