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
 * @date 2014-2-17 下午2:19:13
 */
public class QKJMRebatesAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("返利申请单");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("rebates");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_rebates");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		List<ListObject> g = new ArrayList<>();
		g.add(new ListObject("0", "新单"));
		g.add(new ListObject("1", "待批"));
		g.add(new ListObject("2", "结案"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("member_id", new TableColumn("member_id", "会员ID", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("re_type", new TableColumn("re_type", "返利类型", 0, 1, 0, 1, 1, 2, g, "yyyy-MM-dd HH:mm:ss"));
		m.put("re_form", new TableColumn("re_form", "返利方式", 0, 1, 0, 1, 1, 2, g, "yyyy-MM-dd HH:mm:ss"));
		m.put("re_score", new TableColumn("re_score", "返利积分", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("re_money", new TableColumn("re_money", "返现金数", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("status", new TableColumn("status", "状态", 0, 0, 1, 1, 0, 6, g, "yyyy-MM-dd HH:mm:ss"));
		m.put("applicant", new TableColumn("applicant", "申请人ID", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_time", new TableColumn("apply_time", "申请时间", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
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
		QKJMRebatesAppCreate ac = new QKJMRebatesAppCreate();
		ac.execute();
	}
}
