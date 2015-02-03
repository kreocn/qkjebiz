package org.iweb.sys.action;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.IWebConfig;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysCacheLogic;
import org.iweb.sys.cache.SysDBCacheLogic;

import com.opensymphony.xwork2.ActionSupport;

public class SysParamAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6255119192633412586L;
	private static Log log = LogFactory.getLog(SysParamAction.class);
	private String sysParamInfo;

	public String getSysParamInfo() {
		return sysParamInfo;
	}

	public void setSysParamInfo(String sysParamInfo) {
		this.sysParamInfo = sysParamInfo;
	}

	@Override
	public String execute() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_SYS_PARAM");
		try {
			File f = new File(CacheFactory.getCacheInstance().get(SysCacheLogic.CACHE_SYS_PREFIX + "WebAbsolutePath") + "WEB-INF/sys.properties");
			System.out.println(f.getName());
			StringBuffer buffer = new StringBuffer();
			Reader in = new BufferedReader(new InputStreamReader(new FileInputStream(f), "UTF-8"));
			int ch;
			while ((ch = in.read()) > -1) {
				buffer.append((char) ch);
			}
			in.close();

			this.setSysParamInfo(new String(buffer.toString()));
		} catch (Exception e) {
			log.error("读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_SYS_PARAM_SAVE");
		try {
			File f = new File(CacheFactory.getCacheInstance().get("WebAbsolutePath") + "WEB-INF/sys.properties");
			Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f), "UTF-8"));
			out.write(this.getSysParamInfo());
			out.close();

			IWebConfig iweb = new IWebConfig();
			iweb.reloadSysProperties();

			SysCacheLogic cacheLogic = new SysCacheLogic();
			cacheLogic.cacheSys(true);
		} catch (Exception e) {
			log.error("写入数据错误:", e);
		}
		return SUCCESS;
	}

}
