package org.iweb.common.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class MenuDAO extends AbstractDAO {
	public List listSysMenu(Map<String, Object> map) {
		return super.list("sys_getSysMenus", map);
	}
	
	public List listUserMenu(Map<String, Object> map) {
		return super.list("sys_getUserMenus", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
