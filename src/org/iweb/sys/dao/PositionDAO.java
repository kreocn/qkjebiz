package org.iweb.sys.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class PositionDAO extends AbstractDAO {

	public Object add(Object parameters) {
		return super.add("sys_addPosition", parameters);
	}

	public int save(Object parameters) {
		return super.save("sys_mdyPosition", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sys_delPosition", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sys_getPosition", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
