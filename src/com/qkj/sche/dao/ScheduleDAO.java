package com.qkj.sche.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.AbstractDAO;
import org.iweb.sys.DBHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

public class ScheduleDAO extends AbstractDAO {

	public Object add(Object parameters) {
		return super.add("sche_addSche_ss", parameters);
	}

	public int save(Object parameters) {
		return super.save("sche_saveSche_ss", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sche_delSche_ss", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sche_getSche_ss", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
