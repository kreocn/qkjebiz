package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class StoresOrederDAO extends AbstractDAO{
	
	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getProductsCounts");
		return super.list("qkjmanage_getProducts", map);
	}
	public int getResultCount() {
		return super.getResultCount();
	}
}
