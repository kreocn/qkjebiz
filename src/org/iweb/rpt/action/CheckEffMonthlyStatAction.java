package org.iweb.rpt.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.CommonDAO;
import org.iweb.rpt.domain.ActiveNum;
import org.iweb.rpt.domain.ActiveTime;
import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.DateUtil;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

public class CheckEffMonthlyStatAction extends ActionSupport {
	private static final long serialVersionUID = 5402660473816753547L;
	private static Log log = LogFactory.getLog(CheckEffMonthlyStatAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private CommonDAO dao = new CommonDAO();

	// private Map activeAvgTime;
	// private Map activeCloseAvgTime;
	// private Map applyAvgTime;
	private ActiveTime activetime;
	private ActiveNum activenum;
	private List<ActiveTime> activeAvgTime;
	private List<ActiveTime> activeCloseAvgTime;
	private List<ActiveTime> applyAvgTime;
	private List<ActiveNum> activePasses;
	private List<ActiveNum> activeClosePasses;
	private List<ActiveNum> applyPasses;

	private List<ActiveNum> totelActivePasses;
	private List<ActiveNum> totelActiveClosePasses;
	private List<ActiveNum> totelApplyPasses;

	// private List<Map> activePasses;
	// private List<Map> activeClosePasses;
	// private List<Map> applyPasses;

	private String yearMonth;// 参数 年-月
	private List<ListObject> yearMonths;

	private String deptGroup;// 部门集合
	private List<ListObject> deptGroups;

	private String message;

	public List<ActiveNum> getTotelActivePasses() {
		return totelActivePasses;
	}

	public void setTotelActivePasses(List<ActiveNum> totelActivePasses) {
		this.totelActivePasses = totelActivePasses;
	}

	public List<ActiveNum> getTotelActiveClosePasses() {
		return totelActiveClosePasses;
	}

	public void setTotelActiveClosePasses(List<ActiveNum> totelActiveClosePasses) {
		this.totelActiveClosePasses = totelActiveClosePasses;
	}

	public List<ActiveNum> getTotelApplyPasses() {
		return totelApplyPasses;
	}

	public void setTotelApplyPasses(List<ActiveNum> totelApplyPasses) {
		this.totelApplyPasses = totelApplyPasses;
	}

	public ActiveTime getActivetime() {
		return activetime;
	}

	public void setActivetime(ActiveTime activetime) {
		this.activetime = activetime;
	}

	public ActiveNum getActivenum() {
		return activenum;
	}

	public void setActivenum(ActiveNum activenum) {
		this.activenum = activenum;
	}

	public List<ActiveTime> getActiveAvgTime() {
		return activeAvgTime;
	}

	public void setActiveAvgTime(List<ActiveTime> activeAvgTime) {
		this.activeAvgTime = activeAvgTime;
	}

	public List<ActiveTime> getActiveCloseAvgTime() {
		return activeCloseAvgTime;
	}

	public void setActiveCloseAvgTime(List<ActiveTime> activeCloseAvgTime) {
		this.activeCloseAvgTime = activeCloseAvgTime;
	}

	public List<ActiveTime> getApplyAvgTime() {
		return applyAvgTime;
	}

	public void setApplyAvgTime(List<ActiveTime> applyAvgTime) {
		this.applyAvgTime = applyAvgTime;
	}

	public List<ActiveNum> getActivePasses() {
		return activePasses;
	}

	public void setActivePasses(List<ActiveNum> activePasses) {
		this.activePasses = activePasses;
	}

	public List<ActiveNum> getActiveClosePasses() {
		return activeClosePasses;
	}

	public void setActiveClosePasses(List<ActiveNum> activeClosePasses) {
		this.activeClosePasses = activeClosePasses;
	}

	public List<ActiveNum> getApplyPasses() {
		return applyPasses;
	}

	public void setApplyPasses(List<ActiveNum> applyPasses) {
		this.applyPasses = applyPasses;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String execute() throws Exception {
		ContextHelper.isPermit("REPORT_CHECKEFF_MONTHLY");
		try {
			// 初始化数据
			setYearMonths();
			setDeptGroups();

			if (!ToolsUtil.isEmpty(yearMonth)) {
				/*
				 * this.setActiveAvgTime(dao.commonSelectMap(initSQL(0)));
				 * this.setActiveCloseAvgTime(dao.commonSelectMap(initSQL(1)));
				 * this.setApplyAvgTime(dao.commonSelectMap(initSQL(2)));
				 * this.setActivePasses(dao.commonSelectMapList(initSQL(3)));
				 * this.setActiveClosePasses(dao.commonSelectMapList(initSQL(4)));
				 * this.setApplyPasses(dao.commonSelectMapList(initSQL(5)));
				 */
				String dep = null;
				if (this.getDeptGroup() != null) {
					if (this.getDeptGroup().equals("21")) {
						dep = "2";
					} else if (this.getDeptGroup().equals("220")) {
						dep = "3";
					} else {
						dep = "1";
					}
				} else {
					dep = "1";
				}
				map.clear();
				map.put("atype", 1);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				this.setActiveAvgTime(dao.listbytime(map));
				map.clear();
				map.put("atype", 2);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				this.setActiveCloseAvgTime(dao.listbytime(map));
				map.clear();
				map.put("atype", 3);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				this.setApplyAvgTime(dao.listbytime(map));

				map.clear();
				map.put("atype", 1);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				map.put("merger", 1);
				this.setActivePasses(dao.listbynum(map));
				map.clear();
				map.put("atype", 1);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				map.put("merger", 2);
				this.setTotelActivePasses(dao.listbynum(map));

				map.clear();
				map.put("atype", 2);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				map.put("merger", 1);
				this.setActiveClosePasses(dao.listbynum(map));
				map.clear();
				map.put("atype", 2);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				map.put("merger", 2);
				this.setTotelActiveClosePasses(dao.listbynum(map));

				map.clear();
				map.put("atype", 3);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				map.put("merger", 1);
				this.setApplyPasses(dao.listbynum(map));

				map.clear();
				map.put("atype", 3);
				map.put("adate", yearMonth);
				map.put("acode", dep);
				map.put("merger", 2);
				this.setTotelApplyPasses(dao.listbynum(map));
				this.setMessage("报表生成成功!");
			} else {
				this.setMessage("请选择报表统计时间");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

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
		Calendar cal = Calendar.getInstance();// 使用日历类
		int day = cal.get(Calendar.DAY_OF_MONTH);// 得到天
		Date de = null;
		if (yearMonths == null) {
			yearMonths = new ArrayList<>();
		}
		String patten = "yyyy-MM";
		Date ds = DateUtil.getDate("2014-08", patten);
		if (day > 25) {
			de = DateUtil.addMonth(DateUtil.getDate(new Date(), patten), 1);
		} else {
			de = DateUtil.addMonth(DateUtil.getDate(new Date(), patten), 0);
		}
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
		if (deptGroups == null) {
			deptGroups = new ArrayList<>();
		}
		deptGroups.add(new ListObject("21", "省外运营中心+北京"));
		deptGroups.add(new ListObject("220", "西北运营中心"));
	}

	/**
	 * 根据定制的参数返回相应的SQL
	 * 
	 * @param n
	 *            0:活动申请平均时间 1:活动结案平均时间 2:至事由平均时间 3:活动申请通过数量 4:活动结案通过数量 5:至事由通过数量
	 * @return
	 */
	String initSQL(int n) {
		// ").append("'").append(yearMonth).append("'").append("
		// ").append(deptGroup).append("
		StringBuffer sql = new StringBuffer();
		// 活动申请平均时间
		if (n == 0) sql.append("SELECT ").append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.at))/3600/24),2) total,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.ct)-UNIX_TIMESTAMP(o.at))/3600/24),2) edit,").append("ROUND(AVG((UNIX_TIMESTAMP(o.mt)-UNIX_TIMESTAMP(o.ct))/3600/24),2) mct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.xt)-UNIX_TIMESTAMP(o.mt))/3600/24),2) xct,").append("ROUND(AVG((UNIX_TIMESTAMP(o.zt)-UNIX_TIMESTAMP(o.xt))/3600/24),2) zct,")
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.zt))/3600/24),2) pct").append(" FROM (")
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
				.append("ROUND(AVG((UNIX_TIMESTAMP(o.pt)-UNIX_TIMESTAMP(o.zt))/3600/24),2) pct").append(" FROM (")
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
				.append("AND biz_id = p.`biz_id`").append(")").append("UNION ALL").append(" SELECT p.biz_id,0,p.biz_time,0,0").append(" FROM qkjm_h_process p")
				.append(" WHERE p.`process_id` = 2").append(" AND p.biz_sign = 'APPLY_CHANGE_STATUS'").append("AND p.biz_status01 = 10").append(" AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND `biz_sign` = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 30")
				.append(" AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`").append(")").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND biz_sign = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 10")
				.append(" GROUP BY biz_id").append(" HAVING MIN(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append(" SELECT p.biz_id,0,0,p.biz_time,0")
				.append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 2").append(" AND p.biz_sign = 'APPLY_CHANGE_STATUS'").append("AND p.biz_status01 = 20")
				.append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND `biz_sign` = 'APPLY_CHANGE_STATUS'")
				.append("AND biz_status01 = 30").append(" AND `biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)")
				.append("AND CONCAT(").append("'").append(yearMonth).append("'").append(",'-26')").append("AND biz_id = p.`biz_id`)").append("AND EXISTS (").append("SELECT 1")
				.append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND biz_sign = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 20")
				.append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append("UNION ALL").append(" SELECT p.biz_id,0,0,0,p.biz_time")
				.append(" FROM qkjm_h_process p").append(" WHERE p.`process_id` = 2").append(" AND p.biz_sign = 'APPLY_CHANGE_STATUS'").append("AND p.biz_status01 = 30")
				.append(" AND EXISTS (").append("SELECT 1").append(" FROM qkjm_h_process").append(" WHERE `process_id` = 2").append(" AND biz_sign = 'APPLY_CHANGE_STATUS'")
				.append("AND biz_status01 = 30").append(" GROUP BY biz_id").append(" HAVING MAX(`uuid`) = p.`uuid`").append(")").append(") t").append(" GROUP BY t.biz_id")
				.append(") o").append(" WHERE o.`at` <> 0").append(" AND EXISTS (").append("SELECT 1 FROM qkjm_r_apply a").append(" WHERE a.`apply_dept` LIKE '21%'")
				.append("AND a.`uuid` = o.`biz_id`").append(")");

		// 当月活动申请通过数量
		if (n == 3) sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(DISTINCT biz_id) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_APPLY_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY a.`apply_dept`").append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (")
				.append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(DISTINCT biz_id) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_APPLY_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY SUBSTR(a.`apply_dept`,1,3)").append(") b,s_sys_department rd").append(" WHERE b.apply_dept = rd.dept_code");

		// 当月活动结案通过数量
		if (n == 4) sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(DISTINCT biz_id) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY a.`apply_dept`").append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (")
				.append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(DISTINCT biz_id) cout").append(" FROM qkjm_h_process p,qkjm_r_active a,s_sys_department d")
				.append(" WHERE p.`process_id` = 1").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'ACTIVE_CLOSE_PASS'")
				.append("AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY SUBSTR(a.`apply_dept`,1,3)").append(") b,s_sys_department rd").append(" WHERE b.apply_dept = rd.dept_code");

		// 当月至事由通过数量
		if (n == 5) sql.append("SELECT a.`apply_dept`,d.`dept_cname`,COUNT(DISTINCT biz_id) cout").append(" FROM qkjm_h_process p,qkjm_r_apply a,s_sys_department d")
				.append(" WHERE p.`process_id` = 2").append(" AND p.`biz_id` = a.`uuid`").append("AND p.`biz_sign` = 'APPLY_CHANGE_STATUS'").append("AND biz_status01 = 30")
				.append(" AND p.`biz_time` > DATE_ADD(CONCAT(").append("'").append(yearMonth).append("'").append(",'-26'), INTERVAL -1 MONTH)").append("AND CONCAT(").append("'")
				.append(yearMonth).append("'").append(",'-26')").append("AND a.`apply_dept` = d.`dept_code`").append("AND a.`apply_dept` LIKE '").append(deptGroup).append("%'")
				.append("GROUP BY a.`apply_dept`").append("UNION ALL").append(" SELECT b.apply_dept,rd.dept_cname,b.cout FROM (")
				.append("SELECT SUBSTR(a.`apply_dept`,1,3) `apply_dept`,COUNT(DISTINCT biz_id) cout").append(" FROM qkjm_h_process p,qkjm_r_apply a,s_sys_department d")
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
