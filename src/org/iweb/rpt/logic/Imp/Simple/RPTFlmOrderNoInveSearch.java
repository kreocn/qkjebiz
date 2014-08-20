package org.iweb.rpt.logic.Imp.Simple;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.Column;
import org.iweb.rpt.logic.SimpleReport;
import org.iweb.sys.DateUtil;

public class RPTFlmOrderNoInveSearch extends SimpleReport {

	@Override
	public String getSerachName() {
		return "无发票胶片统计";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_FLMORDER_NOINVE";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("uuid", "订单编号", 0));
		list.add(new Column("model", "型号", 1));
		list.add(new Column("spec", "规格", 1));
		list.add(new Column("quantity", "数量", 1));
		list.add(new Column("request_send_date_start", "要求发货时间 从", 0, 1, SimpleReport.SearchType_More_Equel, DateUtil
				.getFirstDayOfMonth(new Date()), "yyyy-MM-dd"));
		list.add(new Column("request_send_date_end", "到", 0, 1, SimpleReport.SearchType_Less_Equel, null, "yyyy-MM-dd"));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "SELECT T.UUID, T.MODEL, T.SPEC, SUM(I.QUANTITY) QUANTITY";
	}

	@Override
	public String getMiddleSqlText() {
		return "FROM (SELECT D.*, D.REQUEST_SEND_DATE REQUEST_SEND_DATE_START,D.REQUEST_SEND_DATE REQUEST_SEND_DATE_END FROM CRM_R_FLMORDER D) F, CRM_R_FLMORDER_ITEM I, ERP_C_FLM_TYPE T WHERE F.UUID = I.ORDER_ID AND I.TYPE_ID = T.UUID AND F.STATUS = 40 AND NOT EXISTS (SELECT * FROM CRM_R_FLMORDER_INVES V WHERE V.ORDER_ID = F.UUID)";
	}

	@Override
	public String getEndSqlText() {
		return "GROUP BY T.UUID, T.MODEL, T.SPEC ORDER BY T.UUID";
	}

	@Override
	public String getInitShortClassName() {
		return "FlmOrderNoInveSearch";
	}

	@Override
	public String getReportRemark() {
		return "";
	}

	@Override
	public List<Map<String, Object>> getResultList() {
		return super.getRlist();
	}
}
