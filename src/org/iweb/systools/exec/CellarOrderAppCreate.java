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
public class CellarOrderAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		super.setApp(new AppInfo());
		AppInfo ai = super.getApp();
		ai.setApp_name("取酒订单");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("cellar_order");
		ai.setApp_code("qkjcj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_r_cellar_order");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		// 0客户自助下单 1代客下单
		List<ListObject> os = new ArrayList<>();
		os.add(new ListObject("0", "客户自助下单"));
		os.add(new ListObject("1", "代客下单"));

		// 订单状态 0 作废订单 10 新订单 20 已灌装 30 已发货 40 已收货 50 已评价
		List<ListObject> s = new ArrayList<>();
		s.add(new ListObject("0", "作废订单"));
		s.add(new ListObject("10", "新订单"));
		s.add(new ListObject("20", "已灌装"));
		s.add(new ListObject("30", "已发货"));
		s.add(new ListObject("40", "已收货"));
		s.add(new ListObject("50", "已评价"));

		m.put("uuid", new TableColumn("uuid", "取酒订单号", 1, 0, 0, 0, 1, 0, null, ""));
		m.put("order_cellar", new TableColumn("order_cellar", "取酒位置", 0, 1, 0, 1, 1, 0, null, ""));
		m.put("order_num", new TableColumn("order_num", "取酒数量", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_name", new TableColumn("con_name", "收货人姓名", 0, 1, 1, 1, 1, 0, null, ""));
		m.put("con_province", new TableColumn("con_province", "省/直辖市", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_city", new TableColumn("con_city", "市/区", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_area", new TableColumn("con_area", "县", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_post", new TableColumn("con_post", "邮编", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_street", new TableColumn("con_street", "街道地址", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_mobile", new TableColumn("con_mobile", "手机/联系电话", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_note", new TableColumn("con_note", "客户备注", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("express_type", new TableColumn("express_type", "配送方式", 0, 1, 1, 1, 1, 0, null, ""));
		m.put("express_no", new TableColumn("express_no", "快递单号", 0, 0, 1, 0, 0, 0, null, ""));
		m.put("order_video", new TableColumn("order_video", "视频地址", 0, 0, 1, 0, 0, 0, null, ""));
		m.put("order_source", new TableColumn("order_source", "订单来源", 0, 1, 1, 0, 0, 1, os, ""));
		m.put("status", new TableColumn("status", "订单状态", 0, 1, 1, 0, 1, 1, s, ""));
		m.put("add_user", new TableColumn("add_user", "0", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("add_time", new TableColumn("add_time", "0", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "0", 0, 1, 1, 0, 1, 0, null, ""));
		m.put("lm_time", new TableColumn("lm_time", "0", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		CellarOrderAppCreate ac = new CellarOrderAppCreate();
		ac.execute();
	}
}
