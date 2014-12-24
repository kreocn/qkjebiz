/**
 * 
 */
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
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-30 下午12:01:36
 */
public class SalPromotionAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("促销活动");
		ai.setPackage_name("com.qkj.salpro");
		ai.setApp_en("sal_promot");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_salpromotion");
		ai.setJsp_path("salpro");
		ai.setName_space("salpro");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sal_title",new TableColumn("sal_title","主题",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("startime",new TableColumn("startime","开始日期",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("endtime",new TableColumn("endtime","结束日期",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sal_scop",new TableColumn("sal_scop","范围",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sal_plan",new TableColumn("sal_plan","促销方案",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_user",new TableColumn("add_user","填加人",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("add_time",new TableColumn("add_time","填加时间",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sd_status",new TableColumn("sd_status","销售审核状态",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sd_user",new TableColumn("sd_user","审核人",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("sd_time",new TableColumn("sd_time","审核时间",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("smd_status",new TableColumn("smd_status","销管审核状态",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("smd_user",new TableColumn("smd_user","审核人",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("smd_time",new TableColumn("smd_time","审核时间",0,1,1,0,0,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user",new TableColumn("lm_user","修改人",0,1,1,0,1,6,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time",new TableColumn("lm_time","修改时间",0,1,1,0,0,6,null,"yyyy-MM-dd HH:mm:ss"));
		


		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		SalPromotionAppCreate ac = new SalPromotionAppCreate();
		ac.execute();
	}
}
