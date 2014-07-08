package com.qkj.info.action;

import java.util.HashMap;
import java.util.Map;

import org.iweb.common.dao.CommonDAO;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

public class OJsonIFAction extends ActionSupport {
	private static final long serialVersionUID = 7033167370828951434L;
	// private static Log log = LogFactory.getLog(HCusInfoAction.class);
	private Map<String, Object> p = new HashMap<String, Object>();
	private CommonDAO dao = new CommonDAO();
	private String appKey;
	private Object json_result;

	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public Map<String, Object> getP() {
		return p;
	}

	public void setP(Map<String, Object> p) {
		this.p = p;
	}

	public Object getJson_result() {
		return json_result;
	}

	public void setJson_result(Object json_result) {
		this.json_result = json_result;
	}

	public String mc() throws Exception {
		String mobile = getPara("mobile");
		if ("ndbec5uhbvnysjfc42aLpcfz".equals(appKey) && !ToolsUtil.isEmpty(mobile)) {
			String sql = "SELECT b.`MEMBER_NAME` AS `member_name`,b.`MOBILE` AS `mobile`,m.`cellar_position`,m.`num`,m.`stock`,"
					+ "m.`frozen`,m.`camera`,w.`ware_name`,DATE_FORMAT(m.`storage_date`,'%Y-%m-%d') AS `storage_date`,m.`uuid` AS `cellar_id` "
					+ "FROM qkj_r_member_cellar m,s_vip_member b,qkj_t_warehouse w "
					+ "WHERE m.`member_id` = b.`UUID` AND m.`ware_id` = w.`uuid` AND m.`status`=0 AND b.`MOBILE` = '" + mobile + "'";
			this.setJson_result(ToolsUtil.Object2JSON(dao.commonSelectMapList(sql)));
		} else {
			this.setJson_result("");
		}
		return SUCCESS;
	}

	public String mco() throws Exception {
		String cellar_id = getPara("cellar_id");
		if ("f3m9wcibz66byom0L5v6hnii".equals(appKey) && !ToolsUtil.isEmpty(cellar_id)) {
			String sql = "SELECT `uuid`,`order_num`,`con_name`,`con_province`,`con_city`,`con_area`,`con_post`,`con_street`,`con_mobile`,`con_note`,"
					+ "`express_no`,`order_video`,`order_video_pass`,"
					+ "CASE WHEN `status` = 10 THEN '新订单' WHEN `status` = 20 THEN '已灌装' WHEN `status` >= 30 THEN '已发货' END `status` "
					+ "FROM `qkj_r_cellar_order` WHERE `status` >= 1 AND `member_cellar_id` = " + cellar_id + "";
			this.setJson_result(ToolsUtil.Object2JSON(dao.commonSelectMapList(sql)));
		} else {
			this.setJson_result("");
		}
		return SUCCESS;
	}

	private String getPara(String para_name) {
		Object m = p.get(para_name);
		if (m instanceof String[]) return ((String[]) m)[0];
		else if (m == null) return "";
		else return m.toString();
	}

}
