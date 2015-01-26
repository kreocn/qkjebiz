package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class LadingProductgDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getLadingProductgsCounts");
		return super.list("qkjmanage_getLadingProductgs", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addLadingProductg", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyLadingProductg", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delLadingProductg", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
