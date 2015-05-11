package org.iweb.sys;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysCacheLogic;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class DBHelper {
	private static Log log = LogFactory.getLog(DBHelper.class);

	private final static String[] configs = { "WEB-INF/classes/sql-map-config.xml", "WEB-INF/classes/sql-map-config02.xml" };
	private static SqlMapClient[] sqlMaps;
	private static int targetDB = 0;

	// 批量操作时,一次性提交的数目
	private int batchNum = 50;

	private static DBHelper db;
	private static DBHelper[] dbs;

	static {
		String rootPath = (String) CacheFactory.getCacheInstance().get(SysCacheLogic.CACHE_SYS_PREFIX + "WebAbsolutePath");
		sqlMaps = new SqlMapClient[configs.length];
		dbs = new DBHelper[configs.length];
		for (int i = 0; i < configs.length; i++) {
			try {
				InputStream is = new FileInputStream(new File(rootPath + configs[i]));
				sqlMaps[i] = SqlMapClientBuilder.buildSqlMapClient(is);
				is.close();
				log.info("SqlMap配置文件[" + rootPath + configs[i] + "]加载成功!");
			} catch (Exception e) {
				// sqlMaps[targetDB] = null;
				log.fatal("SqlMap配置文件加载失败,系统将可能正常运行!", e);
			}
		}
		// db = new DBHelper();
	}

	private DBHelper() {
		targetDB = 0;
	}

	private DBHelper(int db_num) {
		targetDB = db_num;
	}

	public synchronized static DBHelper getInstance() {
		targetDB = 0;
		return getInstance(0);
	}

	public synchronized static DBHelper getInstance(int db_num) {
		targetDB = db_num;
		if (dbs[db_num] == null) {
			dbs[db_num] = new DBHelper(db_num);
		}
		db = dbs[db_num];
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
		if (null != parameters) list = sqlMaps[targetDB].queryForList(map_id, parameters);
		else list = sqlMaps[targetDB].queryForList(map_id);
		return list;
	}

	public List getResultList(String map_id) throws Exception {
		return getResultList(map_id, null);
	}

	public Map getResultMap(String map_id, Object parameters, String keyProperty, String valueProperty) throws Exception {
		Map map;
		map = sqlMaps[targetDB].queryForMap(map_id, parameters, keyProperty, valueProperty);
		return map;
	}

	public List getResultListByPage(String map_id, Object parameters, int Page_Size, int Current_Page) throws Exception {
		List list = sqlMaps[targetDB].queryForList(map_id, parameters, Page_Size * (Current_Page - 1), Page_Size);
		return list;
	}

	public Object getResultObject(String map_id, Object parameters) throws Exception {
		Object obj = sqlMaps[targetDB].queryForObject(map_id, parameters);
		return obj;
	}

	public List getResultListByPage(String map_id, Object parameters, int Current_Page) throws Exception {
		int Page_Size = Integer.parseInt(IWebConfig.getConfigMap().get("Default_Page_Size").toString());
		return getResultListByPage(map_id, parameters, Page_Size, Current_Page);
	}

	public int statmate(String map_id, Object parameters) throws Exception {
		try {
			return sqlMaps[targetDB].update(map_id, parameters);
		} catch (Exception e) {
			throw new Exception("数据库操作异常(statmate)!", e);
		}
	}

	public Object insert(String map_id, Object parameters) throws Exception {
		Object obj = null;
		try {
			obj = sqlMaps[targetDB].insert(map_id, parameters);
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
		if (map_id_list == null || parameter_list == null || map_id_list.size() == 0 || parameter_list.size() == 0) { return; }
		int t = 0;
		try {
			boolean flag = true;
			for (int i = 0, n = map_id_list.size(); i < n; i++) {
				t = i;
				if (flag) {
					sqlMaps[targetDB].startTransaction();
					sqlMaps[targetDB].startBatch();
					flag = false;
				}
				sqlMaps[targetDB].delete(map_id_list.get(i), parameter_list.get(i));
				log.info("Batch(" + i + ")!:" + map_id_list.get(i) + ";parameter:" + ToolsUtil.dumpObject(parameter_list.get(i)));
				if (isUseBatchNum && (i + 1) % batchNum == 0) {
					sqlMaps[targetDB].executeBatch();
					sqlMaps[targetDB].commitTransaction();
					log.info("ExecuteBatch!");
					flag = true;
				}
			}
			sqlMaps[targetDB].executeBatch();
			sqlMaps[targetDB].commitTransaction();
			log.info("Bacth Statmeter Successful! \nTotal Operate Number:" + map_id_list.size());
		} catch (Exception e) {
			log.error("Bacth Statmeter Failed!Transaction Will Be RollBack!!parameter:" + ToolsUtil.dumpObject(parameter_list.get(t)), e);
		} finally {
			try {
				sqlMaps[targetDB].endTransaction();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public void startTransaction() throws Exception {
		sqlMaps[targetDB].startTransaction();
	}

	public void commitTransaction() throws Exception {
		sqlMaps[targetDB].commitTransaction();
	}

	public void endTransaction() throws Exception {
		sqlMaps[targetDB].endTransaction();
	}

	public void startBatch() throws Exception {
		sqlMaps[targetDB].startBatch();
	}

	public void executeBatch() throws Exception {
		sqlMaps[targetDB].executeBatch();
	}
}
