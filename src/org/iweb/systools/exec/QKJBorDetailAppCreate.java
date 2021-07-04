package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJBorDetailAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("还库");
		ai.setPackage_name("com.qkj.ware");
		ai.setApp_en("bordetail");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_bordetail");
		ai.setJsp_path("ware/bordetail");
		ai.setName_space("bordetail");

	
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_id",new TableColumn("product_id","商品",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("bstore_id",new TableColumn("bstore_id","还库",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sstor_id",new TableColumn("sstor_id","借库",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("bnum",new TableColumn("bnum","还数量",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("bdate",new TableColumn("bdate","时间",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("back_id",new TableColumn("back_id","还货编号",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("land_id",new TableColumn("land_id","借货编号",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));



		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJBorDetailAppCreate ac = new QKJBorDetailAppCreate();
		ac.execute();
	}
}
