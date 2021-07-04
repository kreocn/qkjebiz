/**
 * 
 */
package org.iweb.ajax.data;

import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.AjaxDAO;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.MemberStatusFactory;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-6 下午4:17:02
 */
public class MemberAjax extends Ajax {
	private static Log log = LogFactory.getLog(MemberAjax.class);
	private static HashMap<String, String> sqlmap = new HashMap<String, String>();

	static {
		sqlmap.put("GETCELLARORDER", "sysebiz_getCellarOrders");
		// sqlmap.put("QKJCJ_SYS_AJAXLOAD_USER", "sys_getUser");
		log.info("AutoCompleteAjax sqlmap 初始化完成!");
	}

	private String ajax_name;

	public String getAjax_name() {
		return ajax_name;
	}

	public void setAjax_name(String ajax_name) {
		this.ajax_name = ajax_name;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.iweb.ajax.data.Ajax#getResult()
	 */
	@Override
	public Object getResult() {
		// 用户AJAX,所以必须检查用户是否已登录
		if (MemberStatusFactory.getLogin()) {
			this.setAjax_name((String) parameter.get("ajax_name"));
			parameter.remove("privilege_id");
			if (ToolsUtil.isEmpty(this.getAjax_name())) {
				return "NODATA";
			} else {
				AjaxDAO dao = new AjaxDAO();
				return dao.list(sqlmap.get(this.getAjax_name()), parameter);
			}
		} else {
			return "NOLOGIN";
		}
	}
}
