package org.iweb.rpt.logic.Imp.Simple;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.Column;
import org.iweb.rpt.logic.SimpleReport;
import org.iweb.sys.DateUtil;

/**
 * 已经不使用
 */
@Deprecated
public class RPTCustomPaySearch extends SimpleReport {

	@Override
	public String getSerachName() {
		return "客户余/欠款明细";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_CUSTOM_PAY_SEARCH";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("order_id", "订单编号", 1, SimpleReport.SearchType_Like, null));
		list.add(new Column("request_send_date", "要求发货时间", 1, 0, 0, null, "yyyy-MM-dd"));
		list.add(new Column("custom_id", "客户编号", 1, SimpleReport.SearchType_Like, "C%"));
		list.add(new Column("request_send_date_start", "要求发货时间 从", 0, 1, SimpleReport.SearchType_More_Equel, DateUtil
				.getFirstDayOfMonth(new Date()), "yyyy-MM-dd"));
		list.add(new Column("request_send_date_end", "到", 0, 1, SimpleReport.SearchType_Less_Equel, null, "yyyy-MM-dd"));
		list.add(new Column("name_cn", "客户名称", 1, SimpleReport.SearchType_Like, null));
		list.add(new Column("nprice", "余/欠款", 1));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "SELECT *";
	}

	@Override
	public String getMiddleSqlText() {
		return "FROM (SELECT F.UUID ORDER_ID,F.REQUEST_SEND_DATE,C.UUID CUSTOM_ID,C.NAME_CN,F.REQUEST_SEND_DATE REQUEST_SEND_DATE_START,F.REQUEST_SEND_DATE REQUEST_SEND_DATE_END,NVL(F.PAY_AMOUNT, 0)-NVL(F.TOTAL_PRICE, 0) NPRICE FROM CRM_R_FLMORDER F, CRM_T_CUSTOMER C WHERE F.CUSTOM_ID = C.UUID AND F.STATUS = 40 ORDER BY F.REQUEST_SEND_DATE) WHERE NPRICE <> 0";
	}

	@Override
	public String getEndSqlText() {
		return "";
	}

	@Override
	public String getInitShortClassName() {
		return "CustomPaySearch";
	}

	@Override
	public String getReportRemark() {
		return "1.余/欠款,正数代表余额,负数代表欠款.<br />2.【已开票】的订单才计入查询!";
	}

	@Override
	public List<Map<String, Object>> getResultList() {
		return super.getRlist();
	}
}
