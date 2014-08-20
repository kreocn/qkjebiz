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
public class MemberCellarAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("客户藏酒信息");
		ai.setPackage_name("com.qkjsys.ebiz");
		ai.setApp_en("member_cellar");
		ai.setApp_code("qkjcj");
		ai.setDb_name("qkjcj");
		ai.setTable_name("qkj_r_member_cellar");
		ai.setJsp_path("sysebiz");
		ai.setName_space("sysebiz");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("member_id", new TableColumn("member_id", "客户ID", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("order_goods_id", new TableColumn("order_goods_id", "所属订单细项", 0, 1, 0, 0, 0, 0, null,
				"yyyy-MM-dd HH:mm:ss"));
		m.put("cellar_no", new TableColumn("cellar_no", "初始藏酒编号", 0, 1, 0, 0, 1, 1, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("num", new TableColumn("num", "初始库存", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("stock", new TableColumn("stock", "剩余库存", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("frozen", new TableColumn("frozen", "冻结库存", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cellar_position", new TableColumn("cellar_position", "藏酒位置号", 0, 1, 1, 1, 1, 0, null,
				"yyyy-MM-dd HH:mm:ss"));
		m.put("camera", new TableColumn("camera", "实时摄像头链接", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "最后修改时间", 0, 0, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);

		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		MemberCellarAppCreate ac = new MemberCellarAppCreate();
		ac.execute();
	}
}
