/**
 * 
 */
package org.iweb.systools.exec;

import java.util.LinkedHashMap;
import java.util.Map;

import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-30 下午12:01:36
 */
public class QKJMApproveAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("至事由申请会审");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("approve");
		ai.setApp_code("qkjm");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkjm_r_approve");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid", new TableColumn("uuid", "系统编号", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("approve_type", new TableColumn("approve_type", "审阅类型", 0, 1, 1, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("int_id", new TableColumn("int_id", "所有int类型的id", 0, 1, 1, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("varchar_id", new TableColumn("varchar_id", "所有字符型id", 0, 1, 1, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("flag", new TableColumn("flag", "审核标记", 0, 1, 1, 1, 0, 1, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_user", new TableColumn("check_user", "审核人", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("advice", new TableColumn("advice", "审核意见", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("ad_time", new TableColumn("ad_time", "审核时间", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMApproveAppCreate ac = new QKJMApproveAppCreate();
		ac.execute();
	}
}
