package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJCheckAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("盘点");
		ai.setPackage_name("com.qkj.ware");
		ai.setApp_en("check");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_check");
		ai.setJsp_path("ware/check");
		ai.setName_space("check");

	
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_id",new TableColumn("product_id","商品",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("store_id",new TableColumn("store_id","仓库",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("quantity",new TableColumn("quantity","库存",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("num",new TableColumn("num","实际数量",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));




		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJCheckAppCreate ac = new QKJCheckAppCreate();
		ac.execute();
	}
}
