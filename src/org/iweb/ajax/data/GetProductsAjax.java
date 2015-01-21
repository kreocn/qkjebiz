/**
 * 
 */
package org.iweb.ajax.data;

import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.HtmlUtils;
import org.iweb.sys.encrypt.AbstractEncrypt;
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
				HtmlUtils hu = new HtmlUtils();
				try {
					AbstractEncrypt encrypt = EncryptFactory.getEncrypt("AES");
					jsonstr = new String(encrypt.decrypt(hu.getHtml2Byte("http://images.qkjchina.com/CacheFiles/zTree_Products" + parameter.get("product_type") + ".js")));
					log.info("获取产品树成功.");
				} catch (Exception e) {
					jsonstr = "NOFILE";
					log.info("产品树文件获取成功.");
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
