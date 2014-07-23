package org.iweb.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;

import net.sf.json.JSONObject;

import com.qkj.manage.domain.Apply;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS MAX_LENGTH "
			+ "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' " + "AND c.TABLE_NAME = 'BBB'";

	public test() {
		Apply a = new Apply();
		a.setShip_status(10);
		a.setShip_date(new Date());
		a.setShip_no("112233");
		a.setShip_phone("223344");
		a.setShip_type("334455");
		a.setShip_ware(5);
		
		JSONObject o = JSONObject.fromObject(a);
		System.out.println(o.toString());
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
