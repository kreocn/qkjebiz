package org.iweb.test;

import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

import org.iweb.fileupload.logic.MemberStockUploadConfig;
import org.iweb.fileupload.logic.UploadConfig;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS MAX_LENGTH " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private StringBuffer sql = new StringBuffer();

	public test() {
		UploadConfig uc = new MemberStockUploadConfig();
		System.out.println(uc.getPermitExtFiles());
		System.out.println(uc.getMessage("", ""));
		System.out.println("============================");
		try {
			UploadConfig uc1 = (UploadConfig) Class.forName("org.iweb.fileupload.logic.MemberStockUploadConfig").newInstance();
			System.out.println(uc1.getPermitExtFiles());
			System.out.println(uc1.getMessage("", ""));
			System.out.println("============================");
		} catch (Exception e) {
			e.printStackTrace();
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
