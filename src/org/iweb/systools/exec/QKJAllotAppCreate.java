package org.iweb.systools.exec;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.ListObject;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

public class QKJAllotAppCreate extends AppCreate {
	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("调库");
		ai.setPackage_name("com.qkj.ware.allot");
		ai.setApp_en("allot");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_allot");
		ai.setJsp_path("ware/allot");
		ai.setName_space("allot");

	
		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("ordernum",new TableColumn("ordernum","调库单号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("date",new TableColumn("date","调库日期",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sourceid",new TableColumn("sourceid","调出仓库",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("goldid",new TableColumn("goldid","调入仓库",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("note",new TableColumn("note","其它说明",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_user",new TableColumn("add_user","添加人",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_timer",new TableColumn("add_timer","添加日期",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user",new TableColumn("lm_user","修改人",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_timer",new TableColumn("lm_timer","修改日期",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));



		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJAllotAppCreate ac = new QKJAllotAppCreate();
		ac.execute();
	}
}
