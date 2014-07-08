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
public class GoodsItemAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("商品附加信息");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("goods_info");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_t_goods_info");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, ""));
		m.put("goods_id", new TableColumn("goods_id", "商品ID", 0, 1, 0, 0, 1, 0, null, ""));
		m.put("column_1", new TableColumn("column_1", "column_1", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_2", new TableColumn("column_2", "column_2", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_3", new TableColumn("column_3", "column_3", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_4", new TableColumn("column_4", "column_4", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_5", new TableColumn("column_5", "column_5", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_6", new TableColumn("column_6", "column_6", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_7", new TableColumn("column_7", "column_7", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_8", new TableColumn("column_8", "column_8", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_9", new TableColumn("column_9", "column_9", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_10", new TableColumn("column_10", "column_10", 0, 1, 1, 1, 1, 0, null, ""));
		m.put("column_11", new TableColumn("column_11", "column_11", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_12", new TableColumn("column_12", "column_12", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_13", new TableColumn("column_13", "column_13", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_14", new TableColumn("column_14", "column_14", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_15", new TableColumn("column_15", "column_15", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_16", new TableColumn("column_16", "column_16", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_17", new TableColumn("column_17", "column_17", 0, 1, 1, 0, 1, 0, null, ""));
		m.put("column_18", new TableColumn("column_18", "column_18", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_19", new TableColumn("column_19", "column_19", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_20", new TableColumn("column_20", "column_20", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_21", new TableColumn("column_21", "column_21", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_22", new TableColumn("column_22", "column_22", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("column_23", new TableColumn("column_23", "column_23", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_24", new TableColumn("column_24", "column_24", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_25", new TableColumn("column_25", "column_25", 0, 1, 1, 0, 1, 0, null, ""));
		m.put("column_26", new TableColumn("column_26", "column_26", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_27", new TableColumn("column_27", "column_27", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_28", new TableColumn("column_28", "column_28", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_29", new TableColumn("column_29", "column_29", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("column_30", new TableColumn("column_30", "column_30", 0, 1, 1, 0, 0, 0, null, ""));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		GoodsItemAppCreate ac = new GoodsItemAppCreate();
		ac.execute();
	}
}
