package com.qkj.manage.dao;


import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ApplyPosmDAO extends AbstractDAO {
	public Object add(Object parameters) {
		return super.add("qkjmanage_addApplyPosm", parameters);
	}
	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getApplyPosmsCounts");
		return super.list("qkjmanage_getApplyPosms", map);
	}
	public int delete(Object parameters) {
		return super.delete("qkjmanage_delApplyPosm", parameters);
	}
}
