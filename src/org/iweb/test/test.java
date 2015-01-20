package org.iweb.test;

import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

import org.iweb.fileupload.logic.MemberStockUploadConfig;
import org.iweb.fileupload.logic.UploadConfig;
import org.iweb.sys.HtmlUtils;
import org.iweb.sys.encrypt.AbstractEncrypt;
import org.iweb.sys.encrypt.EncryptFactory;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS $MAX_LENGTH$ " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private StringBuffer sql = new StringBuffer();

	public test() {
		HtmlUtils hu = new HtmlUtils();
		String a = "";
		try {
			AbstractEncrypt encrypt = EncryptFactory.getEncrypt("AES");
			a = new String(encrypt.decrypt(hu.getHtml2Byte("http://images.qkjchina.com/CacheFiles/zTree_Products1.js")));
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(a);
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
