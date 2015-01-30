package org.iweb.sys.cache;

public interface SysCache {
	public void put(String key, Object value);

	public void put(String key, Object value, boolean isOverride);

	public Object get(String key);

	public boolean contain(String key);

}
