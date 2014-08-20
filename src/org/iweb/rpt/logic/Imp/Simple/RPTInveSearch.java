package org.iweb.rpt.logic.Imp.Simple;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.Column;
import org.iweb.rpt.logic.SimpleReport;

public class RPTInveSearch extends SimpleReport {

	@Override
	public String getSerachName() {
		return "发票查询报表";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("invoice_date_start", "开票时间 从", 0, 1, SimpleReport.SearchType_More_Equel, null,
				"yyyy-MM-dd"));
		list.add(new Column("invoice_date_end", "到", 0, 1, SimpleReport.SearchType_Less_Equel, null, "yyyy-MM-dd"));
		list.add(new Column("inve_id", "发票号", 1, SimpleReport.SearchType_Like, "%"));
		list.add(new Column("invoice_date", "开票时间", 1, 0, 0, null, "yyyy-MM-dd"));
		list.add(new Column("head", "发票抬头", 1, SimpleReport.SearchType_Like, "%"));
		list.add(new Column("payee_name", "开票单位", 1, SimpleReport.SearchType_Like, "%"));
		list.add(new Column("custom_id", "所属客户编号", 0, SimpleReport.SearchType_Like, "C%"));
		list.add(new Column("order_id", "所属订单", SimpleReport.ColumnType_String, 1, 1, SimpleReport.SearchType_Like,
				SimpleReport.ObjType_Text, null, "D%", null, 2,
				"/erp/crm/flmOrder_load?viewFlag=view&$flmOrder.uuid:order_id$"));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select *";
	}

	@Override
	public String getMiddleSqlText() {
		return "From (Select i.invoice_date invoice_date_start, i.invoice_date invoice_date_end, f.inve_id,"
				+ "i.invoice_date, i.head, p.payee_name, f.order_id,d.custom_id From crm_r_flmorder_inves f,"
				+ "crm_r_flmorder d, fms_h_flmr_inve i, erp_c_order_payee p Where f.inve_id = i.uuid "
				+ "And i.payee_id = p.uuid And f.order_id = d.uuid And d.status >= 0 "
				+ "Order By i.invoice_date) Where 1=1";
	}

	@Override
	public String getEndSqlText() {
		return "Order By invoice_date Desc";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_INVE_SEARCH";
	}

	@Override
	public String getInitShortClassName() {
		return "InveSearch";
	}

	@Override
	public String getReportRemark() {
		return "";
	}

	public List<Map<String, Object>> getResultList() {
		return super.getRlist();
	}
}
