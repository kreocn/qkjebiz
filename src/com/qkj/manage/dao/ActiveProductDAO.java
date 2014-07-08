package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ActiveProductDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getActiveProductsCounts");
		return super.list("qkjmanage_getActiveProducts", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addActiveProduct", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delActiveProduct", parameters);
	}
}
