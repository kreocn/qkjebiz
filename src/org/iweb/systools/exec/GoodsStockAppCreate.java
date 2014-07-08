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
public class GoodsStockAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("订单历史");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("goods_stock");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_r_goods_stock");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "商品ID", 1, 0, 0, 0, 1, 0, null, ""));
		m.put("stock_num", new TableColumn("stock_num", "现有库存", 0, 1, 0, 0, 0, 0, null, ""));
		m.put("froze_num", new TableColumn("froze_num", "冻结库存", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("break_num", new TableColumn("break_num", "损坏数量", 0, 1, 0, 1, 0, 0, null, ""));
		m.put("lm_time", new TableColumn("lm_time", "改动时间", 0, 0, 0, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		GoodsStockAppCreate ac = new GoodsStockAppCreate();
		ac.execute();
	}
}
