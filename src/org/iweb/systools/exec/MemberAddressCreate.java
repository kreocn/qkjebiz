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
public class MemberAddressCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("会员收货地址");
		ai.setPackage_name("org.iweb.sysvip");
		ai.setApp_en("member_address");
		ai.setDb_name("qkjcj");
		ai.setTable_name("s_vip_address");
		ai.setJsp_path("sysvip");
		ai.setName_space("sysvip");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 0, 5, null));
		m.put("member_id", new TableColumn("member_id", "会员号", 0, 1, 0, 0, 0, 4, null, ""));
		m.put("province", new TableColumn("province", "省/直辖市", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("city", new TableColumn("city", "市/区", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("area", new TableColumn("area", "县", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("post", new TableColumn("post", "邮编", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("street", new TableColumn("street", "街道地址", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("con_name", new TableColumn("con_name", "收货人姓名", 0, 1, 1, 1, 0, 0, null, ""));
		m.put("mobile", new TableColumn("mobile", "手机/联系电话", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("defaultaddress", new TableColumn("defaultaddress", "是否默认地址", 0, 1, 1, 1, 0, 3, ws, ""));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		MemberAddressCreate ac = new MemberAddressCreate();
		ac.execute();
	}
}
