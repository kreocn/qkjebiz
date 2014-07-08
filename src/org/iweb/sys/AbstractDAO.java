package org.iweb.sys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public abstract class AbstractDAO {

	protected static Log log = LogFactory.getLog(AbstractDAO.class);

	private int resultCount = 0;

	private DBHelper db = DBHelper.getInstance();

	private boolean isCount = true;

	private boolean isShowParameter = true;

	public boolean isShowParameter() {
		return isShowParameter;
	}

	public void setShowParameter(boolean isShowParameter) {
		this.isShowParameter = isShowParameter;
	}

	public boolean isCount() {
		return isCount;
	}

	public void setCount(boolean isCount) {
		this.isCount = isCount;
	}

	// Select Count(*)的MAP_ID
	private String countMapid;

	protected String getCountMapid() {
		return countMapid;
	}

	protected void setCountMapid(String countMapid) {
		this.countMapid = countMapid;
	}

	protected Object add(String map_id, Object parameters) {
		Object obj;
		try {
			obj = db.insert(map_id, parameters);
			showLog(map_id, "add", parameters, null);
		} catch (Exception e) {
			showLog(map_id, "add", parameters, e);
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return obj;
	}

	protected int save(String map_id, Object parameters) {
		int i = 0;
		try {
			i = db.update(map_id, parameters);
			showLog(map_id, "update", parameters, null);
		} catch (Exception e) {
			showLog(map_id, "update", parameters, e);
			throw new RuntimeException(e);
		}
		return i;
	}

	protected int delete(String map_id, Object parameters) {
		int i = 0;
		try {
			i = db.delete(map_id, parameters);
			showLog(map_id, "delete", parameters, null);
		} catch (Exception e) {
			showLog(map_id, "delete", parameters, e);
			throw new RuntimeException(e);
		}
		return i;
	}

	protected int procedure(String map_id, Object parameters) {
		int i = 0;
		try {
			i = db.procedure(map_id, parameters);
			showLog(map_id, "procedure", parameters, null);
		} catch (Exception e) {
			showLog(map_id, "procedure", parameters, e);
			throw new RuntimeException(e);
		}
		return i;
	}

	protected List list(String map_id, Map<String, Object> map) {
		int Page_Size, Current_Page;
		List resultList;
		try {
			if (map == null) {
				resultList = db.getResultList(map_id);
			} else if (null != map && map.containsKey(Parameters.Current_Page_Str)) {
				try {
					Current_Page = Integer.parseInt(map.get(Parameters.Current_Page_Str).toString());
				} catch (Exception e) {
					Current_Page = 1;
				}
				if (map.containsKey(Parameters.Page_Size_Str)) {
					try {
						Object tmp = map.get(Parameters.Page_Size_Str);
						if (tmp == null) {
							Page_Size = 30;
						} else if (tmp instanceof java.lang.Integer) {
							Page_Size = (java.lang.Integer) tmp;
						} else {
							Page_Size = Integer.parseInt((String) map.get(Parameters.Page_Size_Str));
						}
					} catch (Exception e) {
						Page_Size = 30;
					}
					map.remove(Parameters.Page_Size_Str);
					map.remove(Parameters.Current_Page_Str);
					resultList = db.getResultListByPage(map_id, map, Page_Size, Current_Page);
				} else {
					map.remove(Parameters.Current_Page_Str);
					resultList = db.getResultListByPage(map_id, map, Current_Page);
				}
				if (isCount) {
					if (ToolsUtil.isEmpty(getCountMapid())) {
						resultCount = db.getResultList(map_id, map).size();
						System.out.println("CountMapid is Empty!");
					} else {
						try {
							resultCount = (Integer) get(getCountMapid(), map);
							// System.out.println("CountMapid is Current!");
						} catch (Exception e) {
							log.warn("getCountMapid 错误:", e);
							resultCount = db.getResultList(map_id, map).size();
							// System.out.println("CountMapid is Failed!");
						}
					}
				}
			} else {
				resultList = db.getResultList(map_id, map);
				if (isCount) {
					resultCount = resultList.size();
				}
			}
			showLog(map_id, "list", map, null);
		} catch (Exception e) {
			resultList = null;
			showLog(map_id, "list", map, e);
			throw new RuntimeException(e);
		}
		return resultList;
	}

	/**
	 * @param map_id
	 * @param parameter
	 * @return
	 * @date 2014-3-20 下午2:48:04
	 */
	protected List listByObject(String map_id, Object parameters) {
		if (parameters instanceof Map) {
			return list(map_id, (Map) parameters);
		}
		List resultList;
		try {
			resultList = null;
			resultList = db.getResultList(map_id, parameters);
			showLog(map_id, "listByObject", parameters, null);
		} catch (Exception e) {
			resultList = null;
			showLog(map_id, "listByObject", parameters, e);
			throw new RuntimeException(e);
		}
		return resultList;
	}

	/**
	 * 返回MAP型查询结果
	 * 
	 * @param map_id
	 * @param map
	 *            参数
	 * @param keyProperty
	 *            返回对象中作为key的属性
	 * @param valueProperty
	 *            返回对象中作为vsalue的属性,输入null则value为对象本身
	 * @return
	 */
	protected Map map(String map_id, Object parameters, String keyProperty, String valueProperty) {
		Map m;
		try {
			m = db.getResultMap(map_id, parameters, keyProperty, valueProperty);
			showLog(map_id, "map", parameters, null);
		} catch (Exception e) {
			m = null;
			showLog(map_id, "map", parameters, e);
			throw new RuntimeException(e);
		}
		return m;
	}

	/**
	 * 返回单一对象的查询
	 * 
	 * @param map_id
	 * @param parameters
	 * @return
	 * @date 2014-1-16 下午3:13:55
	 */
	protected Object get(String map_id, Object parameters) {
		try {
			Object o = db.getResultObject(map_id, parameters);
			showLog(map_id, "get", parameters, null);
			return o;
		} catch (Exception e) {
			showLog(map_id, "get", parameters, e);
			throw new RuntimeException(e);
		}
	}

	public void startTransaction() {
		try {
			db.startTransaction();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void commitTransaction() {
		try {
			db.commitTransaction();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void endTransaction() {
		try {
			db.endTransaction();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void startBatch() {
		try {
			db.startBatch();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void executeBatch() {
		try {
			db.executeBatch();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	protected void batchStatment(List<String> map_id_list, List<Object> parameter_list, Boolean isUseBatchNum) {
		try {
			db.batchStatment(map_id_list, parameter_list, isUseBatchNum);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 使用相同map_id的batchStatment
	 * 
	 * @param map_id
	 * @param parameters
	 * @param isUseBatchNum
	 * @throws Exception
	 */
	protected void batchStatment(String map_id, List<Object> parameters, Boolean isUseBatchNum) {
		batchStatment(String2List(map_id, parameters.size()), parameters, isUseBatchNum);
	}

	/**
	 * 可以把str转换成List,方便batchStatment使用
	 * 
	 * @param str
	 * @return
	 */
	protected List<String> String2List(String str, int size) {
		ArrayList<String> list = new ArrayList<String>();
		for (int i = 0; i < size; i++) {
			list.add(i, str);
		}
		return list;
	}

	/**
	 * 批量操作时,设定一次批量的数目,默认为50
	 * 
	 * @param num
	 */
	protected void setBatchNum(int num) {
		db.setBatchNum(num);
	}

	public int getResultCount() {
		return resultCount;
	}

	private void showLog(String map_id, String method, Object parameters, Exception e) {
		String msg = ToolsUtil.dumpObject(parameters);
		if (msg == null || msg.indexOf("password") > -1) {
			this.setShowParameter(false);
		}
		if (null == e) {
			log.info("Execute Map(MapID=" + map_id + ";method=" + method + ") Successful!"
					+ (this.isShowParameter ? "\nParameters:" + msg : ""));
		} else {
			log.error("Execute Map(MapID=" + map_id + ";method=" + method + ") Error!"
					+ (this.isShowParameter ? "\nParameters:" + msg : ""), e);
			e.printStackTrace();
		}
	}
}
