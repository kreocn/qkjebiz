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
public class MemberStockAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("结案提货单商品");
		ai.setPackage_name("com.qkj.manage.action");
		ai.setApp_en("closeOrderPro");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkjm_r_closeorder_product");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid",new TableColumn("uuid","主键自增",1,0,0,1,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("order_id",new TableColumn("order_id","提货单编号",0,1,1,0,1,5,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_id",new TableColumn("product_id","产品id",0,1,1,0,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_num",new TableColumn("product_num","数量",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("product_price",new TableColumn("product_price","单价",0,1,1,1,1,0,null,"yyyy-MM-dd HH:mm:ss"));
		m.put("total_price",new TableColumn("total_price","合计",0,1,1,1,0,0,null,"yyyy-MM-dd HH:mm:ss"));





		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		MemberStockAppCreate ac = new MemberStockAppCreate();
		ac.execute();
	}
}
