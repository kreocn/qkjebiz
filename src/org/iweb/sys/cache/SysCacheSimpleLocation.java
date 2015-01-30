package org.iweb.sys.cache;

import java.util.HashMap;
import java.util.Map;

public class SysCacheSimpleLocation implements SysCache {
	private static Map<String, Object> cacheMap;

	static {
		cacheMap = new HashMap<>();
	}

	@Override
	public void put(String key, Object value) {
		cacheMap.put(key, value);
	}

	@Override
	public void put(String key, Object value, boolean isOverride) {
		if (!cacheMap.containsKey(key) || isOverride) put(key, value);
	}

	@Override
	public Object get(String key) {
		return cacheMap.get(key);
	}

	@Override
	public boolean contain(String key) {
		return cacheMap.containsKey(key);
	}

}
