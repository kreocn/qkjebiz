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
public class QKJMApplyAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("至事由申请");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("apply");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkjm_r_apply");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

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

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("title", new TableColumn("title", "主题", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("note", new TableColumn("note", "详细说明", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_dept", new TableColumn("apply_dept", "申请部门", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_user", new TableColumn("apply_user", "申请人", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_time", new TableColumn("apply_time", "申请时间", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_user", new TableColumn("check_user", "审核人", 0, 0, 1, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_time", new TableColumn("check_time", "审核时间", 0, 0, 1, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_note", new TableColumn("check_note", "审核意见", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("status", new TableColumn("status", "状态", 0, 1, 1, 1, 1, 1, g3, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMApplyAppCreate ac = new QKJMApplyAppCreate();
		ac.execute();
	}
}
