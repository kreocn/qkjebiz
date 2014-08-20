package org.iweb.test;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

import org.iweb.sys.FileUtil;
import org.iweb.sys.MD5Plus;

import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS MAX_LENGTH "
			+ "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' " + "AND c.TABLE_NAME = 'BBB'";

	public test() {
		System.out.println(MD5Plus.encrypt(str));
		InputStream in = new ByteInputStream(str.getBytes(), 0);
		System.out.println(FileUtil.getFileMD5(in));
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
