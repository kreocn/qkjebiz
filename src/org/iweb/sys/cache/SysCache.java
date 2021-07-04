package org.iweb.sys.cache;

public interface SysCache {
	public void put(String key, Object value);

	public void put(String key, Object value, boolean isOverride);

	public Object get(String key);

	public Object get(String key, Class<?> cls);

	public void del(String key);

	public void clear();

	public boolean contain(String key);

}
