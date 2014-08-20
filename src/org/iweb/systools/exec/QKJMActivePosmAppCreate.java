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
public class QKJMActivePosmAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("活动物料(公司)");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("active_posm");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_active_posm");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("active_id", new TableColumn("active_id", "活动申请ID", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd"));
		m.put("title", new TableColumn("title", "名目", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd"));
		m.put("note", new TableColumn("note", "说明", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd"));
		m.put("total_price", new TableColumn("total_price", "金额", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMActivePosmAppCreate ac = new QKJMActivePosmAppCreate();
		ac.execute();
	}
}
