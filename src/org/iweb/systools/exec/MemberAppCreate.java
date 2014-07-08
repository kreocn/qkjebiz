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
public class MemberAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("会员");
		ai.setPackage_name("org.iweb.sysvip");
		ai.setApp_en("member");
		ai.setDb_name("qkjcj");
		ai.setTable_name("s_vip_member");
		ai.setJsp_path("sysvip");
		ai.setName_space("sysvip");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "会员号", 1, 1, 0, 1, 1, 5, null, ""));
		m.put("title", new TableColumn("title", "会员帐号/登录别名", 0, 1, 0, 1, 1, 0, null, ""));
		m.put("mobile", new TableColumn("mobile", "会员手机", 0, 1, 0, 1, 1, 0, null, ""));

		List<ListObject> mc = new ArrayList<>();
		mc.add(new ListObject("0", "未验证"));
		mc.add(new ListObject("1", "已验证"));
		m.put("is_mobile_check", new TableColumn("is_mobile_check", "手机验证", 0, 1, 0, 1, 1, 2, mc, ""));
		m.put("email", new TableColumn("email", "会员EMAIL", 0, 1, 0, 1, 1, 0, null, ""));

		List<ListObject> ec = new ArrayList<>();
		ec.add(new ListObject("0", "未验证"));
		ec.add(new ListObject("1", "已验证"));
		m.put("is_email_check", new TableColumn("is_email_check", "EMAIL验证 0:未验证 1:已验证", 0, 1, 0, 1, 1, 2, ec, ""));
		m.put("member_name", new TableColumn("member_name", "会员姓名", 0, 1, 0, 1, 1, 0, null, ""));

		List<ListObject> ut = new ArrayList<>();
		ut.add(new ListObject("0", "普通会员"));
		ut.add(new ListObject("1", "VIP0"));
		m.put("user_type", new TableColumn("user_type", "会员级别", 0, 1, 0, 1, 0, 1, ut, ""));
		m.put("reg_time", new TableColumn("reg_time", "注册时间", 0, 1, 0, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		List<ListObject> rt = new ArrayList<>();
		rt.add(new ListObject("0", "自行注册"));
		rt.add(new ListObject("1", "管理员添加"));
		rt.add(new ListObject("2", "批量导入"));
		m.put("reg_type", new TableColumn("reg_type", "注册方式", 0, 1, 0, 0, 0, 2, rt, ""));
		m.put("last_login_time", new TableColumn("last_login_time", "最后登录时间", 0, 1, 1, 1, 0, 6, null,
				"yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);

		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		MemberAppCreate ac = new MemberAppCreate();
		ac.execute();
	}
}
