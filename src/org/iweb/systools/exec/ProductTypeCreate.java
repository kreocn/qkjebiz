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
public class ProductTypeCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("产品类型");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("proType");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkj_t_protype");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 0, null, ""));
		m.put("name",new TableColumn("name","类型名称",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user",new TableColumn("lm_user","修改人",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time",new TableColumn("lm_time","修改时间",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));


		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		ProductTypeCreate ac = new ProductTypeCreate();
		ac.execute();
	}
}
