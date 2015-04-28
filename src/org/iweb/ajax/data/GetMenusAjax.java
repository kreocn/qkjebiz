/**
 * 
 */
package org.iweb.ajax.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysCache;
import org.iweb.sys.cache.SysDBCacheLogic;
import org.iweb.sys.domain.UserPrivilege;
import org.iweb.sys.logic.ComparatorUserPrivileges;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-6 下午4:17:02
 */
public class GetMenusAjax extends Ajax {
	private static Log log = LogFactory.getLog(GetMenusAjax.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.iweb.ajax.data.Ajax#getResult()
	 */
	@Override
	public Object getResult() {
		if (ContextHelper.checkLoginStatus()) {
			List<UserPrivilege> menus = null;
			try {
				menus = getMenus();
				log.info("读取菜单成功." + ContextHelper.getUserLoginName());
			} catch (Exception e) {
				log.error("NOMENU_DATA:", e);
			}
			if (menus == null || menus.size() == 0) return NODATA;
			return menus;
		} else {
			return NOLOGIN;
		}
	}

	private ArrayList<UserPrivilege> getMenus() {
		SysCache cache = CacheFactory.getCacheInstance();
		ArrayList<UserPrivilege> menus = new ArrayList<>();
		if (ContextHelper.isAdmin()) {
			menus = (ArrayList<UserPrivilege>) cache.get(SysDBCacheLogic.CACHE_MENU_PREFIX + "*");
		} else {
			Set<String> prvgs = ContextHelper.getUserLoginPermits().keySet();
			for (Iterator<String> it = prvgs.iterator(); it.hasNext();) {
				String p = (String) it.next();
				UserPrivilege u = (UserPrivilege) JSONUtil.toObject((String) cache.get(SysDBCacheLogic.CACHE_MENU_PREFIX + p), UserPrivilege.class);
				if (u != null) menus.add(u);
			}
			ComparatorUserPrivileges compare = new ComparatorUserPrivileges();
			Collections.sort(menus, compare);
		}
		return menus;
	}

}