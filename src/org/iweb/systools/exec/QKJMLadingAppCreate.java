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
public class QKJMLadingAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("出库提货单");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("lading");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_lading");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		List<ListObject> g = new ArrayList<>();
		g.add(new ListObject("0", "新单"));
		g.add(new ListObject("1", "待批"));
		g.add(new ListObject("2", "结案"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "申请编号", 1, 0, 0, 0, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("member_id", new TableColumn("member_id", "客户ID", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("content", new TableColumn("content", "内容", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("address", new TableColumn("address", "配送地点", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("note", new TableColumn("note", "其他说明", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("manager_check", new TableColumn("manager_check", "渠道/运营经理确认", 0, 1, 0, 1, 0, 0, null,
				"yyyy-MM-dd HH:mm:ss"));
		m.put("manager_check_time", new TableColumn("manager_check_time", "确认时间", 0, 0, 0, 1, 0, 6, null,
				"yyyy-MM-dd HH:mm:ss"));
		m.put("sd_check", new TableColumn("sd_check", "销售部经理确认", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("sd_check_time", new TableColumn("sd_check_time", "确认时间", 0, 0, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("md_check", new TableColumn("md_check", "市场部经理确认", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("md_check_time", new TableColumn("md_check_time", "确认时间", 0, 0, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("fd_check", new TableColumn("fd_check", "财务确认", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("fd_check_time", new TableColumn("fd_check_time", "确认时间", 0, 0, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("coo_check", new TableColumn("coo_check", "运营总监确认", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("coo_check_time",
				new TableColumn("coo_check_time", "确认时间", 0, 0, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("status", new TableColumn("status", "状态", 0, 1, 0, 1, 0, 1, g, "yyyy-MM-dd HH:mm:ss"));
		m.put("close_time", new TableColumn("close_time", "结案时间", 0, 0, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("applicant", new TableColumn("applicant", "申请人ID", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_time", new TableColumn("apply_time", "申请时间", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人ID", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "最后修改时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMLadingAppCreate ac = new QKJMLadingAppCreate();
		ac.execute();
	}
}
