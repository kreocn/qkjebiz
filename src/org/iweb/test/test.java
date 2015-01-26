package org.iweb.test;

import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

import org.iweb.fileupload.logic.MemberStockUploadConfig;
import org.iweb.fileupload.logic.UploadConfig;
import org.iweb.sys.HtmlUtils;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.encrypt.AbstractEncrypt;
import org.iweb.sys.encrypt.EncryptFactory;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS $MAX_LENGTH$ " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private StringBuffer sql = new StringBuffer();

	public test() {
		String str = "1 , 2 ,  3,  4,  5";
		// System.out.println(ToolsUtil.split2Integer(str, ","));
		// System.out.println(ToolsUtil.spliten(str, ",").length);
		Integer[] ss = ToolsUtil.split2Integer(str, ",");
		// String[] ss = ToolsUtil.spliten(str);
		for (int i = 0; i < ss.length; i++) {
			System.out.println(ss[i]);
		}

		String s = ToolsUtil.Array2String(ss, ",");
		System.out.println(s);
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
