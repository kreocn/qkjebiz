package org.iweb.sys.cache;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.MenuDAO;
import org.iweb.sys.domain.UserPrivilege;

public class SysCacheCommonLogic extends SysCacheLogic {
	private static Log log = LogFactory.getLog(SysCacheCommonLogic.class);

	public synchronized void createStaticHtmlFiles() {
		createTop();
		createBottom();
		createLeft();
	}

	private void createTop() {
	}

	private void createBottom() {
	}

	@Deprecated
	private void createLeft() {
		// 获取根目录
		String r = (String) cache.get(CACHE_SYS_PREFIX + "WebRelativePath");
		MenuDAO dao = new MenuDAO();
		@SuppressWarnings("unchecked")
		List<UserPrivilege> menus = dao.listSysMenu(null);
		StringBuffer s = new StringBuffer();
		// ").append(r).append("
		s.append("<div data-role='page' class='jqm-demos' data-quicklinks='true'>")
				.append("<a href='#' class='jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left'>Menu</a>")
				.append("<div data-role='panel' class='jqm-navmenu-panel' data-position='left' data-display='overlay' data-theme='a'>")
				.append("<ul id='menuinit' class='jqm-list ui-alt-icon ui-nodisc-icon'>");
		for (int i = 0, n = menus.size(); i < n; i++) {
			UserPrivilege m = menus.get(i);
			// 如果是一级菜单
			if ("0".equals(m.getParent_privilege())) {
				// 生成一级菜单
				s.append("'<li id='M").append(m.getUuid()).append("' data-role='collapsible' ")
						.append(" data-enhanced='true' data-collapsed-icon='carat-d' data-expanded-icon='carat-u' data-iconpos='right' data-inset='false' ")
						.append("class='prvg-module-").append(m.getModule()).append(" ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed'>")
						.append("<h3 class='ui-collapsible-heading ui-collapsible-heading-collapsed'>")
						.append("<a href='javascript:;' class='ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d'>")
						.append(m.getPrivilege_name()).append("</a></h3>");

				// 生成二级菜单
				s.append("<div class='ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed' aria-hidden='true'><ul>");
				for (int j = 0; i < n; j++) {
					UserPrivilege m2 = menus.get(j);
					if (m.getPrivilege_id().equals(m2.getParent_privilege())) {
						if (!m2.getMenu_url().startsWith("/")) m2.setMenu_url("/" + m2.getMenu_url());
						s.append("<li><a href='#' onClick='mLink(\"").append(r).append(m2.getMenu_url()).append("\")' data-ajax='false'>").append(m2.getPrivilege_name())
								.append("</a></li>");
					}
				}
				s.append("</ul></div></li>");
			}
		}
		s.append("</ul>/div></div>");
	}
}
