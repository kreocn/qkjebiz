package com.qkjsys.ebiz.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class OrderActnDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getOrderActnsCounts");
		return super.list("sysebiz_getOrderActns", map);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addOrderActn", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyOrderActn", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delOrderActn", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
