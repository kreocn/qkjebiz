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
public class QKJAAssetItemAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("资产物品");
		ai.setPackage_name("com.qkj.adm");
		ai.setApp_en("asset_item");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkja_r_asset_item");
		ai.setJsp_path("adm");
		ai.setName_space("adm");

		List<ListObject> g1 = new ArrayList<>();
		g1.add(new ListObject("0", "未领用"));
		g1.add(new ListObject("1", "已领用"));

		List<ListObject> g2 = new ArrayList<>();
		g2.add(new ListObject("0", "北京互助天佑德青稞酒销售有限公司"));
		g2.add(new ListObject("1", "华实集团"));
		g2.add(new ListObject("2", "华奥地产"));
		g2.add(new ListObject("3", "青海互助青稞酒股份有限公司"));
		g2.add(new ListObject("4", "青海互助青稞酒销售有限公司"));
		g2.add(new ListObject("5", "北京互助天佑德青稞酒销售有限公司第二分公司"));

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "编号", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("asset_id", new TableColumn("asset_id", "所属资产", 0, 1, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("model", new TableColumn("model", "型号", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("spec", new TableColumn("spec", "规格", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("position", new TableColumn("position", "所在位置", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("is_use", new TableColumn("is_use", "是否已领用", 0, 1, 1, 1, 0, 1, g1, "yyyy-MM-dd HH:mm:ss"));
		m.put("own_user", new TableColumn("own_user", "所属人", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("use_time", new TableColumn("use_time", "领用时间", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("op_user", new TableColumn("op_user", "执行人", 0, 1, 1, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("op_time", new TableColumn("op_time", "执行时间", 0, 1, 1, 1, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 1, 1, 0, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
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
		QKJAAssetItemAppCreate ac = new QKJAAssetItemAppCreate();
		ac.execute();
	}
}
