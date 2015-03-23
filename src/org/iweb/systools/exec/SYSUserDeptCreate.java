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
public class SYSUserDeptCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("会员积分消费");
		ai.setPackage_name("org.iweb.sysvip");
		ai.setApp_en("member_capital_rescore");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("s_vip_capital_rescore");
		ai.setJsp_path("sysvip");
		ai.setName_space("sysvip");

		List<ListObject> g = new ArrayList<>();
		g.add(new ListObject("1", "低端"));
		g.add(new ListObject("2", "中端"));
		g.add(new ListObject("3", "中高端"));
		g.add(new ListObject("4", "高端"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("member_id", new TableColumn("member_id", "会员ID", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("score", new TableColumn("score", "积分", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("status", new TableColumn("status", "状态", 0, 0, 1, 1, 1, 1, g, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "申请人", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "申请时间", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 1, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "最后修改时间", 0, 0, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		SYSUserDeptCreate ac = new SYSUserDeptCreate();
		ac.execute();
	}
}
