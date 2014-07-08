package org.iweb.rpt.logic.Imp.Simple;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.Column;
import org.iweb.rpt.domain.ListObject;
import org.iweb.rpt.logic.SimpleReport;

public class RPTCustomSales extends SimpleReport {

	@Override
	public String getSerachName() {
		return "客户销售报表";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("uuid", "客户编号", SimpleReport.ColumnType_String, 1, 1, SimpleReport.SearchType_Like,
				SimpleReport.ObjType_Text, null, "%", null, 2,
				"/erp/crm/customer_load?viewFlag=view&$customer.uuid:uuid$"));

		list.add(new Column("area", "区域", SimpleReport.ColumnType_Int, 0, 1, SimpleReport.SearchType_Equel,
				SimpleReport.ObjType_Select, getAreas(), null, null, 0, null));
		list.add(new Column("area_name", "区域", 1));
		list.add(new Column("province", "省", 1, SimpleReport.SearchType_Like, "%"));
		list.add(new Column("city", "市/地区", 1, SimpleReport.SearchType_Like, "%"));
		list.add(new Column("name_cn", "客户名称", SimpleReport.ColumnType_String, 1, 1, SimpleReport.SearchType_Like,
				SimpleReport.ObjType_Text, null, null, null, 2, "/erp/report/customMain?$custom_id:uuid$"));
		list.add(new Column("name_internal", "客户别名", 1, SimpleReport.SearchType_Like, null));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select t.uuid, t.name_cn, t.name_internal,t.area,decode(t.area, 1, '华北', 2, '华东', 3, '华南', 4, '西南', 5, '西北', '其他') area_name,t.province, t.city";
	}

	@Override
	public String getMiddleSqlText() {
		return "From crm_t_customer t Where 1=1";
	}

	@Override
	public String getEndSqlText() {
		return "Order By t.uuid";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_CUSTOM_SALES";
	}

	@Override
	public String getInitShortClassName() {
		return "CustomSales";
	}

	@Override
	public String getReportRemark() {
		return "";
	}

	public List<Map<String, Object>> getResultList() {
		return super.getRlist();
	}

	private List<ListObject> getAreas() {
		List<ListObject> list = new ArrayList<ListObject>();
		list.add(new ListObject("1", "华北"));
		list.add(new ListObject("2", "华东"));
		list.add(new ListObject("3", "华南"));
		list.add(new ListObject("4", "西南"));
		list.add(new ListObject("5", "西北"));
		list.add(new ListObject("0", "其他"));
		return list;
	}

}
