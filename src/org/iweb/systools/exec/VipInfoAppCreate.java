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
public class VipInfoAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("留言交流");
		ai.setPackage_name("org.iweb.sysvip");
		ai.setApp_en("info");
		ai.setApp_code("vip");
		ai.setDb_name("qkjcj");
		ai.setTable_name("s_vip_info");
		ai.setJsp_path("sysvip");
		ai.setName_space("sysvip");

		Map<String, TableColumn> m = new LinkedHashMap<>();
		List<ListObject> ws = new ArrayList<>();
		ws.add(new ListObject("TIPS", "普通"));
		ws.add(new ListObject("SALES", "买卖"));
		ws.add(new ListObject("QA", "询问"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("type", new TableColumn("type", "信息种类", 0, 1, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("itype", new TableColumn("itype", "信息类型", 0, 1, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("reuuid", new TableColumn("reuuid", "主UUID", 0, 1, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("tomember", new TableColumn("tomember", "私信的接收人", 0, 1, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("imode", new TableColumn("imode", "交流分类", 0, 1, 1, 1, 1, 1, ws, "yyyy-MM-dd HH:mm:ss"));
		m.put("title", new TableColumn("title", "标题", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("content", new TableColumn("content", "信息内容", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("checked", new TableColumn("checked", "审核状态", 0, 1, 1, 0, 1, 7, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("del", new TableColumn("del", "删除标记", 0, 0, 1, 0, 1, 7, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 0, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_ip", new TableColumn("add_ip", "添加IP", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_member", new TableColumn("add_member", "添加人", 0, 1, 0, 0, 1, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_ip", new TableColumn("lm_ip", "修改IP", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_member", new TableColumn("lm_member", "修改人", 0, 0, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		VipInfoAppCreate ac = new VipInfoAppCreate();
		ac.execute();
	}
}
