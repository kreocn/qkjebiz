/**
 * 
 */
package org.iweb.ajax.data;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.cache.CacheFactory;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-6 下午4:17:02
 */
public class ReCacheAjax extends Ajax {
	// private static Log log = LogFactory.getLog(ReCacheAjax.class);
	@Override
	public Object getResult() {
		if (ContextHelper.checkLoginStatus() && ContextHelper.checkPermit("SYS_MANAGER_SYS_PARAM_CACHE")) {
			if (parameter.containsKey("CacheMode")) {
				String cacheMode = (String) parameter.get("CacheMode");
				CacheFactory.CacheFlow(cacheMode);
				return "SUCCESS";
			} else {
				return "NODATA";
			}
		} else {
			return "NOPERMIT";
		}
	}
}
