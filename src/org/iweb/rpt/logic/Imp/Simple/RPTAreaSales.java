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

public class RPTAreaSales extends SimpleReport {
	private HashMap<String, Object> map;

	private String[] types;

	public RPTAreaSales() {
		super.setSplitPage(false);
	}

	@Override
	public String getSerachName() {
		return "区域销售报表";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("area", "区域", 1));
		list.add(new Column("province", "省份", 1));
		list.add(new Column("title", "", 1));

		list.add(new Column("wtotal", "合计", 1));

		list.add(new Column("custom_id", "客户编号", 0, SimpleReport.SearchType_Like, ""));
		list.add(new Column("custom_name", "客户名称", 0, SimpleReport.SearchType_Like, ""));

		list.add(new Column("out_date_start", "发货时间 从", 0, 1, SimpleReport.SearchType_More_Equel, DateUtil
				.getFirstDayOfMonth(new Date()), "yyyy-MM-dd"));
		list.add(new Column("out_date_end", "到", 0, 1, SimpleReport.SearchType_Less_Equel, null, "yyyy-MM-dd"));

		list.add(new Column("flmorder_status", "订单状态", SimpleReport.ColumnType_Int, 0, 1,
				SimpleReport.SearchType_Equel, SimpleReport.ObjType_Select, getSearchStatus(), null, null, 0, null));

		list.add(new Column("is_pay", "是否已付款", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getSearchIsPay(), null, null, 0, null));

		list.add(new Column("ware_id", "出货仓库", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getWares(), null, null, 0, null));

		list.add(new Column("sales", "销售人员", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getSales(), null, null, 0, null));

		List<ListObject> l = getTypes();

		types = new String[l.size()];

		for (int i = 0, n = l.size(); i < n; i++) {
			ListObject tmp = l.get(i);
			list.add(new Column(tmp.getValue(), tmp.getValue().replaceAll("_", "<br />"), 1));
			types[i] = tmp.getValue();
		}
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select area, province, title, Sum(quantity) quantity, Sum(price) price";
	}

	@Override
	public String getMiddleSqlText() {
		return "From (Select a.area, a.province, t.title, o.quantity, o.out_date,o.quantity * u.avg_unit price, "
				+ "o.out_date out_date_start,o.out_date out_date_end, a.is_pay, a.flmorder_status From (Select x.*,x.out_date out_date_start,x.out_date out_date_end From wms_h_flm_outx x) o,"
				+ "(Select order_id, type_id,Decode(avg_q,0,0,avg_p/avg_q) avg_unit From (Select i.order_id, i.type_id, "
				+ "Sum(i.total_price) avg_p , Sum(i.quantity) avg_q From crm_r_flmorder_item i Group By i.order_id, "
				+ "i.type_id)) u,(Select f.uuid, f.status,f.custom_id,c.name_cn custom_name,decode(c.area, 1, '华北', 2, '华东', 3, '华南', "
				+ "4, '西南', 5, '西北', '其他') area,nvl(c.province, '其他') province, f.is_pay,f.status flmorder_status,f.sales "
				+ "From crm_r_flmorder f, crm_t_customer c Where f.custom_id = c.uuid And f.status >= 0) a, erp_c_flm_type t "
				+ "Where o.order_id = u.order_id And o.type_id = u.type_id And o.order_id = a.uuid And o.type_id = t.uuid";
	}

	@Override
	public String getEndSqlText() {
		return ") Group By area, province, title";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_AREA_SALES";
	}

	@Override
	public String getInitShortClassName() {
		return "AreaSales";
	}

	@Override
	public String getReportRemark() {
		return "按发货时间进行统计,与订单状态无关！";
	}

	@Override
	public List<Map<String, Object>> getResultList() {
		List<Map<String, Object>> l = ToolsUtil.conventTable(super.getRlist(), new String[] { "AREA", "PROVINCE" },
				new String[] { "QUANTITY", "PRICE" }, new String[] { "数量", "金额" }, "TITLE", "TITLE");

		ReportUtils.sum(l, types, true, "WTOTAL", true, "PROVINCE", "TITLE");

		super.setRecCount(l.size());
		return l;
	}

	private List<ListObject> getTypes() {
		dao = new SimpleReportDAO();
		map = new HashMap<String, Object>();
		map.put("sqltext", "SELECT uuid key, title value FROM erp_c_flm_type");
		return dao.getSimpleList(map);
	}

	private List<ListObject> getSearchStatus() {
		List<ListObject> l = new ArrayList<ListObject>();
		l.add(new ListObject("20", "待发货"));
		l.add(new ListObject("30", "已发货未开票"));
		l.add(new ListObject("40", "已开票"));
		return l;
	}

	private List<ListObject> getSearchIsPay() {
		List<ListObject> l = new ArrayList<ListObject>();
		l.add(new ListObject("0", "已付款"));
		l.add(new ListObject("1", "未付款"));
		l.add(new ListObject("2", "未结清"));
		return l;
	}

	private List<ListObject> getWares() {
		dao = new SimpleReportDAO();
		map = new HashMap<String, Object>();
		map.put("sqltext", "SELECT uuid key, title value FROM wms_c_ware");
		return dao.getSimpleList(map);
	}

	private List<ListObject> getSales() {
		dao = new SimpleReportDAO();
		map = new HashMap<String, Object>();
		map.put("sqltext", "SELECT uuid key, user_name value FROM erp_c_usr_sales");
		return dao.getSimpleList(map);
	}
}
