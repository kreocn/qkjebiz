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
public class WebHCusInfoAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("活动客户管理");
		ai.setPackage_name("com.qkj.info.action");
		ai.setApp_en("h_cus_info");
		ai.setApp_code("web");
		ai.setDb_name("huzhu");
		ai.setTable_name("web_h_cus_info");
		ai.setJsp_path("qkjweb");
		ai.setName_space("qkjweb");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("0", "普通库"));
		ws.add(new ListObject("1", "藏酒库"));

		m.put("uuid", new TableColumn("uuid", "系统编号", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("linkid", new TableColumn("linkid", "投票ID", 0, 1, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("fullname", new TableColumn("fullname", "姓名", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("xinlang", new TableColumn("xinlang", "新浪微博昵称", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("mobile", new TableColumn("mobile", "联系手机", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("sex", new TableColumn("sex", "性别", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("ages", new TableColumn("ages", "年龄层", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("address", new TableColumn("address", "地址", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("postno", new TableColumn("postno", "邮编", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("works", new TableColumn("works", "职业", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("zodiac", new TableColumn("zodiac", "星座", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("security", new TableColumn("security", "证券", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_ip", new TableColumn("add_ip", "添加人IP", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("express_status", new TableColumn("express_status", "是否已快递", 0, 0, 1, 0, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("express_type", new TableColumn("express_type", "快递类型", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("express_no", new TableColumn("express_no", "快递单号", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("express_date", new TableColumn("express_date", "快递时间", 0, 0, 1, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "最后修改时间", 0, 0, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		WebHCusInfoAppCreate ac = new WebHCusInfoAppCreate();
		ac.execute();
	}
}
