package org.iweb.rpt.logic.Imp.Simple;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.dao.SimpleReportDAO;
import org.iweb.rpt.domain.Column;
import org.iweb.rpt.domain.ListObject;
import org.iweb.rpt.logic.ReportUtils;
import org.iweb.rpt.logic.SimpleReport;
import org.iweb.sys.DateUtil;
import org.iweb.sys.ToolsUtil;

public class RPTFlmOrderHistory extends SimpleReport {
	private HashMap<String, Object> map;

	// 检查serachMap是否只能查出一个客户(通过custom_id和custom_name来判断)
	private boolean checkCustom_id(String custom_id, String name_cn) {
		return !(ToolsUtil.isEmpty(custom_id) && ToolsUtil.isEmpty(name_cn)) && custom_id.indexOf("%") == -1
				&& name_cn.indexOf("%") == -1 ? true : false;
	}

	@Override
	protected void searchMapOperation() {
		super.setSplitPage(!checkCustom_id(ToolsUtil.getEmpty(super.getSearchMap().get("custom_id")),
				ToolsUtil.getEmpty(super.getSearchMap().get("name_cn"))));
	}

	@Override
	public String getSerachName() {
		return "胶片出货历史";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("uuid", "流水号", 0));
		// list.add(new Column("order_id", "订单号", 1, SimpleReport.SearchType_Like, null));
		list.add(new Column("order_id", "订单号", SimpleReport.ColumnType_String, 1, 1, SimpleReport.SearchType_Like,
				SimpleReport.ObjType_Text, null, "", null, 2,
				"/erp/crm/flmOrder_load?viewFlag=view&$flmOrder.uuid:order_id$"));
		list.add(new Column("ware_id", "出货仓库", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getWares(), null, null, 0, null));
		list.add(new Column("out_date_start", "出货时间 从", 0, 1, SimpleReport.SearchType_More_Equel, DateUtil
				.getFirstDayOfMonth(new Date()), "yyyy-MM-dd"));
		list.add(new Column("out_date_end", "到", 0, 1, SimpleReport.SearchType_Less_Equel, null, "yyyy-MM-dd"));
		list.add(new Column("type_id", "胶片类型", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getTypes(), null, null, 0, null));
		list.add(new Column("custom_id", "客户编号", 0, SimpleReport.SearchType_Like, null));
		list.add(new Column("name_cn", "客户名称", 1, SimpleReport.SearchType_Like, null));
		list.add(new Column("out_date", "出货时间", 1, 0, 0, null, "yyyy-MM-dd"));
		list.add(new Column("lot_info", "乳剂号", 1, SimpleReport.SearchType_Like, null));
		list.add(new Column("ware_title", "仓库名称", 1));
		list.add(new Column("type_title", "型号&规格", 1));
		list.add(new Column("quantity", "数量", 1));
		list.add(new Column("price", "金额", 1));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select * From";
	}

	@Override
	public String getMiddleSqlText() {
		return "(Select o.order_id, o.ware_id, o.type_id, o.lot_info, o.quantity,Round(o.quantity * u.avg_unit, 2) price, "
				+ "o.out_date, o.out_date_start,o.out_date_end, a.name_cn, o.status, t.model, t.spec ,t.title type_title, w.title ware_title, "
				+ "a.custom_id From (Select x.*, x.out_date out_date_start, x.out_date out_date_end From wms_h_flm_outx x) o, "
				+ "(Select order_id, type_id, Decode(avg_q, 0, 0, avg_p / avg_q) avg_unit From (Select i.order_id, i.type_id, "
				+ "Sum(i.total_price) avg_p, Sum(i.quantity) avg_q From crm_r_flmorder_item i Group By i.order_id, i.type_id)) u,"
				+ " (Select f.uuid, f.status, f.custom_id, c.name_cn, "
				+ "decode(c.area, 1, '华北', 2, '华东', 3, '华南', 4, '西南', 5, '西北', '其他') area,"
				+ "nvl(c.province, '其他') province, f.is_pay,f.status flmorder_status From crm_r_flmorder f, "
				+ "crm_t_customer c Where f.custom_id = c.uuid And f.status >= 0) a, erp_c_flm_type t, wms_c_ware w "
				+ "Where o.order_id = u.order_id And o.type_id = u.type_id And o.order_id = a.uuid And o.type_id = t.uuid "
				+ "And o.ware_id = w.uuid) Where 1 = 1";
	}

	@Override
	public String getEndSqlText() {
		return "ORDER BY out_date, order_id , type_title";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_FLMORDER_HISTORY";
	}

	@Override
	public String getInitShortClassName() {
		return "FlmOrderHistory";
	}

	@Override
	public List<Map<String, Object>> getResultList() {
		if (super.isSplitPage()) {
			return super.getRlist();
		} else {
			List<Map<String, Object>> l = super.getRlist();
			// quantity
			ReportUtils.sum(l, new String[] { "QUANTITY", "PRICE" }, false, null, true, "TYPE_TITLE", null);

			super.setRecCount(l.size());
			return l;
		}

	}

	@Override
	public String getReportRemark() {
		return "";
	}

	private List<ListObject> getWares() {
		dao = new SimpleReportDAO();
		map = new HashMap<String, Object>();
		map.put("sqltext", "SELECT uuid key, title value FROM wms_c_ware");
		return dao.getSimpleList(map);
	}

	private List<ListObject> getTypes() {
		dao = new SimpleReportDAO();
		map = new HashMap<String, Object>();
		map.put("sqltext", "SELECT uuid key, title value FROM erp_c_flm_type");
		return dao.getSimpleList(map);
	}
}
