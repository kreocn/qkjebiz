package org.iweb.systools.exec;

import java.util.LinkedHashMap;
import java.util.Map;

import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJWarePowerAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("仓库管理权限");
		ai.setPackage_name("com.qkj.ware");
		ai.setApp_en("warepower");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_stockpower");
		ai.setJsp_path("ware/warepower");
		ai.setName_space("warepower");

	
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("ware_id",new TableColumn("ware_id","仓库id",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("username",new TableColumn("username","用户id",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));




		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJWarePowerAppCreate ac = new QKJWarePowerAppCreate();
		ac.execute();
	}
}
