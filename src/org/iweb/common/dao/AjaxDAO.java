package org.iweb.common.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class AjaxDAO extends AbstractDAO {
	public List list(String map_id, Map<String, Object> map) {
		return super.list(map_id, map);
	}

	public int update(String map_id, Map<String, Object> map) {
		return super.save(map_id, map);
	}
}
