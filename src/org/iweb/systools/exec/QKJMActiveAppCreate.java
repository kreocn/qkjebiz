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
public class QKJMActiveAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("活动申请单");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("active");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_active");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		// 申请单状态 0:新申请 1:申请中 2:申请通过
		List<ListObject> g1 = new ArrayList<>();
		g1.add(new ListObject("0", "新申请"));
		g1.add(new ListObject("1", "申请中"));
		g1.add(new ListObject("2", "申请通过"));

		// 销售部-审核状态 0:新单 1:待审核 2:办事处经理已审 3:区域经理已审 4:运营总监已审 5:业务副总已审
		List<ListObject> g2 = new ArrayList<>();
		g2.add(new ListObject("0", "新单"));
		g2.add(new ListObject("1", "待审核"));
		g2.add(new ListObject("2", "办事处经理已审"));
		g2.add(new ListObject("3", "区域经理已审"));
		g2.add(new ListObject("4", "运营总监已审"));
		g2.add(new ListObject("5", "业务副总已审"));

		// 销售管理部-审核状态 0:未签收 1:已签收 2:主管已审 3:经理已审 4:销管部经理已审 5:副总已审 6:总经理已审
		List<ListObject> g3 = new ArrayList<>();
		g3.add(new ListObject("0", "未签收"));
		g3.add(new ListObject("1", "已签收"));
		g3.add(new ListObject("2", "主管已审"));
		g3.add(new ListObject("3", "经理已审"));
		g3.add(new ListObject("4", "销管部经理已审"));
		g3.add(new ListObject("5", "副总已审"));
		g3.add(new ListObject("6", "总经理已审"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "申请编号", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_dept", new TableColumn("apply_dept", "申请部门", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd"));
		m.put("apply_user", new TableColumn("apply_user", "申请人", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd"));
		m.put("theme", new TableColumn("theme", "主题", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd"));
		m.put("purpose", new TableColumn("purpose", "目的", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd"));
		m.put("plan_start", new TableColumn("plan_start", "计划开始时间", 0, 1, 1, 0, 1, 0, null, "yyyy-MM-dd"));
		m.put("plan_end", new TableColumn("plan_end", "计划结束时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd"));
		m.put("address", new TableColumn("address", "活动地点", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("person", new TableColumn("person", "执行人", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("note", new TableColumn("note", "方案说明", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("expect", new TableColumn("expect", "活动预期", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("status", new TableColumn("status", "申请单状态", 0, 0, 0, 1, 0, 6, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("sd_status", new TableColumn("sd_status", "销售部-审核状态", 0, 0, 0, 0, 1, 6, g2, "yyyy-MM-dd HH:mm:ss"));
		m.put("sd_time", new TableColumn("sd_time", "销售部审核状态最后操作时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("smd_status", new TableColumn("smd_status", "销售管理部-审核状态", 0, 0, 0, 0, 1, 6, g3, "yyyy-MM-dd HH:mm:ss"));
		m.put("smd_time", new TableColumn("smd_time", "销售管理部审核状态最后操作时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMActiveAppCreate ac = new QKJMActiveAppCreate();
		ac.execute();
	}
}
