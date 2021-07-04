package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJAllotDetailAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("调库详表");
		ai.setPackage_name("com.qkj.ware.allotDetail");
		ai.setApp_en("allotDetail");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_allotDetail");
		ai.setJsp_path("ware/allotDetail");
		ai.setName_space("allot");

	
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lading_id",new TableColumn("lading_id","类型 0出差 1请假 2加班 3换休",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("stock_id",new TableColumn("stock_id","申请部门",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("num",new TableColumn("num","申请人",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));



		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJAllotDetailAppCreate ac = new QKJAllotDetailAppCreate();
		ac.execute();
	}
}
