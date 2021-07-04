package org.iweb.sys.cache;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;

public class SysCacheSimpleLocation implements SysCache {
	private static Map<String, Object> cacheMap;

	static {
		cacheMap = Collections.synchronizedMap(new LinkedHashMap<String, Object>());
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
		if (ToolsUtil.isEmpty(key)) return null;
		if ("*".equals(key.substring(key.length() - 1))) {
			ArrayList<Object> l = new ArrayList<>();
			key = key.substring(0, key.length() - 1);
			for (Iterator<Map.Entry<String, Object>> it = cacheMap.entrySet().iterator(); it.hasNext();) {
				Map.Entry<String, Object> entry = it.next();
				if (entry.getKey().startsWith(key)) {
					l.add(entry.getValue());
				}
			}
			return l;
		} else {
			return cacheMap.get(key);
		}
	}

	/**
	 * 只针对存储JSON的缓存
	 */
	@Override
	public Object get(String key, Class<?> cls) {
		if (ToolsUtil.isEmpty(key)) return null;
		if ("*".equals(key.substring(key.length() - 1))) {
			ArrayList<Object> l = new ArrayList<>();
			key = key.substring(0, key.length() - 1);
			for (Iterator<Map.Entry<String, Object>> it = cacheMap.entrySet().iterator(); it.hasNext();) {
				Map.Entry<String, Object> entry = it.next();
				if (entry.getKey().startsWith(key)) {
					l.add(JSONUtil.toObject((String) entry.getValue(), cls));
				}
			}
			return l;
		} else {
			return JSONUtil.toObject((String) cacheMap.get(key), cls);
		}
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
