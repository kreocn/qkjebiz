package org.iweb.sys.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.RolePrvg;

/**
 * 缓存数据库中的数据到内存
 * 
 * @author 骏宇
 * 
 */
public final class SysDBCacheLogic {
	private static Log log = LogFactory.getLog(SysDBCacheLogic.class);
	private static SysCache cache = CacheFactory.getCacheInstance();

	// 防止重复,定义的key前缀
	// 角色前缀
	public final static String CACHE_ROLE_PREFIX = "role-";
	// 角色功能前缀
	public final static String CACHE_ROLE_FUNCTION_PREFIX = "role-function-";

	public void cacheRole() {
		log.info("开始缓存角色权限数据");
		UserRoleDAO dao = new UserRoleDAO();
		Map<String, String> m = new HashMap<>();
		@SuppressWarnings("unchecked")
		List<RolePrvg> l = (List<RolePrvg>) dao.listRolePrvg(null);
		for (int i = 0, n = l.size(); i < n; i++) {
			RolePrvg t = l.get(i);
			cacheRoleMap(m, CACHE_ROLE_PREFIX + t.getRole_id(), t.getPrivilege_id());
			if (!ToolsUtil.isEmpty(t.getFunction())) {
				cache.put(CACHE_ROLE_FUNCTION_PREFIX + t.getRole_id() + t.getPrivilege_id(), t.getFunction());
				// cacheRoleMap(m, CACHE_ROLE_FUNCTION_PREFIX + t.getUuid() + t.getPrivilege_id(), t.getFunction());
			}
		}
		if (m.size() > 0) {
			for (Map.Entry<String, String> entry : m.entrySet()) {
				cache.put(entry.getKey(), entry.getValue());
				// System.out.println("ROLE_KEY:" + entry.getKey() + "\nROLE_VALUE" + entry.getValue());
			}
		}
		m = null;
		log.info("缓存角色权限数据完成");
	}

	private void cacheRoleMap(Map<String, String> m, String key, String value) {
		if (m.containsKey(key)) {
			m.put(key, m.get(key) + value + ",");
		} else {
			m.put(key, value + ",");
		}
	}
}
