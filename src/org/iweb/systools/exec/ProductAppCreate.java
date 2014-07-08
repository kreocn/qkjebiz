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
public class ProductAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("产品");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("product");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_t_product");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		List<ListObject> g = new ArrayList<>();
		g.add(new ListObject("1", "低端"));
		g.add(new ListObject("2", "中端"));
		g.add(new ListObject("3", "中高端"));
		g.add(new ListObject("4", "高端"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, ""));
		m.put("brand", new TableColumn("brand", "系列/类型/品牌", 0, 1, 1, 0, 1, 0, null, ""));
		m.put("title", new TableColumn("title", "品名", 0, 1, 1, 1, 1, 0, null, ""));
		m.put("spec", new TableColumn("spec", "规格(500ml)", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("case_spec", new TableColumn("case_spec", "数量(件)", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("alcohol", new TableColumn("alcohol", "酒精度", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("flavor", new TableColumn("flavor", "香型", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("raw_materials", new TableColumn("raw_materials", "原材料", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("grade", new TableColumn("grade", "档次 1低端 2中端 3中高端 4高端", 0, 1, 1, 1, 1, 1, g, ""));
		m.put("market_price", new TableColumn("market_price", "市场价", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("group_price", new TableColumn("group_price", "团购价", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("dealer_price", new TableColumn("dealer_price", "经销商价格", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("group_rebates", new TableColumn("group_rebates", "团购返利点%", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("dealer_rebates", new TableColumn("dealer_rebates", "经销商返利点%", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("agree_price_1", new TableColumn("agree_price_1", "协议价1", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("agree_price_2", new TableColumn("agree_price_2", "协议价2", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("agree_price_3", new TableColumn("agree_price_3", "协议价3", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 1, 1, 0, 0, 6, null, ""));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		ProductAppCreate ac = new ProductAppCreate();
		ac.execute();
	}
}
