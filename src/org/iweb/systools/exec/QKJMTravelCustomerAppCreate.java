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
public class QKJMTravelCustomerAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("工业旅游客户名单");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("travel_customer");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkjm_r_travel_customer");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键自增", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("travel_id", new TableColumn("travel_id", "旅游单ID", 0, 1, 0, 0, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_name", new TableColumn("cus_name", "客户姓名", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_sex", new TableColumn("cus_sex", "性别", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_company", new TableColumn("cus_company", "单位名称", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_type", new TableColumn("cus_type", "客户类别", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_phone", new TableColumn("cus_phone", "联系电话", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_idcard", new TableColumn("cus_idcard", "身份证号", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("note", new TableColumn("note", "备注", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMTravelCustomerAppCreate ac = new QKJMTravelCustomerAppCreate();
		ac.execute();
	}
}
