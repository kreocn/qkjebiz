package org.iweb.rpt.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.DateUtil;

import com.opensymphony.xwork2.ActionSupport;

public class CheckEffMonthlyStatAction extends ActionSupport {
	private static final long serialVersionUID = 5402660473816753547L;
	private static Log log = LogFactory.getLog(CheckEffMonthlyStatAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private String yearMonth;// 参数 年-月
	private List<ListObject> yearMonths;

	private String deptGroup;// 部门集合
	private List<ListObject> deptGroups;

	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String execute() throws Exception {
		/* ContextHelper.isPermit("QKJ_SCHE"); */
		// 初始化数据
		setYearMonths();
		setDeptGroups();

		return SUCCESS;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	public List<ListObject> getYearMonths() {
		return yearMonths;
	}

	private void setYearMonths() {
		String patten = "yyyy-MM";
		Date ds = DateUtil.getDate("2014-08", patten);
		Date de = DateUtil.addMonth(DateUtil.getDate(new Date(), patten), 1);
		while (ds.before(de)) {
			yearMonths.add(new ListObject(DateUtil.format(ds, patten), DateUtil.format(ds, patten)));
			ds = DateUtil.addMonth(ds, 1);
		}
	}

	public String getDeptGroup() {
		return deptGroup;
	}

	public void setDeptGroup(String deptGroup) {
		this.deptGroup = deptGroup;
	}

	public List<ListObject> getDeptGroups() {
		return deptGroups;
	}

	private void setDeptGroups() {
		deptGroups.add(new ListObject("21", "省外运营中心+北京"));
		deptGroups.add(new ListObject("220", "西北运营中心"));
	}

	/**
	 * 根据定制的参数返回相应的SQL
	 * 
	 * @param n
	 *            0:活动申请平均时间 1:活动结案平均时间 2:至事由平均时间
	 * @return
	 */
	public String initSQL(int n) {
		// ").append("'").append(yearMonth).append("'").append("
		// ").append(deptGroup).append("
		StringBuffer sql = new StringBuffer();
		// 活动申请平均时间
		if (n == 0) sql.append("SELECT ").append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.at))/3600/24),2) total,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.ct)-UNIX_TIMESTAMP(o.at))/3600/24),2) edit,").append("ROUND(AVG((UNIX_TIMESTAMP(o.mt)-UNIX_TIMESTAMP(o.ct))/3600/24),2) mct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.xt)-UNIX_TIMESTAMP(o.mt))/3600/24),2) xct,").append("ROUND(AVG((UNIX_TIMESTAMP(o.zt)-UNIX_TIMESTAMP(o.xt))/3600/24),2) zct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.xt))/3600/24),2) pct").append(" FROM (")
				.append("SELECT biz_id,MAX(`at`) `at`,MAX(`ct`) `ct`,MAX(`mt`) `mt`,MAX(`xt`) `xt`,MAX(`zt`) `zt`,MAX(`pt`) `pt`").append("FROM (")
				.append("SELECT p.biz_id,p.biz_time `at`,0 `ct`,0 `mt`,0 `xt`,0 `zt`,0 `pt`").append("FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_ADD'").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND `biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'")
				.append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`")
				.append(")").append("UNION ALL").append(" SELECT p.biz_id,0,p.biz_time,0,0,0,0").append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_MDY_STATUS'").append("AND p.biz_status01 = 1").append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process")
				.append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth)
				.append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND biz_sign = 'ACTIVE_MDY_STATUS'").append("AND biz_status01 = 1").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")")
				.append("UNION ALL").append(" SELECT p.biz_id,0,0,p.biz_time,0,0,0").append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_MDY_SDSTATUS'").append("AND p.biz_status01 = 1").append(" AND p.`biz_status02` = 30").append(" AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(")
				.append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND biz_sign = 'ACTIVE_MDY_SDSTATUS'").append("AND biz_status01 = 1").append(" AND biz_status02 = 30").append(" GROUP BY biz_id")
				.append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append(" SELECT p.biz_id,0,0,0,p.biz_time,0,0").append(" FROM qkjm_h_process p")
				.append(" WHERE p.`process_id` = 1").append(" AND p.biz_sign = 'ACTIVE_MDY_SMDSTATUS'").append("AND p.biz_status01 = 1").append(" AND p.`biz_status02` = 30")
				.append(" AND p.`biz_status03` = 30").append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND `biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'")
				.append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`")
				.append(")").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND biz_sign = 'ACTIVE_MDY_SMDSTATUS'").append("AND biz_status01 = 1").append(" AND `biz_status02` = 30").append(" AND `biz_status03` = 30")
				.append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append(" SELECT p.biz_id,0,0,0,0,p.biz_time,0")
				.append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1").append(" AND p.biz_sign = 'ACTIVE_MDY_SDSTATUS'").append("AND p.biz_status01 = 1")
				.append(" AND p.`biz_status02` = 40").append(" AND p.`biz_status03` = 30").append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process")
				.append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth)
				.append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND biz_sign = 'ACTIVE_MDY_SDSTATUS'").append("AND biz_status01 = 1").append(" AND `biz_status02` = 40").append(" AND `biz_status03` = 30")
				.append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append(" SELECT `biz_id`,0,0,0,0,0,`biz_time`")
				.append("FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_APPLY_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(")
				.append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append(") t").append(" GROUP BY t.biz_id").append(") o").append(" WHERE o.`at` <> 0").append(" AND EXISTS (").append("SELECT 1 FROM qkjm_r_active a")
				.append(" WHERE a.`apply_dept` LIKE '").append(deptGroup).append("%'").append("AND a.`uuid` = o.`biz_id`").append(")");

		// 活动结案平均时间
		if (n == 1) sql.append("SELECT ").append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.at))/3600/24),2) total,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.ct)-UNIX_TIMESTAMP(o.at))/3600/24),2) edit,").append("ROUND(AVG((UNIX_TIMESTAMP(o.mt)-UNIX_TIMESTAMP(o.ct))/3600/24),2) mct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.xt)-UNIX_TIMESTAMP(o.mt))/3600/24),2) xct,").append("ROUND(AVG((UNIX_TIMESTAMP(o.zt)-UNIX_TIMESTAMP(o.xt))/3600/24),2) zct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.xt))/3600/24),2) pct").append(" FROM (")
				.append("SELECT biz_id,MAX(`at`) `at`,MAX(`ct`) `ct`,MAX(`mt`) `mt`,MAX(`xt`) `xt`,MAX(`zt`) `zt`,MAX(`pt`) `pt`").append("FROM (")
				.append("SELECT p.biz_id,p.biz_time `at`,0 `ct`,0 `mt`,0 `xt`,0 `zt`,0 `pt`").append("FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_START_CLOSE'").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND `biz_sign` = 'ACTIVE_CLOSE_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'")
				.append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`")
				.append(")").append("UNION ALL").append(" SELECT p.biz_id,0,p.biz_time,0,0,0,0").append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_MDY_STATUS'").append("AND p.biz_status01 = 4").append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process")
				.append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_CLOSE_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth)
				.append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND biz_sign = 'ACTIVE_MDY_STATUS'").append("AND biz_status01 = 4").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")")
				.append("UNION ALL").append(" SELECT p.biz_id,0,0,p.biz_time,0,0,0").append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_CLOSE_SDSTATUS'").append("AND p.biz_status01 = 4").append(" AND p.`biz_status04` = 30").append(" AND EXISTS (")
				.append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND biz_sign = 'ACTIVE_CLOSE_SDSTATUS'").append("AND biz_status01 = 4")
				.append(" AND biz_status04 = 30").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append("UNION ALL")
				.append(" SELECT p.biz_id,0,0,0,p.biz_time,0,0").append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_CLOSE_SMDSTATUS'").append("AND p.biz_status01 = 4").append(" AND p.`biz_status04` = 30").append(" AND p.`biz_status05` = 30")
				.append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND biz_sign = 'ACTIVE_CLOSE_SMDSTATUS'").append("AND biz_status01 = 4")
				.append(" AND `biz_status04` = 30").append(" AND `biz_status05` = 30").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")")
				.append("UNION ALL").append(" SELECT p.biz_id,0,0,0,0,p.biz_time,0").append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 1")
				.append(" AND p.biz_sign = 'ACTIVE_CLOSE_SDSTATUS'").append("AND p.biz_status01 = 4").append(" AND p.`biz_status04` = 40").append(" AND p.`biz_status05` = 30")
				.append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND `biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 1").append(" AND biz_sign = 'ACTIVE_CLOSE_SDSTATUS'").append("AND biz_status01 = 4")
				.append(" AND `biz_status04` = 40").append(" AND `biz_status05` = 30").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")")
				.append("UNION ALL").append(" SELECT `biz_id`,0,0,0,0,0,`biz_time`").append("FROM qkjm_h_process").append(" WHERE `process_id` = 1")
				.append(" AND `biz_sign` = 'ACTIVE_CLOSE_PASS'").append("AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'")
				.append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')").append(") t").append(" GROUP BY t.biz_id")
				.append(") o").append(" WHERE o.`at` <> 0").append(" AND EXISTS (").append("SELECT 1 FROM qkjm_r_active a").append(" WHERE a.`apply_dept` LIKE '")
				.append(deptGroup).append("%'").append("AND a.`uuid` = o.`biz_id`").append(")");

		// 至事由平均时间
		if (n == 2) sql.append("SELECT ").append("ROUND(AVG((UNIX_TIMESTAMP(o.zt)-UNIX_TIMESTAMP(o.at))/3600/24),2) total,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.ct)-UNIX_TIMESTAMP(o.at))/3600/24),2) edit,").append("ROUND(AVG((UNIX_TIMESTAMP(o.mt)-UNIX_TIMESTAMP(o.ct))/3600/24),2) mct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.zt)-UNIX_TIMESTAMP(o.mt))/3600/24),2) zct").append(" FROM (")
				.append("SELECT biz_id,MAX(`at`) `at`,MAX(`ct`) `ct`,MAX(`mt`) `mt`,MAX(`zt`) `zt`").append("FROM (")
				.append("SELECT p.biz_id,p.biz_time `at`,0 `ct`,0 `mt`,0 `zt`").append("FROM qkjm_h_process p").append(" WHERE p.`process_id` = 2")
				.append(" AND p.biz_sign = 'APPLY_ADD'").append("AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2")
				.append(" AND `biz_sign` = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 30").append(" AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth)
				.append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')")
				.append("AND biz_id = p.`biz_id`").append(")").append("UNION ALL").append("SELECT p.biz_id,0,p.biz_time,0,0").append(" FROM qkjm_h_process p")
				.append(" WHERE p.`process_id` = 2").append(" AND p.biz_sign = 'APPLY_CHANGE_STATUS'").append("AND p.biz_status01 = 10").append(" AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND `biz_sign` = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 30")
				.append(" AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND biz_sign = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 10")
				.append(" GROUP BY biz_id").append(" HAVING MIN(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append("SELECT p.biz_id,0,0,p.biz_time,0")
				.append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 2").append(" AND p.biz_sign = 'APPLY_CHANGE_STATUS'").append("AND p.biz_status01 = 20")
				.append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND `biz_sign` = 'APPLY_CHANGE_STATUS'")
				.append("AND biz_status01 = 30").append(" AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)")
				.append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`)").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND biz_sign = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 20")
				.append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append("SELECT p.biz_id,0,0,0,p.biz_time")
				.append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 2").append(" AND p.biz_sign = 'APPLY_CHANGE_STATUS'").append("AND p.biz_status01 = 30")
				.append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND biz_sign = 'APPLY_CHANGE_STATUS'")
				.append("AND biz_status01 = 30").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append(") t").append(" GROUP BY t.biz_id")
				.append(") o").append(" WHERE o.`at` <> 0").append(" AND EXISTS (").append("SELECT 1 FROM qkjm_r_apply a").append(" WHERE a.`apply_dept` LIKE '21%'")
				.append("AND a.`uuid` = o.`biz_id`").append(")");

		// 当月活动申请通过数量
		if (n == 3) sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_APPLY_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY a.`apply_dept`").append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (")
				.append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_APPLY_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY SUBSTR(a.`apply_dept`,1,3)").append(") b,s_sys_department rd").append(" WHERE b.apply_dept = rd.dept_code");

		// 当月活动结案通过数量
		if (n == 4) sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY a.`apply_dept`").append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (")
				.append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY SUBSTR(a.`apply_dept`,1,3)").append(") b,s_sys_department rd").append(" WHERE b.apply_dept = rd.dept_code");

		// 当月至事由通过数量
		if (n == 5) sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_apply a,s_sys_department d")
				.append(" WHERE p.`process_id` = 2").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 30")
				.append(" AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY a.`apply_dept`").append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (")
				.append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(*) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 2").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 30")
				.append(" AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY SUBSTR(a.`apply_dept`,1,3)").append(") b,s_sys_department rd").append(" WHERE b.apply_dept = rd.dept_code").append(";");

		return sql.toString();
	}

	public static void main(String[] args) {
		CheckEffMonthlyStatAction a = new CheckEffMonthlyStatAction();
		a.setYearMonth("2014-08");
		// System.out.println(a.initSQL());
	}

}
