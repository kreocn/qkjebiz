package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJInDetailHiStoryAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("入库详情历史");
		ai.setPackage_name("com.qkj.ware");
		ai.setApp_en("inDetailH");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_h_indetail");
		ai.setJsp_path("ware/history");
		ai.setName_space("ware");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键ID",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lading_id",new TableColumn("lading_id","订单编号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_id",new TableColumn("product_id","订单商品号",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("num",new TableColumn("num","入库数量",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("price",new TableColumn("price","单价",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("total",new TableColumn("total","总计",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));


		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJInDetailHiStoryAppCreate ac = new QKJInDetailHiStoryAppCreate();
		ac.execute();
	}

}
