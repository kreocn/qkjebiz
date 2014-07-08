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
public class QKJMCustomerAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("客户管理");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("customer");
		ai.setApp_code("qkj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkjm_r_customer");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		// 所属阶段
		List<ListObject> g1 = new ArrayList<>();
		g1.add(new ListObject("0", "初步了解"));
		g1.add(new ListObject("1", "深度了解"));
		g1.add(new ListObject("2", "开始报价"));
		g1.add(new ListObject("3", "客户未成交"));
		g1.add(new ListObject("4", "客户成交"));

		// 未成交原因
		List<ListObject> g2 = new ArrayList<>();
		g2.add(new ListObject("0", "首单量太多"));
		g2.add(new ListObject("1", "区域内已有经销商"));
		g2.add(new ListObject("2", "没有合适的产品"));
		g2.add(new ListObject("3", "对公司的市场支持和企业实力有疑问"));
		g2.add(new ListObject("4", "其他原因"));

		// 客户来源
		// 1、；2、；3、互联网；4、其他、5、
		List<ListObject> g3 = new ArrayList<>();
		g3.add(new ListObject("0", "杂志、媒体、广告"));
		g3.add(new ListObject("1", "朋友介绍"));
		g3.add(new ListObject("2", "互联网"));
		g3.add(new ListObject("3", "QQ等聊天工具"));
		g3.add(new ListObject("4", "糖酒会"));
		g3.add(new ListObject("5", "其他"));

		// 市场类型
		List<ListObject> g4 = new ArrayList<>();
		g4.add(new ListObject("0", "省会"));
		g4.add(new ListObject("1", "地级"));
		g4.add(new ListObject("2", "县级"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "客户编号", 1, 0, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("dept_code", new TableColumn("dept_code", "所属部门", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("stage", new TableColumn("stage", "所属阶段", 0, 1, 1, 1, 1, 0, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("failed_reason", new TableColumn("failed_reason", "未成交原因", 0, 1, 1, 1, 1, 2, g2, "yyyy-MM-dd HH:mm:ss"));
		m.put("source", new TableColumn("source", "客户来源", 0, 1, 1, 1, 0, 0, g3, "yyyy-MM-dd HH:mm:ss"));
		m.put("cus_name", new TableColumn("cus_name", "客户名称", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("phone", new TableColumn("phone", "联系电话", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("email", new TableColumn("email", "电子邮箱", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("sale_province",
				new TableColumn("sale_province", "经销区域-省", 0, 1, 1, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("sale_city", new TableColumn("sale_city", "经销区域-市/区", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("sale_area", new TableColumn("sale_area", "经销区域-县", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("m_province", new TableColumn("m_province", "邮寄地址-省/直辖市", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("m_city", new TableColumn("m_city", "邮寄地址-市/区", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("m_area", new TableColumn("m_area", "邮寄地址-县", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("m_post", new TableColumn("m_post", "邮寄地址-邮编", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("m_street", new TableColumn("m_street", "邮寄地址-街道地址", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("trade", new TableColumn("trade", "所属行业", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("mind", new TableColumn("mind", "经营思路", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("financial", new TableColumn("financial", "资金实力", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("distribution", new TableColumn("distribution", "销售网络", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("remark", new TableColumn("remark", "备注", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("i_product", new TableColumn("i_product", "感兴趣的产品", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("first_pay", new TableColumn("first_pay", "客户能承受的首单量", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("n_product", new TableColumn("n_product", "客户需要的产品", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("doubt", new TableColumn("doubt", "客户的疑虑", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("qa", new TableColumn("qa", "客户的问题和解答", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("manager", new TableColumn("manager", "管理者", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("con_name", new TableColumn("con_name", "联系人", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("qq", new TableColumn("qq", "联系QQ", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("fax", new TableColumn("fax", "传真", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("mobile", new TableColumn("mobile", "手机", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("contract_end", new TableColumn("contract_end", "合同截止期(已成交才有)", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd"));
		m.put("rating", new TableColumn("rating", "深度了解星级", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("cus_back", new TableColumn("cus_back", "客户背景概述", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("cus_now", new TableColumn("cus_now", "客户现状概述", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("ware_square", new TableColumn("ware_square", "仓库面积", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("ware_type", new TableColumn("ware_type", "仓储归属 1租赁 2自有", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("vehicle_num", new TableColumn("vehicle_num", "配送车辆", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("in_wholesaler", new TableColumn("in_wholesaler", "自有批发商", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("in_shop", new TableColumn("in_shop", "自有直供店", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("out_wholesaler", new TableColumn("out_wholesaler", "二级批发商", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("out_shop", new TableColumn("out_shop", "下级直供店", 0, 1, 1, 0, 0, 0, null, ""));
		m.put("sale_type", new TableColumn("sale_type", "市场类型 0:省会 1市级 2县级", 0, 1, 1, 0, 0, 2, g4, ""));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMCustomerAppCreate ac = new QKJMCustomerAppCreate();
		ac.execute();
	}
}
