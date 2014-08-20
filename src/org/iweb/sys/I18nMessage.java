/**
 * 
 */
package org.iweb.sys;

import java.util.Locale;
import java.util.ResourceBundle;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-13 下午9:29:01
 */
public class I18nMessage {
	public static String getI18n(String key) {
		Locale l;
		try {
			l = ContextHelper.getRequest().getLocale();
		} catch (Exception e) {
			l = Locale.getDefault();
		}
		ResourceBundle rb = ResourceBundle.getBundle(resource, l);
		return rb.getString(key);
	}

	private final static String resource = "org.iweb.resource.message";
}
