package org.iweb.common.logic;

import org.iweb.common.dao.CommonDAO;
import org.iweb.sys.ToolsUtil;

public class CommonLogic {
	public static String getNextSQLID(String sql, String prefix) {
		CommonDAO dao = new CommonDAO();
		String current_id = (String) dao.commonSelectObject(sql);
		return ToolsUtil.getNextID(current_id, prefix);
	}

	public static String getNextMemberID() {
		return getNextSQLID("SELECT MAX(`uuid`) FROM s_vip_member", "q");
	}
}
