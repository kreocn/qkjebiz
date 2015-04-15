package org.iweb.test;

public class test {
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS $MAX_LENGTH$ " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private String cid = "qx000155";
	private String prefix = "qx";
	private StringBuffer sql = new StringBuffer();

	public test() {
		String str = "||COLUMN_NAME||COLUMN_COMMENT";
		System.out.println(str.indexOf("||"));
		System.out.println(str.split("\\|\\|").length);
		

		String str2 = "&&COLUMN_NAME&&COLUMN_COMMENT";
		System.out.println(str2.indexOf("&&"));
		System.out.println(str2.split("&&").length);
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
