package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJOutDetailHistoryAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("出库详表历史");
		ai.setPackage_name("com.qkj.ware");
		ai.setApp_en("outDetailH");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_h_outdetail");
		ai.setJsp_path("ware/history");
		ai.setName_space("ware");

		//ableColumn(String name, String title, int key, int insert, int update, int show, int search, int stype,
		//List<ListObject> slist, String datePatte
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lading_id",new TableColumn("lading_id","出库单号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_id",new TableColumn("product_id","商品编号",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("num",new TableColumn("num","出库数量",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("price",new TableColumn("price","单价",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("totel",new TableColumn("totel","总计",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));

		
		
		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJOutDetailHistoryAppCreate ac = new QKJOutDetailHistoryAppCreate();
		ac.execute();
	}
}
