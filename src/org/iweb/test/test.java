package org.iweb.test;

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
		String[] ss = { "AAA", "BBB", "CCC", "DDD" };
		String json = ToolsUtil.Object2JSON(ss).toString();
		System.out.println(json);
		JSONArray o = JSONArray.fromObject(json);
		System.out.println(o.size());

		String s = "AAA";
		String js = ToolsUtil.Object2JSON(s).toString();
		System.out.println(s);
		// JSONArray os = JSONArray.fromObject(js);
		JSONObject jo = (JSONObject) ToolsUtil.Object2JSON(s);
		// jo.
		System.out.println(ToolsUtil.Object2JSON(s).getClass().getName());

		System.out.println(JSONUtils.mayBeJSON(json));
		System.out.println(JSONUtils.quote(json));
		System.out.println(JSONUtils.valueToString(o));
		// JSONUtils.
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
