package org.iweb.rpt.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class SimpleReportDAO extends AbstractDAO {
	/**
	 * 得到Simple List
	 * 
	 * @param map
	 * @return List&lt;ListObject&gt;
	 */
	public List getSimpleList(Map<String, Object> map) {
		return super.list("rpt_getSimpleList", map);
	}

	/**
	 * 得到Simple Result
	 * 
	 * @param map
	 * @return List&lt;Map&gt;
	 */
	public List getSimpleResult(Map<String, Object> map) {
		super.setCount(false);
		return super.list("rpt_getSimpleResult", map);
	}

	/**
	 * 得到Simple Result Count专用
	 * 
	 * @param map
	 * @return
	 */
	public Integer getSimpleResultCount(Map<String, Object> map) {
		return (Integer) super.get("rpt_getSimpleResultCount", map);
	}

}