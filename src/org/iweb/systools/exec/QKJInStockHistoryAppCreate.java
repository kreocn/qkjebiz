package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJInStockHistoryAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("入库历史");
		ai.setPackage_name("com.qkj.ware");
		ai.setApp_en("inStockH");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_h_instock");
		ai.setJsp_path("ware/history");
		ai.setName_space("ware");

		List<ListObject> g = new ArrayList<>();
		g.add(new ListObject("0", "正常入库"));
		g.add(new ListObject("1", "报溢入库"));

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键ID",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("date",new TableColumn("date","订单编号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("store_id",new TableColumn("store_id","订单商品号",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("operator_id",new TableColumn("operator_id","经办人",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("take_id",new TableColumn("take_id","保管员",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("note",new TableColumn("note","入库原因",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("total_price",new TableColumn("total_price","总价",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_user",new TableColumn("add_user","添加人IP",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_timer",new TableColumn("add_timer","添加时间",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user",new TableColumn("lm_user","修改人",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_timer",new TableColumn("lm_timer","修改时间",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("reason",new TableColumn("reason","状态",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));

		m.put("confirm",new TableColumn("confirm","审核人",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("conname",new TableColumn("conname","审核时间",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("contime",new TableColumn("contime","审核意见",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));

		
		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJInStockHistoryAppCreate ac = new QKJInStockHistoryAppCreate();
		ac.execute();
	}
}
