package org.iweb.common.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.MenuDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.UserPrivilege;

import com.opensymphony.xwork2.ActionSupport;

public class ManageMainAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8093089119888998390L;
	private static Log log = LogFactory.getLog(MenuAction.class);
	private MenuDAO dao = new MenuDAO();
	private Map<String, Object> map = new HashMap<String, Object>();

	private UserPrivilege menu;
	private List<UserPrivilege> menus;
	private String message;

	public UserPrivilege getMenu() {
		return menu;
	}

	public void setMenu(UserPrivilege menu) {
		this.menu = menu;
	}

	public List<UserPrivilege> getMenus() {
		return menus;
	}

	public void setMenus(List<UserPrivilege> menus) {
		this.menus = menus;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String execute() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (ContextHelper.isAdmin()) {
				this.setMenus(dao.listSysMenu(null));
			} else {
				// ArrayList<String> userPermits = new ArrayList().addAll(ContextHelper.getUserLoginPermits().keySet());

				ArrayList<String> userPermits = new ArrayList<String>();
				userPermits.addAll(ContextHelper.getUserLoginPermits().keySet());
				if (userPermits == null || userPermits.size() == 0) {
					this.setMenu(null);
				} else {
					map.clear();
					map.put("user_permits", userPermits);
					this.setMenus(dao.listSysMenu(map));
				}
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
			// this.setMenu(null);
		}
		return SUCCESS;
	}

	public String ref() throws Exception {
		return SUCCESS;
	}
}
