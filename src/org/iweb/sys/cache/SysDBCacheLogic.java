package org.iweb.sys.cache;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.RolePrvg;

/**
 * 缓存数据库中的数据到内存,全部采用JSON形式存储
 * 
 * @author 骏宇
 * 
 */
@SuppressWarnings("unchecked")
public final class SysDBCacheLogic {
	private static Log log = LogFactory.getLog(SysDBCacheLogic.class);
	private static SysCache cache = CacheFactory.getCacheInstance();

	// 防止重复,定义的key前缀
	// 角色前缀
	public final static String CACHE_ROLE_PREFIX = "role-";
	// 角色功能前缀
	public final static String CACHE_ROLE_FUNCTION_PREFIX = "role-function-";

	public synchronized void cacheRole() {
		log.info("开始缓存角色权限数据");
		UserRoleDAO dao = new UserRoleDAO();
		Map<String, String> m = new HashMap<>();
		List<RolePrvg> l = (List<RolePrvg>) dao.listRolePrvg(null);
		for (Iterator<RolePrvg> it = l.iterator(); it.hasNext();) {
			RolePrvg rolePrvg = (RolePrvg) it.next();
			cacheMap(m, CACHE_ROLE_PREFIX + rolePrvg.getRole_id(), rolePrvg.getPrivilege_id());
			if (!ToolsUtil.isEmpty(rolePrvg.getFunction())) {
				cache.put(CACHE_ROLE_FUNCTION_PREFIX + rolePrvg.getRole_id() + rolePrvg.getPrivilege_id(), rolePrvg.getFunction());
			}
		}
		cacheValue2JSON(m);
		log.info("缓存角色权限数据完成");
	}

	// 子部门列表前缀
	public final static String CACHE_DEPT_PREFIX_SUB = "dept-sub-";
	// 父部门列表前缀
	public final static String CACHE_DEPT_PREFIX_PARENT = "dept-parent-";

	public synchronized void cacheDept() {
		log.info("开始缓存部门数据");
		DepartmentDAO dao = new DepartmentDAO();
		List<Department> l = dao.list(null);
		// 建立一个特殊的map key:value dept_code:parent_dept
		Map<String, String> m = new HashMap<>();
		for (Iterator<Department> it = l.iterator(); it.hasNext();) {
			Department dept = (Department) it.next();
			m.put(dept.getDept_code(), dept.getParent_dept());
		}
		// 开始遍历
		Map<String, String> sub_map = new HashMap<>();
		Map<String, String> parent_map = new HashMap<>();
		for (Iterator<Map.Entry<String, String>> it = m.entrySet().iterator(); it.hasNext();) {
			Map.Entry<String, String> d1 = (Map.Entry<String, String>) it.next();
			for (Iterator<Map.Entry<String, String>> it2 = m.entrySet().iterator(); it2.hasNext();) {
				Map.Entry<String, String> d2 = (Map.Entry<String, String>) it2.next();
				if (ToolsUtil.checkParent(m, d2.getKey(), d1.getKey())) {
					cacheMap(sub_map, CACHE_DEPT_PREFIX_SUB + d1.getKey(), d2.getKey());
				}
				if (ToolsUtil.checkParent(m, d1.getKey(), d2.getKey())) {
					cacheMap(parent_map, CACHE_DEPT_PREFIX_PARENT + d1.getKey(), d2.getKey());
				}
			}
		}
		cacheValue2JSON(sub_map);
		cacheValue2JSON(parent_map);
		log.info("缓存部门数据完成");
	}

	/**
	 * 碰到相同的值,则value用","分开保存,而不是覆盖
	 * 
	 * @param m
	 * @param key
	 * @param value
	 */
	private void cacheMap(Map<String, String> m, String key, String value) {
		if (m.containsKey(key)) {
			m.put(key, m.get(key) + value + ",");
		} else {
			m.put(key, value + ",");
		}
	}

	/**
	 * 把用","分开的value,重新保存为Array形式的JSON字符串
	 * 
	 * @param m
	 */
	private void cacheValue2JSON(Map<String, String> m) {
		// System.out.println("========================================");
		if (m.size() > 0) {
			for (Map.Entry<String, String> entry : m.entrySet()) {
				String val = entry.getValue();
				if (val.length() > 1) {
					val = val.substring(0, val.length() - 1);
					val = JSONUtil.toJsonString(val.split(","));
				} else {
					val = null;
				}
				// System.out.println(entry.getKey() + ":" + val);
				cache.put(entry.getKey(), val);
			}
		}
		// System.out.println("========================================");
	}
}
