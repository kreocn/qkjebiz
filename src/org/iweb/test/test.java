package org.iweb.test;

import java.util.Date;

import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;

import com.qkj.manage.domain.Active;

public class test {
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS $MAX_LENGTH$ " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private String pwd = "password";
	private StringBuffer sql = new StringBuffer();

	public test() {
		Active ac = new Active();
		ac.setUuid(36456452);
		ac.setActive_type(234213);
		ac.setAdd_time(new Date());
		ac.setClose_nd_status(3243);
		ac.setApply_user("aSllksafk");
		String acstr = JSONUtil.toJsonString(ac);
		System.out.println("========================");
		System.out.println(acstr);
		System.out.println("========================");
		Active ac2 = (Active) JSONUtil.toObject(acstr, Active.class);
		System.out.println("========================");
		System.out.println(ToolsUtil.dumpObject(ac2));
		System.out.println("========================");

		String[] ar = { "kajfas", "DKF", "的法定税率", "EDFSD" };
		String arstr = JSONUtil.toJsonString(ar);
		System.out.println("========================");
		System.out.println(arstr);
		System.out.println("========================");
		String[] ar2 = (String[]) JSONUtil.toObject(arstr, String[].class);
		System.out.println("========================");
		System.out.println(ar2[2] + ":" + ar2.length);
		System.out.println("========================");

		String st = "Ahflkdsjf dsaj f";
		String ststr = JSONUtil.toJsonString(st);
		System.out.println("========================");
		System.out.println(ststr);
		System.out.println("========================");
		String at2 = (String) JSONUtil.toObject(ststr, String.class);
		System.out.println("========================");
		System.out.println(at2);
		System.out.println("========================");
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
