package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class RebatesProductDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getRebatesProductsCounts");
		return super.list("qkjmanage_getRebatesProducts", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addRebatesProduct", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyRebatesProduct", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delRebatesProduct", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
