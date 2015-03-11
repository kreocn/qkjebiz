package org.iweb.sys.cache;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.iweb.sys.ToolsUtil;

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

	@Override
	public void del(String key) {
		if (ToolsUtil.isEmpty(key)) return;
		if ("*".equals(key.substring(key.length() - 1))) {
			key = key.substring(0, key.length() - 1);
			for (Iterator<Map.Entry<String, Object>> it = cacheMap.entrySet().iterator(); it.hasNext();) {
				Map.Entry<String, Object> entry = it.next();
				if (entry.getKey().startsWith(key)) {
					it.remove();
				}
			}
		} else {
			cacheMap.remove(key);
		}
	}

	@Override
	public void clear() {
		cacheMap.clear();
	}
}
