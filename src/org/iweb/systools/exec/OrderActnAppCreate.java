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
public class OrderActnAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		super.setApp(new AppInfo());
		AppInfo ai = super.getApp();
		ai.setApp_name("订单历史");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("order_actn");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_h_order_actn");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> pt = new ArrayList<>();
		pt.add(new ListObject("0", "余额支付"));
		pt.add(new ListObject("1", "网上银行支付"));
		pt.add(new ListObject("2", "货到付款"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 5, null, ""));
		m.put("order_id", new TableColumn("order_id", "订单编号", 0, 1, 0, 0, 0, 6, null, ""));
		m.put("goods_id", new TableColumn("goods_id", "订单商品号", 0, 1, 0, 0, 0, 6, null, ""));
		m.put("action_type", new TableColumn("action_type", "操作类型", 0, 1, 1, 1, 0, 6, null, ""));
		m.put("original_value", new TableColumn("original_value", "旧值", 0, 1, 0, 0, 0, 6, null, ""));
		m.put("new_value", new TableColumn("new_value", "新值", 0, 1, 0, 0, 0, 6, null, ""));
		m.put("note", new TableColumn("note", "备注", 0, 1, 0, 1, 0, 6, null, ""));
		m.put("add_ip", new TableColumn("add_ip", "操作人IP", 0, 1, 0, 1, 0, 6, null, ""));
		m.put("add_user", new TableColumn("add_user", "操作人", 0, 1, 0, 1, 0, 6, null, ""));
		m.put("add_time", new TableColumn("add_time", "操作时间", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);

		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		OrderActnAppCreate ac = new OrderActnAppCreate();
		ac.execute();
	}
}
