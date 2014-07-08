package org.iweb.sys;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class DBHelper {

	private static SqlMapClient sqlMap;
	private static Log log = LogFactory.getLog(DBHelper.class);

	// 批量操作时,一次性提交的数目
	private int batchNum = 50;

	private static DBHelper db;

	static {
		try {
			String resource = Parameters.getAbsolutePath() + "WEB-INF/classes/sql-map-config.xml";
			InputStream is = new FileInputStream(new File(resource));
			sqlMap = SqlMapClientBuilder.buildSqlMapClient(is);
			is.close();
			log.info("SqlMap配置文件加载成功!");
		} catch (Exception e) {
			sqlMap = null;
			log.fatal("SqlMap配置文件加载失败,系统将无法正常运行!");
			e.printStackTrace();
			throw new RuntimeException("SqlMap配置文件加载失败! " + e);
		}
		db = new DBHelper();
	}

	private DBHelper() {
	}

	public synchronized static DBHelper getInstance() {
		if (db == null) {
			db = new DBHelper();
		}
		return db;
	}

	public int getBatchNum() {
		return batchNum;
	}

	public void setBatchNum(int batchNum) {
		this.batchNum = batchNum;
	}

	/**
	 * 
	 * @param map_id
	 *            Sql_Map 的识标ID
	 * @param parameters
	 *            参数列表
	 * @return
	 */
	public List getResultList(String map_id, Object parameters) throws Exception {
		// Map<String, Object> parameters
		List list;
		if (null != parameters)
			list = sqlMap.queryForList(map_id, parameters);
		else
			list = sqlMap.queryForList(map_id);
		return list;
	}

	public List getResultList(String map_id) throws Exception {
		return getResultList(map_id, null);
	}

	public Map getResultMap(String map_id, Object parameters, String keyProperty, String valueProperty)
			throws Exception {
		Map map;
		map = sqlMap.queryForMap(map_id, parameters, keyProperty, valueProperty);
		return map;
	}

	public List getResultListByPage(String map_id, Object parameters, int Page_Size, int Current_Page) throws Exception {
		List list = sqlMap.queryForList(map_id, parameters, Page_Size * (Current_Page - 1), Page_Size);
		return list;
	}

	public Object getResultObject(String map_id, Object parameters) throws Exception {
		Object obj = sqlMap.queryForObject(map_id, parameters);
		return obj;
	}

	public List getResultListByPage(String map_id, Object parameters, int Current_Page) throws Exception {
		int Page_Size = Integer.parseInt(IWebConfig.getConfigMap().get("Default_Page_Size").toString());
		return getResultListByPage(map_id, parameters, Page_Size, Current_Page);
	}

	public int statmate(String map_id, Object parameters) throws Exception {
		try {
			return sqlMap.update(map_id, parameters);
		} catch (Exception e) {
			throw new Exception("数据库操作异常(statmate)!", e);
		}
	}

	public Object insert(String map_id, Object parameters) throws Exception {
		Object obj = null;
		try {
			obj = sqlMap.insert(map_id, parameters);
		} catch (Exception e) {
			throw new Exception("数据库操作异常(insert)!", e);
		}
		return obj;
	}

	public int update(String map_id, Object parameters) throws Exception {
		return statmate(map_id, parameters);
	}

	public int delete(String map_id, Object parameters) throws Exception {
		return statmate(map_id, parameters);
	}

	public int procedure(String map_id, Object parameters) throws Exception {
		return statmate(map_id, parameters);
	}

	/**
	 * 批量操作时使用,map_id和parameter使用相同的list_index
	 * 
	 * @param map_ids
	 * @param parameters
	 * @param isUseBatchNum
	 *            使用batchNum识标,如为true,则每batchNum个单位提交一次.
	 */
	public void batchStatment(List<String> map_id_list, List<Object> parameter_list, Boolean isUseBatchNum) {
		if (map_id_list == null || parameter_list == null || map_id_list.size() == 0 || parameter_list.size() == 0) {
			return;
		}
		int t = 0;
		try {
			boolean flag = true;
			for (int i = 0, n = map_id_list.size(); i < n; i++) {
				t = i;
				if (flag) {
					sqlMap.startTransaction();
					sqlMap.startBatch();
					flag = false;
				}
				sqlMap.delete(map_id_list.get(i), parameter_list.get(i));
				log.info("Batch(" + i + ")!:" + map_id_list.get(i) + ";parameter:"
						+ ToolsUtil.dumpObject(parameter_list.get(i)));
				if (isUseBatchNum && (i + 1) % batchNum == 0) {
					sqlMap.executeBatch();
					sqlMap.commitTransaction();
					log.info("ExecuteBatch!");
					flag = true;
				}
			}
			sqlMap.executeBatch();
			sqlMap.commitTransaction();
			log.info("Bacth Statmeter Successful! \nTotal Operate Number:" + map_id_list.size());
		} catch (Exception e) {
			log.error(
					"Bacth Statmeter Failed!Transaction Will Be RollBack!!parameter:"
							+ ToolsUtil.dumpObject(parameter_list.get(t)), e);
		} finally {
			try {
				sqlMap.endTransaction();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public void startTransaction() throws Exception {
		sqlMap.startTransaction();
	}

	public void commitTransaction() throws Exception {
		sqlMap.commitTransaction();
	}

	public void endTransaction() throws Exception {
		sqlMap.endTransaction();
	}

	public void startBatch() throws Exception {
		sqlMap.startBatch();
	}

	public void executeBatch() throws Exception {
		sqlMap.executeBatch();
	}
}
