package org.iweb.sys.cache;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.MenuDAO;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.RolePrvg;
import org.iweb.sys.domain.UserPrivilege;
import org.iweb.sys.encrypt.EncryptAES;
import org.iweb.sys.encrypt.EncryptFactory;

import com.qkj.manage.dao.ProTypeDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.ProType;
import com.qkj.manage.domain.Product;

/**
 * 缓存数据库中的数据到内存,全部采用JSON形式存储
 * 
 * @author 骏宇
 * 
 */
@SuppressWarnings("unchecked")
public final class SysDBCacheLogic extends SysCacheLogic {
	private static Log log = LogFactory.getLog(SysDBCacheLogic.class);

	// 防止重复,定义的key前缀
	// 角色前缀
	public final static String CACHE_ROLE_PREFIX = "role-";
	// 角色功能前缀
	public final static String CACHE_ROLE_FUNCTION_PREFIX = "role-function-";

	public synchronized void cacheRole(boolean delFlag) {
		// 是否需要先清空原缓存
		if (delFlag) {
			log.info("开始清空原角色缓存数据");
			cache.del(CACHE_ROLE_PREFIX + "*");
			cache.del(CACHE_ROLE_FUNCTION_PREFIX + "*");
			log.info("原角色缓存数据清空完毕");
		}
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

	public synchronized void cacheDept(boolean delFlag) {
		// 是否需要先清空原缓存
		if (delFlag) {
			log.info("开始清空原部门缓存数据");
			cache.del(CACHE_DEPT_PREFIX_SUB + "*");
			cache.del(CACHE_DEPT_PREFIX_PARENT + "*");
			log.info("原部门缓存数据清空完毕");
		}
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

	// 菜单前缀
	public final static String CACHE_MENU_PREFIX = "menu-";

	public synchronized void cacheMenu(boolean delFlag) {
		// 是否需要先清空原缓存
		if (delFlag) {
			log.info("开始清空原菜单缓存数据");
			cache.del(CACHE_MENU_PREFIX + "*");
			log.info("原菜单缓存数据清空完毕");
		}
		log.info("开始缓存菜单权限数据");
		MenuDAO dao = new MenuDAO();
		List<UserPrivilege> menus = dao.listSysMenu(null);
		for (Iterator<UserPrivilege> it = menus.iterator(); it.hasNext();) {
			UserPrivilege prvg = (UserPrivilege) it.next();
			cache.put(CACHE_MENU_PREFIX + prvg.getPrivilege_id(), JSONUtil.toJsonString(prvg));
		}
		log.info("缓存菜单权限数据完成");
	}

	// 子部门列表前缀
	public final static String CACHE_PRODTREE_PREFIX = "prodtree-";

	// 产品树缓存
	public synchronized void cacheProdTree(boolean delFlag) {
		// 是否需要先清空原缓存
		if (delFlag) {
			log.info("开始清空原产品树缓存数据");
			cache.del(CACHE_PRODTREE_PREFIX + "*");
			log.info("原产品缓存数据清空完毕");
		}
		log.info("开始缓存产品树数据");
		ProTypeDAO ptdao = new ProTypeDAO();
		ProType proType;
		Product product;
		List<ProType> proTypes = ptdao.list(null);
		ProductDAO pdao = new ProductDAO();
		List<Product> products = pdao.list(null);
		List<Integer> types = ptdao.getTypeCount();
		if (types.size() > 0) {
			StringBuffer fnode = new StringBuffer();
			StringBuffer allnode = new StringBuffer();
			StringBuffer[] typenode = new StringBuffer[types.size()];
			// 提供映射 数组下标->type_id
			int[] s_mapping = new int[types.size()];
			for (int k = 0; k < s_mapping.length; k++) {
				s_mapping[k] = types.get(k);
				typenode[k] = new StringBuffer();
				for (int i = 0; i < proTypes.size(); i++) {
					proType = proTypes.get(i);
					if (s_mapping[k] == proType.getType()) {
						allnode.append("{id:").append(proType.getUuid()).append(",pId:0, name:'").append(proType.getName()).append("',open:false},");
						typenode[k].append("{id:").append(proType.getUuid()).append(",pId:0, name:'").append(proType.getName()).append("',open:false},");
						for (int j = 0; j < products.size(); j++) {
							product = products.get(j);
							Integer uuid = proType.getUuid();
							if (uuid.equals(product.getBrand())) {
								allnode.append("{id:").append(uuid).append(product.getUuid()).append(", pId:").append(uuid).append(", name:'").append(product.getTitle())
										.append("',puuid:").append(product.getUuid()).append(",mp:'").append(ToolsUtil.getEmpty(product.getMarket_price())).append("',gp:'")
										.append(ToolsUtil.getEmpty(product.getGroup_price())).append("',dp:'").append(ToolsUtil.getEmpty(product.getDealer_price()))
										.append("',a1:'").append(ToolsUtil.getEmpty(product.getAgree_price_1())).append("',a2:'")
										.append(ToolsUtil.getEmpty(product.getAgree_price_2())).append("',a3:'").append(ToolsUtil.getEmpty(product.getAgree_price_3()))
										.append("',case_spec:").append(ToolsUtil.getEmpty(product.getCase_spec())).append("},");
								JSONObject json = JSONObject.fromObject(product);
								json.put("id", uuid + product.getUuid());
								json.put("pId", uuid);
								json.put("name", product.getTitle());
								typenode[k].append(json.toString() + ",");
							}
						}
					}
				}
			}
			allnode.deleteCharAt(allnode.length() - 1).insert(0, "[").insert(allnode.length(), "]");
			fnode.append("var zNodes=").append(allnode).append(";");
			// 对产品树进行AES加密
			EncryptAES aes = (EncryptAES) EncryptFactory.getEncrypt("AES");
			for (int i = 0; i < s_mapping.length; i++) {
				typenode[i].deleteCharAt(typenode[i].length() - 1).insert(0, "[").insert(typenode[i].length(), "]");
				fnode.append("var zNodes").append(s_mapping[i]).append("=").append(typenode[i]).append(";");
				// 生成独立JSON
				cache.put(CACHE_PRODTREE_PREFIX + s_mapping[i], aes.encrypt(typenode[i].toString()));
			}
			log.info("缓存产品树数据完成");
		} else {
			log.info("缓存产品树数据完成:还没有产品");
		}
	}
}
