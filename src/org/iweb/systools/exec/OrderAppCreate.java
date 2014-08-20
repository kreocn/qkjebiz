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
public class OrderAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		super.setApp(new AppInfo());
		AppInfo ai = super.getApp();
		ai.setApp_name("订单");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("order");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_r_order");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid", new TableColumn("uuid", "订单号", 1, 1, 0, 1, 1, 5, null, ""));
		m.put("order_type", new TableColumn("order_type", "订单类型", 0, 1, 1, 0, 0, 7, null, ""));
		m.put("user_id", new TableColumn("user_id", "购货人", 0, 1, 1, 1, 1, 0, null, ""));
		m.put("total_price", new TableColumn("total_price", "订单总价", 0, 0, 0, 1, 0, 6, null, ""));

		List<ListObject> pt = new ArrayList<>();
		pt.add(new ListObject("0", "余额支付"));
		pt.add(new ListObject("1", "网上银行支付"));
		pt.add(new ListObject("2", "货到付款"));
		pt.add(new ListObject("3", "银行打款"));
		pt.add(new ListObject("4", "当面收取"));
		pt.add(new ListObject("5", "积分付款"));
		m.put("pay_type", new TableColumn("pay_type", "支付方式", 0, 1, 1, 1, 0, 2, pt, ""));

		List<ListObject> ps = new ArrayList<>();
		ps.add(new ListObject("0", "未支付"));
		ps.add(new ListObject("1", "已支付"));
		m.put("pay_status", new TableColumn("pay_status", "付款状态", 0, 1, 0, 0, 1, 6, ps, ""));

		m.put("pay_time", new TableColumn("pay_time", "支付之间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("express_type", new TableColumn("express_type", "配送方式", 0, 1, 1, 0, 0, 7, null, ""));
		m.put("express_no", new TableColumn("express_no", "快递单号", 0, 0, 0, 0, 0, 7, null, ""));
		m.put("ship_time", new TableColumn("ship_time", "成交时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		// 0本站 1代客下单 2淘宝
		List<ListObject> os = new ArrayList<>();
		os.add(new ListObject("0", "本站"));
		os.add(new ListObject("1", "代客下单"));
		os.add(new ListObject("2", "淘宝"));
		m.put("order_source", new TableColumn("order_source", "订单来源", 0, 1, 0, 1, 0, 2, os, ""));

		m.put("note", new TableColumn("note", "备注", 0, 1, 1, 0, 0, 0, null, ""));
		//m.put("consigne", new TableColumn("consigne", "收货人", 0, 1, 1, 0, 0, 0, null, ""));
		
		m.put("con_name",new TableColumn("con_name","收货人姓名",1,1,1,0,0,0,null,""));
		m.put("con_province",new TableColumn("con_province","省/直辖市",0,1,1,0,0,0,null,""));
		m.put("con_city",new TableColumn("con_city","市/区",0,1,1,0,0,0,null,""));
		m.put("con_area",new TableColumn("con_area","县",0,1,1,0,0,0,null,""));
		m.put("con_post",new TableColumn("con_post","邮编",0,1,1,0,0,0,null,""));
		m.put("con_street",new TableColumn("con_street","街道地址",0,1,1,0,0,0,null,""));
		m.put("con_mobile",new TableColumn("con_mobile","手机/联系电话",0,1,1,0,0,0,null,""));
		m.put("con_name",new TableColumn("con_name","收货人姓名",0,1,1,0,0,0,null,""));

		
		m.put("con_note", new TableColumn("con_note", "客户备注", 0, 1, 1, 0, 0, 0, null, ""));

		List<ListObject> pt2 = new ArrayList<>();
		pt2.add(new ListObject("0", "未开票"));
		pt2.add(new ListObject("1", "已开票"));
		m.put("invoice_status", new TableColumn("invoice_status", "开票状态 0 未开票 1 已开票", 0, 1, 0, 0, 0, 2, pt2, ""));
		m.put("invoice_type", new TableColumn("invoice_type", "发票类型", 0, 1, 1, 0, 0, 7, null, ""));
		m.put("invoice_head", new TableColumn("invoice_head", "发票抬头", 0, 1, 1, 0, 0, 7, null, ""));
		m.put("invoice_details", new TableColumn("invoice_details", "发票内容", 0, 1, 1, 0, 0, 7, null, ""));

		// 订单状态 0 作废订单 10 新订单 20 已受理 30 内部确定 40 已发货 50 已送达 60 交易不成功 70 交易成功 80 已评价
		List<ListObject> s = new ArrayList<>();
		s.add(new ListObject("0", "作废订单"));
		s.add(new ListObject("10", "新订单"));
		s.add(new ListObject("20", "已受理"));
		s.add(new ListObject("30", "内部确定"));
		s.add(new ListObject("40", "已发货"));
		s.add(new ListObject("50", "已送达"));
		s.add(new ListObject("60", "交易不成功"));
		s.add(new ListObject("70", "交易成功"));
		s.add(new ListObject("80", " 已评价"));
		m.put("status", new TableColumn("status", "订单状态", 0, 1, 0, 1, 1, 1, s, ""));

		m.put("add_user", new TableColumn("add_user", "下单人", 0, 1, 0, 0, 0, 6, null, ""));
		m.put("add_time", new TableColumn("add_time", "下单时间", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 1, 1, 0, 0, 6, null, ""));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);

		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		OrderAppCreate ac = new OrderAppCreate();
		ac.execute();
	}
}
