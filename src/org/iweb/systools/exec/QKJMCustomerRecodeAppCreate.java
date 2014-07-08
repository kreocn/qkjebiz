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
public class QKJMCustomerRecodeAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("客户回访记录");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("customer_recode");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_customer_recode");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		// 回访方式
		List<ListObject> g1 = new ArrayList<>();
		g1.add(new ListObject("0", "电话回访"));
		g1.add(new ListObject("1", "当面拜访"));
		g1.add(new ListObject("2", "其他方式"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("customer_id", new TableColumn("customer_id", "回访客户ID", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("recode_time", new TableColumn("recode_time", "拜访日期", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("type", new TableColumn("type", "回访方式", 0, 1, 1, 1, 1, 2, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("person", new TableColumn("person", "受访人", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("content", new TableColumn("content", "访谈内容", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("promise", new TableColumn("promise", "给予客户承诺", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("next_date", new TableColumn("next_date", "下次拜访时间", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
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
		QKJMCustomerRecodeAppCreate ac = new QKJMCustomerRecodeAppCreate();
		ac.execute();
	}
}
