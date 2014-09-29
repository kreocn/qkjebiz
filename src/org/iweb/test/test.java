package org.iweb.test;

import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

public class test {

	private static ConcurrentHashMap<String, ArrayList<Object>> cm = new ConcurrentHashMap<>();
	private String str = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
			+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS MAX_LENGTH " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = 'AAA' "
			+ "AND c.TABLE_NAME = 'BBB'";
	private StringBuffer sql = new StringBuffer();

	public test() {
		String yearMonth = "2014-9";
		String deptGroup = "21";
		sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d").append(" WHERE p.`process_id` = 1")
				.append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth)
				.append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'").append("GROUP BY a.`apply_dept`")
				.append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (").append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(*) cout")
				.append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d").append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`")
				.append("AND p.`biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'")
				.append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'").append("GROUP BY SUBSTR(a.`apply_dept`,1,3)")
				.append(") b,s_sys_department rd").append(" WHERE b.apply_dept = rd.dept_code");
		System.out.println(sql.toString());
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
