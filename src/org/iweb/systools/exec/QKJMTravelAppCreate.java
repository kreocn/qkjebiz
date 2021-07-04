/**
 * 
 */
package org.iweb.systools.exec;

import java.util.LinkedHashMap;
import java.util.Map;

import org.iweb.systools.config.DBConfig;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-30 下午12:01:36
 */
public class QKJMTravelAppCreate extends AppCreate {

	@Override
	protected void SetApp() {
		AppInfo ai = new AppInfo();
		ai.setApp_name("工业旅游申请");
		ai.setPackage_name("com.qkj.manage");
		ai.setApp_en("travel");
		ai.setApp_code("qkj");
		ai.setDb_name("huzhu");
		ai.setTable_name("qkjm_r_travel");
		ai.setJsp_path("qkjmanage");
		ai.setName_space("qkjmanage");

		Map<String, TableColumn> m = new LinkedHashMap<>();

		m.put("uuid", new TableColumn("uuid", "主键自增", 1, 0, 0, 1, 1, 5, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_dept", new TableColumn("apply_dept", "申请部门", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_user", new TableColumn("apply_user", "申请人", 0, 1, 0, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("apply_item", new TableColumn("apply_item", "申请项目", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("travel_num", new TableColumn("travel_num", "客户人数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("accompany_num", new TableColumn("accompany_num", "陪同人数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("travel_date", new TableColumn("travel_date", "执行日期", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("member_num", new TableColumn("member_num", "客户家数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lunch_price", new TableColumn("lunch_price", "午餐标准/桌", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lunch_num", new TableColumn("lunch_num", "午餐次数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lunch_desk", new TableColumn("lunch_desk", "午餐桌数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("dinner_price", new TableColumn("dinner_price", "晚餐标准/桌", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("dinner_num", new TableColumn("dinner_num", "晚餐次数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("dinner_desk", new TableColumn("dinner_desk", "晚餐桌数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cigarette", new TableColumn("cigarette", "是否使用香烟0否 1是", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("cigarette_num", new TableColumn("cigarette_num", "准备香烟包数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("fruit", new TableColumn("fruit", "是否准备水果0否 1是", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel", new TableColumn("hotel", "是否安排住宿0否 1是", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel_start", new TableColumn("hotel_start", "开始住宿时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel_end", new TableColumn("hotel_end", "结束住宿时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel_total", new TableColumn("hotel_total", "总共住宿天数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel_twinroom", new TableColumn("hotel_twinroom", "标间间数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel_house", new TableColumn("hotel_house", "别墅规格(几人一套)", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("hotel_house_num", new TableColumn("hotel_house_num", "别墅套数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("car", new TableColumn("car", "车辆标准", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("travel_agency", new TableColumn("travel_agency", "是否联系旅行社0否 1是", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("trip", new TableColumn("trip", "具体行程安排", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("gift", new TableColumn("gift", "礼品品相", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("gift_num", new TableColumn("gift_num", "礼品份数", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("note", new TableColumn("note", "其他情况说明", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_status", new TableColumn("check_status", "业务审核状态", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_user", new TableColumn("check_user", "业务审核人", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_time", new TableColumn("check_time", "业务审核时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("check_note", new TableColumn("check_note", "业务审核意见", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_status", new TableColumn("acheck_status", "行政审核状态", 0, 1, 1, 1, 1, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_user", new TableColumn("acheck_user", "行政审核人", 0, 1, 1, 1, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_time", new TableColumn("acheck_time", "行政审核时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("acheck_note", new TableColumn("acheck_note", "行政审核意见", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_user", new TableColumn("add_user", "添加人", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("add_time", new TableColumn("add_time", "添加时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_user", new TableColumn("lm_user", "最后修改人", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));
		m.put("lm_time", new TableColumn("lm_time", "最后修改时间", 0, 1, 1, 0, 0, 0, null, "yyyy-MM-dd HH:mm:ss"));

		ai.setTcs(m);
		setApp(ai);
		log.info("设定APP成功!");
	}

	@Override
	protected int getDBType() {
		return DBConfig.DBTYPE_MYSQL;
	}

	public static void main(String[] args) {
		QKJMTravelAppCreate ac = new QKJMTravelAppCreate();
		ac.execute();
	}
}
