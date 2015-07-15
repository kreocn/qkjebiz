package com.qkj.manage.dao;


import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ApplyProductDAO extends AbstractDAO {
	public Object add(Object parameters) {
		return super.add("qkjmanage_addApplyProduct1", parameters);
	}
	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getApplyProductsCounts");
		return super.list("qkjmanage_getApplyProducts", map);
	}
	
	public int delete(Object parameters) {
		return super.delete("qkjmanage_delApplyProduct", parameters);
	}
}
