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
 * 
 * @author sun
 *
 */
public class QKJStockTypeActiveAppCreate extends AppCreate{
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("仓库类型");
		ai.setPackage_name("com.qkj.stockType");
		ai.setApp_en("stocktype");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_stocktype");
		ai.setJsp_path("stockType");
		ai.setName_space("qkjst");

		
		Map<String, TableColumn> m = new LinkedHashMap<>();
		
		m.put("tid",new TableColumn("tid","主键ID",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("tname",new TableColumn("tname","订单编号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("ttype",new TableColumn("ttype","订单商品号",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));

		
		ai.setTcs(m);
 		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJStockTypeActiveAppCreate ac = new QKJStockTypeActiveAppCreate();
		ac.execute();
	}
}
