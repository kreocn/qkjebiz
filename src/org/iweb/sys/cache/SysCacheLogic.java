package org.iweb.sys.cache;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.JSONUtil;

public class SysCacheLogic {
	private static Log log = LogFactory.getLog(SysCacheLogic.class);
	protected static SysCache cache = CacheFactory.getCacheInstance();
	private static String absolutePath;
	private static String relativePath;

	// 防止重复,定义的key前缀
	// 角色前缀
	public final static String CACHE_SYS_PREFIX = "sys-";

	/**
	 * 必须用带参数的构造函数之后,才能用这个构造函数重建
	 */
	public SysCacheLogic() {
	}

	/**
	 * 初始化系统参数必须用这个构造函数
	 * 
	 * @param absolutePath
	 * @param relativePath
	 */
	public SysCacheLogic(String absolutePath, String relativePath) {
		SysCacheLogic.absolutePath = absolutePath;
		SysCacheLogic.relativePath = relativePath;
	}

	public synchronized void cacheSys(boolean delFlag) {
		// 是否需要先清空原缓存
		if (delFlag) {
			log.info("开始清空原系统缓存数据");
			cache.del(CACHE_SYS_PREFIX + "*");
			log.info("原系统缓存数据清空完毕");
		}
		log.info("开始缓存系统参数.");
		try {
			cache.put(CACHE_SYS_PREFIX + "WebAbsolutePath", SysCacheLogic.absolutePath);
			cache.put(CACHE_SYS_PREFIX + "WebRelativePath", SysCacheLogic.relativePath);
			File f = new File(cache.get(CACHE_SYS_PREFIX + "WebAbsolutePath") + "WEB-INF/sys.properties");
			if (f.exists()) {
				Properties p = new Properties();
				p.load(new InputStreamReader(new FileInputStream(f), "UTF-8"));
				for (Map.Entry<Object, Object> entry : p.entrySet())
					cache.put((String) entry.getKey(), entry.getValue());
				if (!cache.contain("fileUploadRoot")) log.warn("参数:fileUploadRoot 未发现,上传文件功能可能无法使用!");
				else if (!(new File((String) cache.get("fileUploadRoot")).exists())) log.warn("参数:fileUploadRoot 所配置路径不存在,上传功能可能无法使用。请到/WEB-INF/sys.properties中配置正确的路径。");
				else log.warn("系统参数配置文件不存在,加载失败!");
			}
		} catch (Exception e) {
			log.error("读取配置文件错误,请检查系统配置.", e);
		}
		log.info("系统参数缓存成功.");
	}

	/**
	 * 清空所有缓存
	 */
	public synchronized void clearAllCache() {
		cache.clear();
	}

	/**
	 * 碰到相同的值,则value用","分开保存,而不是覆盖
	 * 
	 * @param m
	 * @param key
	 * @param value
	 */
	protected void cacheMap(Map<String, String> m, String key, String value) {
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
	protected void cacheValue2JSON(Map<String, String> m) {
		if (m.size() > 0) {
			for (Map.Entry<String, String> entry : m.entrySet()) {
				String val = entry.getValue();
				if (val.length() > 1) {
					val = val.substring(0, val.length() - 1);
					val = JSONUtil.toJsonString(val.split(","));
				} else {
					val = null;
				}
				cache.put(entry.getKey(), val);
			}
		}
	}
}
