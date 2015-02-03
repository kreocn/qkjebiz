package org.iweb.sys;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysCacheLogic;

/**
 * 系统启动加载缓存的Servlet
 * 
 * @author 骏宇
 * 
 */
public class IWebConfig extends HttpServlet implements javax.servlet.Servlet {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(IWebConfig.class);
	private static Map<String, String> map = new HashMap<String, String>();

	// private SysCache cache;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public IWebConfig() {
		super();
		// cache = CacheFactory.getCacheInstance();
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			/** ------------------------------- **/
			/** 开始加载系统配置和系统参数 **/
			/** ------------------------------- **/
			super.init(config);
			String appDir = config.getServletContext().getRealPath("/");
			if (!appDir.endsWith(File.separator)) {
				appDir += File.separator;
			}
			String abstractDir = config.getServletContext().getContextPath();
			if (!abstractDir.endsWith(File.separator)) {
				abstractDir += File.separator;
			}
			this.appendConfig("WebAbsolutePath", appDir);
			this.appendConfig("WebRelativePath", abstractDir);
			Enumeration<String> keys = config.getInitParameterNames();
			while (keys.hasMoreElements()) {
				String key = keys.nextElement();
				String value = config.getInitParameter(key);
				this.appendConfig(key, value);
			}

			File f = new File(appDir + "WEB-INF/sys.properties");
			if (f.exists()) {
				Properties p = new Properties();
				p.load(new InputStreamReader(new FileInputStream(f), "UTF-8"));
				for (Map.Entry<Object, Object> entry : p.entrySet()) {
					this.appendConfig((String) entry.getKey(), (String) entry.getValue());
				}
				if (!getConfigMap().containsKey("fileUploadRoot")) {
					log.warn("参数:fileUploadRoot 未发现,上传文件功能可能无法使用!");
				} else if (!(new File((String) getConfigMap().get("fileUploadRoot")).exists())) {
					log.warn("参数:fileUploadRoot 所配置路径不存在,上传功能可能无法使用。请到/WEB-INF/sys.properties中配置正确的路径。");
				}
			} else {
				log.warn("系统参数配置文件不存在,加载失败!");
			}

			// 初始化常量
			new SysCacheLogic(appDir, abstractDir);
			// 加载缓存
			CacheFactory.CacheFlow("all");
		} catch (Exception e) {
			log.fatal("Init Config Error! Please Container or web.xml is Corrent ! \n" + ToolsUtil.getStackTrace(e));
			throw new RuntimeException("Init Config Error!");
		}
	}

	/**
	 * @deprecated replace By org.iweb.sys.cache.SysCache
	 * @see org.iweb.sys.cache.SysCache
	 * @see org.iweb.sys.cache.CacheFactory
	 * @return
	 */
	@Deprecated
	public void reloadSysProperties() throws Exception {
		File f = new File(getConfigMap().get("WebAbsolutePath") + "WEB-INF/sys.properties");
		if (f.exists()) {
			Properties p = new Properties();
			FileInputStream fis = new FileInputStream(f);
			p.load(fis);
			for (Map.Entry<Object, Object> entry : p.entrySet()) {
				this.appendConfig((String) entry.getKey(), (String) entry.getValue());
			}
			if (!getConfigMap().containsKey("fileUploadRoot")) {
				log.warn("参数:fileUploadRoot 未发现,上传文件功能可能无法使用!");
			} else if (!(new File((String) getConfigMap().get("fileUploadRoot")).exists())) {
				log.warn("参数:fileUploadRoot 所配置路径不存在,上传功能可能无法使用。请到/WEB-INF/sys.properties中配置正确的路径。");
			}
			fis.close();
		} else {
			log.warn("系统参数配置文件不存在,加载失败!");
		}
	}

	private void appendConfig(String key, String value) {
		// cache.put(key, value);
		map.put(key, value);
		StringBuffer sb = new StringBuffer();
		sb.append("setConfig:[");
		sb.append(key);
		sb.append("=");
		sb.append(value);
		sb.append("]");
		log.info(sb.toString());
	}

	/**
	 * @deprecated replace By org.iweb.sys.cache.SysCache
	 * @see org.iweb.sys.cache.SysCache
	 * @see org.iweb.sys.cache.CacheFactory
	 * @return
	 */
	@Deprecated
	public static Map<String, String> getConfigMap() {
		return map;
	}
}
