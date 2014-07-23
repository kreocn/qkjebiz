package org.iweb.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;

public class CommonDAO extends AbstractDAO {
	public Object commonSelectObject(String sqltext) {
		Map map = new HashMap();
		map.put("sqltext", sqltext);
		return super.get("commonSelectObject", map);
	}

	public List commonSelectMapList(String sqltext) {
		Map map = new HashMap();
		map.put("sqltext", sqltext);
		return super.list("commonSelectMapList", map);
	}
}