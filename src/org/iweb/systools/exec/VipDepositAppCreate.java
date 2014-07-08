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
public class VipDepositAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("会员预付款");
		ai.setPackage_name("org.iweb.sysvip");
		ai.setApp_en("deposit");
		ai.setApp_code("vip");
		ai.setDb_name("qkjcj");
		ai.setTable_name("s_vip_deposit");
		ai.setJsp_path("sysvip");
		ai.setName_space("sysvip");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		// 0现金 1POS 2支票 3转账 4其他
		List<ListObject> l1 = new ArrayList<>();
		l1.add(new ListObject("0", "现金"));
		l1.add(new ListObject("1", "POS"));
		l1.add(new ListObject("2", "支票"));
		l1.add(new ListObject("3", "转账"));
		l1.add(new ListObject("4", "其他"));

		// 0未确认 1已确认
		List<ListObject> l2 = new ArrayList<>();
		l2.add(new ListObject("0", "未确认"));
		l2.add(new ListObject("1", "已确认"));

		m.put("uuid", new TableColumn("uuid", "主键ID", 1, 0, 0, 0, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("pay_date", new TableColumn("pay_date", "付款日期", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("type", new TableColumn("type", "付款方式", 0, 1, 1, 1, 1, 1, l1, "yyyy-MM-dd HH:mm:ss"));
		m.put("amount", new TableColumn("amount", "付款金额", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("member_id", new TableColumn("member_id", "客户ID", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "提交人", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "提交时间", 0, 1, 0, 1, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("fd_check", new TableColumn("fd_check", "财务确认", 0, 0, 1, 1, 1, 7, l2, "yyyy-MM-dd HH:mm:ss"));
		m.put("fd_check_user", new TableColumn("fd_check_user", "财务确认人", 0, 0, 1, 0, 0, 7, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("fd_check_time",
				new TableColumn("fd_check_time", "财务确认时间", 0, 0, 1, 0, 0, 7, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "修改人", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "修改时间", 0, 1, 1, 0, 0, 6, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		VipDepositAppCreate ac = new VipDepositAppCreate();
		ac.execute();
	}
}
