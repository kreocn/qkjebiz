package org.iweb.test;

import org.iweb.sys.encrypt.EncryptFactory;
import org.iweb.sys.encrypt.EncryptMD5;

public class test {
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS $MAX_LENGTH$ " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private String pwd = "password";
	private StringBuffer sql = new StringBuffer();

	public test() {
		try {
			EncryptMD5 aes = (EncryptMD5) EncryptFactory.getEncrypt("MD5");
			String en = aes.encrypt(str);
			System.out.println(en);
			// String de = aes.decrypt(en);
			// System.out.println(de);
			System.out.println(aes.equal(str, en));
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
