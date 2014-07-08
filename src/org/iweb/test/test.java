package org.iweb.test;

import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

import org.iweb.sys.ToolsUtil;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS MAX_LENGTH "
			+ "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' " + "AND c.TABLE_NAME = 'BBB'";

	public test() {
		ArrayList<String> l = new ArrayList<>();
		String tmp = "";
		for (int i = 0; i < 10; i++) {
			int count = 0;
			l.clear();
			while (true) {
				tmp = ToolsUtil.getUUID16();
				if (l.contains(tmp)) break;
				else l.add(ToolsUtil.getUUID16());
				count++;
			}
			System.out.println(count);
		}
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
