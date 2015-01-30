package org.iweb.sys.cache;

public class CacheFactory {

	private static SysCache cache;

	public static SysCache getCacheInstance() {
		if (cache == null) {
			cache = new SysCacheSimpleLocation();
		}
		return cache;
	}
}
