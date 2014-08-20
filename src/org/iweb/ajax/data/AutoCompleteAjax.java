/**
 * 
 */
package org.iweb.ajax.data;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.AjaxDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-6 下午4:17:02
 */
public class AutoCompleteAjax extends Ajax {
	private static Log log = LogFactory.getLog(AutoCompleteAjax.class);
	private static HashMap<String, String> sqlmap = new HashMap<String, String>();

	static {
		sqlmap.put("QKJCJ_SYSEBIZ_AJAXLOAD_MEMBER", "sysvip_getMembers");
		sqlmap.put("QKJCJ_SYS_AJAXLOAD_USER", "sys_getUser");
		sqlmap.put("QKJCJ_SYSEBIZ_AJAXLOAD_MEMBERCELLAR", "sysebiz_getMemberCellars4Add");

		// 业务系统中,取得Member所用
		sqlmap.put("QKJ_QKJMANAGER_AJAXLOAD_MEMBER", "sysvip_getMembers");
		log.info("AutoCompleteAjax sqlmap 初始化完成!");
	}

	private String privilege_id;

	public String getPrivilege_id() {
		return privilege_id;
	}

	public void setPrivilege_id(String privilege_id) {
		this.privilege_id = privilege_id;
	}

	/*
	 * (non-Javadoc)
	 * @see org.iweb.ajax.data.Ajax#getResult()
	 */
	@Override
	public Object getResult() {
		// 此操作涉及到权限
		this.setPrivilege_id((String) parameter.get("privilege_id"));
		parameter.remove("privilege_id");
		if (ToolsUtil.isEmpty(this.getPrivilege_id())) {
			return "NODATA";
		} else {
			if (!ContextHelper.checkPermit(this.getPrivilege_id())) {
				return "NOTPERMIT";
			}
			AjaxDAO dao = new AjaxDAO();
			if (parameter.size() == 0) {
				return new ArrayList<HashMap<String, Object>>();
			} else {
				if ("QKJCJ_SYSEBIZ_AJAXLOAD_MEMBER".equals(this.getPrivilege_id())) {
					parameter.put("limitnum", 15);// 只列出15个
					parameter4MemberLoad();
				} else if ("QKJCJ_SYS_AJAXLOAD_USER".equals(this.getPrivilege_id())) {
					parameter4UserLoad();
				} else if ("QKJ_QKJMANAGER_AJAXLOAD_MEMBER".equals(this.getPrivilege_id())
						&& !parameter.containsKey("uuid")) {
					// 如果没有包含uuid参数,则直接返回无数据
					return "NODATA";
				}
				return dao.list(sqlmap.get(this.getPrivilege_id()), parameter);
			}

		}
	}

	/**
	 * QKJCJ_SYSEBIZ_AJAXLOAD_MEMBER专门对此做出的参数转换<br />
	 * uuid -> uuid_autoc mobile -> mobile_autoc member_name -> member_name_autoc<br />
	 * 并加上部门限制
	 * 
	 * @date 2014-1-30 下午4:20:39
	 */
	private void parameter4MemberLoad() {
		if (parameter.containsKey("uuid")) {
			parameter.put("uuid_autoc", parameter.get("uuid"));
			parameter.remove("uuid");
		}
		if (parameter.containsKey("mobile")) {
			parameter.put("mobile_autoc", parameter.get("mobile"));
			parameter.remove("mobile");
		}
		if (parameter.containsKey("member_name")) {
			parameter.put("member_name_autoc", parameter.get("member_name"));
			parameter.remove("member_name");
		}
		ContextHelper.setSearchDeptPermit4Search(parameter, "dept_codes", "manager");
	}

	private void parameter4UserLoad() {
		ContextHelper.setSearchDeptPermit4Search(parameter, "dept_codes", "uuid");
	}
}
