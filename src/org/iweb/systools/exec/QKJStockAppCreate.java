package org.iweb.systools.exec;

import java.util.LinkedHashMap;
import java.util.Map;

import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJStockAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("库存物品");
		ai.setPackage_name("com.qkj.stock");
		ai.setApp_en("stock");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_r_stock");
		ai.setJsp_path("stock");
		ai.setName_space("stock");

		

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键ID",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_id",new TableColumn("product_id","商品编号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("store_id",new TableColumn("store_id","仓库编号",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("quantity",new TableColumn("quantity","库存数量",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lading_id",new TableColumn("lading_id","入库单号",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("date",new TableColumn("date","入库日期",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJStockAppCreate ac = new QKJStockAppCreate();
		ac.execute();
	}

}
