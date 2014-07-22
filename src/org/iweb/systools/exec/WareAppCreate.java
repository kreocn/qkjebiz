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
public class WareAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("仓库");
		ai.setPackage_name("org.iweb.systools");
		ai.setApp_en("ware");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_warehouse");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 0, 5, null));
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));
		m.put("ware_class", new TableColumn("ware_class", "仓库类型", 0, 0, 0, 1, 1, 1, ws));
		m.put("ware_name", new TableColumn("ware_name", "仓库名", 0, 0, 0, 1, 1, 0, null));
		m.put("address", new TableColumn("address", "地址"));
		m.put("short_note", new TableColumn("short_note", "简短描述"));
		m.put("note", new TableColumn("note", "详细描述", 0, 1, 1, 0, 0, 8, null));
		m.put("map_data", new TableColumn("map_data", "地图数据"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 1, 1, 0, 0, 6, null));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 1, 1, 1, 0, 6, "yyyy-MM-dd HH:mm:ss", 1));
		ai.setTcs(m);

		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		WareAppCreate ac = new WareAppCreate();
		ac.execute();
	}
}
