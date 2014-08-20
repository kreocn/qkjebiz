/**
 * 
 */
package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-30 下午12:01:36
 */
public class QKJALeaveAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("请假单");
		ai.setPackage_name("com.qkj.adm");
		ai.setApp_en("leave");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkja_r_leave");
		ai.setJsp_path("adm");
		ai.setName_space("adm");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "主键自增", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_type", new TableColumn("leave_type", "类型 0出差 1请假 2加班 3换休", 0, 1, 1, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_dept", new TableColumn("leave_dept", "申请部门", 0, 1, 1, 0, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_user", new TableColumn("leave_user", "申请人", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_start", new TableColumn("leave_start", "开始日期", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_start_time", new TableColumn("leave_start_time", "开始时间", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_end", new TableColumn("leave_end", "结束日期", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("leave_end_time", new TableColumn("leave_end_time", "结束时间", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("totle", new TableColumn("totle", "共计", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cause", new TableColumn("cause", "事由", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_status", new TableColumn("check_status", "审核状态", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_user", new TableColumn("check_user", "审核人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_time", new TableColumn("check_time", "审核时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_note", new TableColumn("check_note", "审核意见", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_status", new TableColumn("acheck_status", "行政审核状态", 0, 1, 1, 0, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_user", new TableColumn("acheck_user", "行政审核人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_time", new TableColumn("acheck_time", "行政审核时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_note", new TableColumn("acheck_note", "行政审核意见", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "最后修改时间", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("allowance_status", new TableColumn("allowance_status", "已补贴", 0, 1, 1, 0, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("allowance_date", new TableColumn("allowance_date", "补贴时间", 0, 1, 1, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJALeaveAppCreate ac = new QKJALeaveAppCreate();
		ac.execute();
	}
}
