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
public class QKJAAssetsAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("资产管理");
		ai.setPackage_name("com.qkj.adm");
		ai.setApp_en("assets");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkja_r_assets");
		ai.setJsp_path("adm");
		ai.setName_space("adm");

		List<ListObject> g1 = new ArrayList<>();
		g1.add(new ListObject("0", "资产类别一"));
		g1.add(new ListObject("1", "资产类别二"));
		g1.add(new ListObject("2", "资产类别三"));

		List<ListObject> g2 = new ArrayList<>();
		g2.add(new ListObject("0", "北京互助天佑德青稞酒销售有限公司"));
		g2.add(new ListObject("1", "华实集团"));
		g2.add(new ListObject("2", "华奥地产"));
		g2.add(new ListObject("3", "青海互助青稞酒股份有限公司"));
		g2.add(new ListObject("4", "青海互助青稞酒销售有限公司"));
		g2.add(new ListObject("5", "北京互助天佑德青稞酒销售有限公司第二分公司"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "系统编号", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("typea", new TableColumn("typea", "资产种类", 0, 1, 0, 1, 1, 1, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("typeb", new TableColumn("typeb", "资产类别", 0, 1, 0, 1, 1, 1, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("typec", new TableColumn("typec", "子类别", 0, 1, 0, 1, 1, 1, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("title", new TableColumn("title", "资产名称", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("num", new TableColumn("num", "数量", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("company", new TableColumn("company", "所属公司", 0, 1, 1, 0, 1, 1, g2, "yyyy-MM-dd HH:mm:ss"));
		m.put("p_time", new TableColumn("p_time", "采购时间", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("p_scrap", new TableColumn("p_scrap", "报废时限(月)", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("price_scope", new TableColumn("price_scope", "价格范围", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 0, 1, 0, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJAAssetsAppCreate ac = new QKJAAssetsAppCreate();
		ac.execute();
	}
}
