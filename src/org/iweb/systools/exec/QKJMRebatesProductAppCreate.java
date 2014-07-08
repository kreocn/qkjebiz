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
public class QKJMRebatesProductAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		super.setApp(new AppInfo());
		AppInfo ai = super.getApp();
		ai.setApp_name("实体返利列表");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("rebates_product");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_rebates_product");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> p = new ArrayList<>();
		p.add(new ListObject("0", "余额支付"));
		p.add(new ListObject("1", "网上银行支付"));
		p.add(new ListObject("2", "货到付款"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("rebates_id", new TableColumn("rebates_id", "返利申请号", 0, 1, 0, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("product_id", new TableColumn("product_id", "产品ID", 0, 1, 0, 1, 0, 1, p, "yyyy-MM-dd HH:mm:ss"));
		m.put("per_price", new TableColumn("per_price", "单价", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("num", new TableColumn("num", "数量", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("total_price", new TableColumn("total_price", "总价", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);

		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMRebatesProductAppCreate ac = new QKJMRebatesProductAppCreate();
		ac.execute();
	}
}
