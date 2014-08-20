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
public class QKJMLadingItemAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		super.setApp(new AppInfo());
		AppInfo ai = super.getApp();
		ai.setApp_name("提货单明细");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("lading_item");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_lading_item");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> pt = new ArrayList<>();
		pt.add(new ListObject("0", "余额支付"));
		pt.add(new ListObject("1", "网上银行支付"));
		pt.add(new ListObject("2", "货到付款"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 1, 1, 4, null, ""));
		m.put("lading_id", new TableColumn("lading_id", "提货单ID", 0, 1, 0, 0, 1, 4, null, ""));
		m.put("product_id", new TableColumn("product_id", "产品ID", 0, 1, 0, 1, 0, 1, pt, ""));
		m.put("per_price", new TableColumn("per_price", "单价", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("num", new TableColumn("num", "订单数量", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("total_price", new TableColumn("total_price", "实际价格", 0, 1, 1, 1, 0, 0, null, ""));

		ai.setTcs(m);

		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMLadingItemAppCreate ac = new QKJMLadingItemAppCreate();
		ac.execute();
	}
}
