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
public class OrderCellarAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		super.setApp(new AppInfo());
		AppInfo ai = super.getApp();
		ai.setApp_name("藏酒");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("order_cellar");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_r_order_cellar");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> pt = new ArrayList<>();
		pt.add(new ListObject("0", "余额支付"));
		pt.add(new ListObject("1", "网上银行支付"));
		pt.add(new ListObject("2", "货到付款"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, ""));
		m.put("order_goods_id", new TableColumn("order_goods_id", "订单商品ID", 0, 1, 0, 1, 1, 0, null, ""));
		m.put("cellar_no", new TableColumn("cellar_no", "藏酒位置号", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("num", new TableColumn("num", "初始库存", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("stock", new TableColumn("stock", "剩余库存", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("camera", new TableColumn("camera", "实时摄像头链接", 0, 1, 1, 1, 0, 0, null, ""));

		ai.setTcs(m);

		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		OrderCellarAppCreate ac = new OrderCellarAppCreate();
		ac.execute();
	}
}
