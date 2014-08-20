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

public class RPTFlmWM extends SimpleReport {
	private HashMap<String, Object> map;

	private String[] types;

	public RPTFlmWM() {
		types = new String[] { "INVY", "IN", "ORDER_OUT", "MOVE_OUT", "MOVE_IN", "BACK_IN", "CHANGE_OUT" };
		super.setSplitPage(false);
	}

	@Override
	public String getSerachName() {
		return "胶片库存报表(月)";
	}

	@Override
	public List<Column> getColumns() {
		Integer n_year, n_month;
		Date d = DateUtil.addMonth(new Date(), -1);
		n_year = DateUtil.getYear(d);
		n_month = DateUtil.getMonth(d);

		List<Column> list = new ArrayList<Column>();

		list.add(new Column("op_year", "统计年份", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getYears(), n_year, null, 0, null));
		list.add(new Column("op_month", "统计月份", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getMonths(), n_month, null, 0, null));

		list.add(new Column("type_id", "胶片类型", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getTypes(), null, null, 0, null));
		list.add(new Column("ware_id", "出货仓库", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getWares(), null, null, 0, null));
		list.add(new Column("title", "胶片类型", 1));

		list.add(new Column("INVY", "上月库存", 1));
		list.add(new Column("IN", "进货入库", 1));
		list.add(new Column("ORDER_OUT", "订单出货", 1));
		list.add(new Column("MOVE_OUT", "转仓出货", 1));
		list.add(new Column("MOVE_IN", "转仓入库", 1));
		list.add(new Column("TRANSFERING", "物流中", 1));
		list.add(new Column("BACK_IN", "退货入库", 1));
		list.add(new Column("CHANGE_OUT", "换货出库", 1));
		list.add(new Column("WTOTAL", "合计", 1));

		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select a.type_id, p.title, a.ways, Sum(counts) counts";
	}

	@Override
	public String getMiddleSqlText() {
		return "From (Select * From (Select t.ware_id, t.type_id, t.counts, t.ways, to_char"
				+ "(t.op_date,'yyyy') op_year,to_char(t.op_date ,'mm') op_month From wms_h_flm_invy t "
				+ "Union All Select m.from_ware ware_id, m.type_id, 0 - m.counts, 'TRANSFERING' ways "
				+ ", to_char(m.start_time,'yyyy') op_year,to_char(m.start_time,'mm') op_month From wms_r_flm_move m "
				+ "Where m.status = 1 Union All Select i.ware_id, i.type_id, i.counts, 'INVY' ways, to_char(i.rpt_date"
				+ ",'yyyy') op_year,to_char(i.rpt_date,'mm') op_month From rpt_h_flm_invy i)Where 1=1";
	}

	@Override
	public String getEndSqlText() {
		return ") a,erp_c_flm_type p Where a.type_id = p.uuid Group By a.type_id, p.title, a.ways Order By a.type_id";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_FLM_WM";
	}

	@Override
	public String getInitShortClassName() {
		return "FlmWM";
	}

	@Override
	public String getReportRemark() {
		return "1.除上月库存,都是出货即统计！<br />2.【物流中】不计入合计";
	}

	public List<Map<String, Object>> getResultList() {
		List<Map<String, Object>> l = ToolsUtil.conventTable(super.getRlist(), new String[] { "TYPE_ID", "TITLE" },
				new String[] { "COUNTS" }, new String[] { "数量" }, "WAYS", "WAYS");

		ReportUtils.sum(l, types, true, "WTOTAL", true, "TITLE", null);

		super.setRecCount(l.size());
		return l;
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

	private List<ListObject> getYears() {
		List<ListObject> years = new ArrayList<ListObject>();
		years.add(new ListObject("2011", "2011"));
		years.add(new ListObject("2012", "2012"));
		years.add(new ListObject("2013", "2013"));
		years.add(new ListObject("2014", "2014"));
		years.add(new ListObject("2015", "2015"));
		years.add(new ListObject("2016", "2016"));
		years.add(new ListObject("2017", "2017"));
		years.add(new ListObject("2018", "2018"));
		years.add(new ListObject("2019", "2019"));
		years.add(new ListObject("2020", "2020"));
		return years;
	}

	private List<ListObject> getMonths() {
		List<ListObject> months = new ArrayList<ListObject>();
		months.add(new ListObject("1", "1"));
		months.add(new ListObject("2", "2"));
		months.add(new ListObject("3", "3"));
		months.add(new ListObject("4", "4"));
		months.add(new ListObject("5", "5"));
		months.add(new ListObject("6", "6"));
		months.add(new ListObject("7", "7"));
		months.add(new ListObject("8", "8"));
		months.add(new ListObject("9", "9"));
		months.add(new ListObject("10", "10"));
		months.add(new ListObject("11", "11"));
		months.add(new ListObject("12", "12"));
		return months;
	}
}
