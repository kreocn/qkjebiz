package org.iweb.rpt.logic.Imp.Simple;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.domain.Column;
import org.iweb.rpt.logic.SimpleReport;

public class RPTCollectMoneyStat extends SimpleReport {

	@Override
	public String getSerachName() {
		return "客户应收款统计";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		list.add(new Column("custom_id", "客户编号", 1, SimpleReport.SearchType_Like, "%"));
		list.add(new Column("name_cn", "客户名称", 1, SimpleReport.SearchType_Like, null));
		list.add(new Column("price2011", "2011年欠款", 1));
		list.add(new Column("nprice", "2012年余/欠款", 1));
		list.add(new Column("tprice", "合计应收款", 1));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select custom_id, c.name_cn, a.price2011, a.nprice, a.tprice";
	}

	@Override
	public String getMiddleSqlText() {
		return " From (Select custom_id, Sum(price2011) price2011, Sum(nprice) nprice,Sum(price2011) + Sum(nprice) tprice "
				+ "From (Select r.cus_id custom_id, 0 - Nvl((r.flm_2011_amount - nvl(r.flm_2011_amount_ac, 0)), 0) price2011, "
				+ "0 nprice From erp_r_cus_info r Union All Select f.custom_id, 0 price2011, 0 - nvl("
				+ "Decode(f.is_pay, 1, f.total_price, 2, f.total_price - Nvl(f.pay_amount, 0)), 0) nprice "
				+ "From crm_r_flmorder f Where f.is_pay In (1, 2) Union All Select p.custom_id, 0 price2011, "
				+ "p.pay_amount - Nvl(p.ac_amount, 0) nprice From fms_h_flm_payx p Where p.status In (0, 4)) "
				+ "Group By custom_id) a, crm_t_customer c Where a.custom_id = c.uuid And tprice <> 0";
	}

	@Override
	public String getEndSqlText() {
		return "";
	}

	@Override
	public String getPrvgId() {
		return "LONGTAI_REPORT_SIMPLE_COLLECT_MONEY";
	}

	@Override
	public String getInitShortClassName() {
		return "CollectMoneyStat";
	}

	@Override
	public String getReportRemark() {
		return "1.从【已确认】订单就开始统计 <br />2.负数表示欠款,正数表示余额";
	}

	@Override
	public List<Map<String, Object>> getResultList() {
		return super.getRlist();
	}
}
