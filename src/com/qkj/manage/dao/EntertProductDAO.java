package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class EntertProductDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		return super.list("qkjmanage_getEntertProducts", map);
	}
	

	/**
	 * 报表
	 * @return
	 */
	public List listReport(Map<String, Object> map){
		return super.list("qkjmanage_getEntertsReport", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addEntertProduct", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delEntertProduct", parameters);
	}
	
	
	
	public List listmem(Map<String, Object> map) {
		return super.list("qkjmanage_getEntertMems", map);
	}
	
	public Object addmem(Object parameters) {
		return super.add("qkjmanage_addEntertMem", parameters);
	}

	public int deletemem(Object parameters) {
		return super.delete("qkjmanage_delEntertmem", parameters);
	}
}
