package com.qkj.manage.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class ProductDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getProductsCounts");
		return super.list("qkjmanage_getProducts", map);
	}
	public List listdb1(Map<String, Object> map) {
		super.setDb_num(1);
		setCountMapid("qkjmanage_getProductsCounts");
		return super.list("qkjmanage_getProducts", map);
	}
	public Object add(Object parameters) {
		return super.add("qkjmanage_addProduct", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyProduct", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delProduct", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
	
	public List listReport(Map<String, Object> map) {
		super.setDb_num(1);
		return super.list("qkjmanage_getReportStroesOrder", map);
	}
	
}
