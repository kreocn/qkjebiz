package org.iweb.sys.cache;

public class CacheFactory {

	private static SysCache cache;

	public static SysCache getCacheInstance() {
		if (cache == null) {
			cache = new SysCacheSimpleLocation();
		}
		return cache;
	}

	/**
	 * 缓存流
	 * 
	 * @param cacheMode
	 */
	public static void CacheFlow(String cacheMode) {
		SysCacheLogic cacheLogic = new SysCacheLogic();
		SysDBCacheLogic dbCacheLogic = new SysDBCacheLogic();

		if ("sys".equals(cacheMode)) {
			// 系统参数缓存
			cacheLogic.cacheSys(true);
		} else if ("role".equals(cacheMode)) {
			// 角色数据缓存
			dbCacheLogic.cacheRole(true);
		} else if ("dept".equals(cacheMode)) {
			// 部门数据缓存
			dbCacheLogic.cacheDept(true);
		} else if ("menu".equals(cacheMode)) {
			// 菜单数据缓存
			dbCacheLogic.cacheMenu(true);
		} else if ("prod-tree".equals(cacheMode)) {
			// 产品树数据缓存
			dbCacheLogic.cacheProdTree(true);
		} else if ("all".equals(cacheMode)) {
			dbCacheLogic.clearAllCache();
			cacheLogic.cacheSys(false);
			dbCacheLogic.cacheRole(false);
			dbCacheLogic.cacheDept(false);
			dbCacheLogic.cacheMenu(false);
			dbCacheLogic.cacheProdTree(false);
		}
	}
}
