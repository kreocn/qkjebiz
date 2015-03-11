package org.iweb.test;

import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysCacheLogic;
import org.iweb.sys.cache.SysDBCacheLogic;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.iweb.sys.ToolsUtil;

public class test {
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS $MAX_LENGTH$ " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private String pwd = "password";
	private StringBuffer sql = new StringBuffer();

	public test() {
		String str = (String)CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_SUB+"210");//返回210所有子部门josn
		String[] s = (String[])JSONUtil.toObject(str, String[].class);//转换成数组
		ToolsUtil.isIn("21011", s);//判断在不在数组中
		String[] ss = { "AAA", "BBB", "CCC", "DDD" };
		String json = ToolsUtil.Object2JSON(ss).toString();
		System.out.println(json);
		JSONArray o = JSONArray.fromObject(json);
		System.out.println(o.size());

		//String s = "AAA";
		String js = ToolsUtil.Object2JSON(s).toString();
		System.out.println(s);
		// JSONArray os = JSONArray.fromObject(js);
		JSONObject jo = (JSONObject) ToolsUtil.Object2JSON(s);
		// jo.
		System.out.println(ToolsUtil.Object2JSON(s).getClass().getName());

		System.out.println(JSONUtils.mayBeJSON(json));
		System.out.println(JSONUtils.quote(json));
		System.out.println(JSONUtils.valueToString(o));
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		long start = System.currentTimeMillis();
		new test();
		long end = System.currentTimeMillis();
		System.out.println("execute time:" + (end - start));

	}
}
