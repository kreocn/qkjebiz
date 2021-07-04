package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJOutStockAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("出库");
		ai.setPackage_name("com.qkj.outStock");
		ai.setApp_en("outStock");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_outstock");
		ai.setJsp_path("outStock");
		ai.setName_space("outStock");

		//ableColumn(String name, String title, int key, int insert, int update, int show, int search, int stype,
		//List<ListObject> slist, String datePatte
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("date",new TableColumn("date","出库时间",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("store_id",new TableColumn("store_id","出库仓库",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("operator_id",new TableColumn("operator_id","经办人",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("take_id",new TableColumn("take_id","保管员",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("note",new TableColumn("note","其它说明",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("total_price",new TableColumn("total_price","总价",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_user",new TableColumn("add_user","添加人",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_timer",new TableColumn("add_timer","添加时间",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user",new TableColumn("lm_user","修改人",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_timer",new TableColumn("lm_timer","修改时间",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("reason",new TableColumn("reason","出库方式",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("send",new TableColumn("send","是否归还",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("manager_check",new TableColumn("manager_check","渠道/运营经理确认",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("manager_check_user",new TableColumn("manager_check_user","确认人姓名",0,1,1,0,1,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("manager_check_time",new TableColumn("manager_check_time","确认时间",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("coo_check",new TableColumn("coo_check","运营总监确认",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("coo_check_user",new TableColumn("coo_check_user","确认人姓名",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("coo_check_time",new TableColumn("coo_check_time","确认时间",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));

		
		
		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJOutStockAppCreate ac = new QKJOutStockAppCreate();
		ac.execute();
	}
}
