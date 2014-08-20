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
 * 
 * @author Kreo
 * 
 */
public class QKJMProcessAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("请假单");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("process");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkjm_h_process");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		// 0无 1活动 2至事由 3:工时
		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "主键自增", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("process_id", new TableColumn("process_id", "类型", 0, 1, 1, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_id", new TableColumn("biz_id", "业务ID", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_user", new TableColumn("biz_user", "业务时间", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_time", new TableColumn("biz_time", "业务人", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_note", new TableColumn("biz_note", "业务备注", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_status01", new TableColumn("biz_status01", "业务状态1", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_status02", new TableColumn("biz_status02", "业务状态2", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_status03", new TableColumn("biz_status03", "业务状态3", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_status04", new TableColumn("biz_status04", "业务状态4", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_status05", new TableColumn("biz_status05", "业务状态5", 0, 1, 1, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("biz_sign", new TableColumn("biz_sign", "业务标记", 0, 1, 1, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMProcessAppCreate ac = new QKJMProcessAppCreate();
		ac.execute();
	}
}
