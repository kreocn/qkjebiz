/**
 * 
 */
package org.iweb.ajax.data;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;
import org.iweb.sys.encrypt.EncryptAES;
import org.iweb.sys.encrypt.EncryptFactory;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-6 下午4:17:02
 */
public class GetProductsAjax extends Ajax {
	private static Log log = LogFactory.getLog(GetProductsAjax.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.iweb.ajax.data.Ajax#getResult()
	 */
	@Override
	public Object getResult() {
		if (ContextHelper.checkLoginStatus()) {
			if (parameter.containsKey("product_type")) {
				String jsonstr;
				// HtmlUtils hu = new HtmlUtils();
				try {
					EncryptAES aes = (EncryptAES) EncryptFactory.getEncrypt("AES");
					// jsonstr = aes.decrypt(hu.getOneHtml("http://images.qkjchina.com/CacheFiles/zTree_Products" + parameter.get("product_type") + ".dat", "UTF-8"));
					jsonstr = aes.decrypt((String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_PRODTREE_PREFIX + parameter.get("product_type")));
					log.info("获取产品树成功.");
				} catch (Exception e) {
					jsonstr = "NOFILE";
					log.error("产品树文件获取失败.", e);
				}
				return jsonstr;
			} else {
				return "NODATA";
			}
		} else {
			return "NOLOGIN";
		}
	}
}
