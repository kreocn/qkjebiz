package org.iweb.rpt.logic.Imp;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import org.iweb.rpt.dao.SimpleReportDAO;
import org.iweb.rpt.domain.Column;
import org.iweb.rpt.domain.ListObject;
import org.iweb.rpt.logic.SimpleReport;
import org.iweb.sys.DateUtil;

import java.util.HashMap;

public class RPTCustomReply extends SimpleReport {
	private Map<String, Object> map = new HashMap<String, Object>();
	private List<ListObject> selectList;
	private String yearMonth;// 参数 年-月
	private List<ListObject> yearMonths;
	
	

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	public List<ListObject> getYearMonths() {
		return yearMonths;
	}

	public void setYearMonths(List<ListObject> yearMonths) {
		this.yearMonths = yearMonths;
	}

	public RPTCustomReply() {
		super.setSplitPage(false);
	}

	@Override
	public String getSerachName() {
		return "(实时)潜在客户回访报表";
	}

	@Override
	public List<Column> getColumns() {
		List<Column> list = new ArrayList<Column>();
		//<br />
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1;
		int year = cal.get(Calendar.YEAR);
		String ds=year+"-"+month;
		list.add(new Column("sdate","月份", SimpleReport.ColumnType_String, 0, 1, SimpleReport.ColumnType_String,
				SimpleReport.ObjType_Select, getAreas(), ds, null, 0, null));
		list.add(new Column("dept_code", "部门代码", 0));
		list.add(new Column("dept_name", "部门名称", 1));
		list.add(new Column("dept_num", "总客户数", 1));
		list.add(new Column("noreply", "零 回 访<br />总客户数", 1));
		list.add(new Column("new", "本月新增<br />客 户 数", 1));
		list.add(new Column("month_noreply", "未回访新增<br />客 户 数", 1));
		list.add(new Column("m_replyx", "新增客户<br />回访率(%)", 1));
		list.add(new Column("replay_customer", "本月回访<br />客 户 数", 1));
		list.add(new Column("reply", "本 月<br />总回访数", 1));
		list.add(new Column("m_reply", "新客户<br />回访数", 1));
		list.add(new Column("active", "活  跃<br />客户数", 1));
		list.add(new Column("active_reply", "活跃客户<br />回访率(%)", 1));
		list.add(new Column("pre_reply", "人 均<br />回访数", 1));
		return list;
	}

	@Override
	public String getStartSqlText() {
		return "Select * ";
	}

	@Override
	public String getMiddleSqlText() {
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1;
		int year = cal.get(Calendar.YEAR);
		String ds=year+"-"+month;
		return "From rpt_m_customer t where 1=1";
	}

	@Override
	public String getEndSqlText() {
		return "Order By t.dept_code";
	}

	@Override
	public String getPrvgId() {
		return "REPORT_SIMPLE_CUSTOM_REPLY_RUNTIME";
	}

	@Override
	public String getInitShortClassName() {
		return "CustomReply";
	}

	@Override
	public String getReportRemark() {
		StringBuffer sb = new StringBuffer();
		sb.append("<div style='color:#025;''><hr /><b>名词解释</b><br />");
		sb.append("总客户数: 该办事处所有的客户总数<br />");
		sb.append("零回访总客户数: 无回访记录的客户总数<br />");
		sb.append("本月新增客户数: 本月新增加的客户数量<br />");
		sb.append("未回访新增客户数: 无回访记录的本月新增客户数<br />");
		sb.append("新增客户回访率(%): [已回访新增客户数]/[本月新增客户数]<br />");
		sb.append("本月回访客户数: 本月回访的客户总数<br />");
		sb.append("本月回访总数: 本月回访的次数<br />");
		sb.append("新客户回访数: 对本月新增客户进行回访的次数<br />");
		sb.append("活跃客户数: 3个月内有回访记录的客户数(含本月)<br />");
		sb.append("活跃客户回访率: [本月回访客户数]/[活跃客户数]<br />");
		sb.append("人均回访数: [本月回访总数]/[部门人数]<br /><div>");
		return sb.toString();
	}
	
	private List<ListObject> getAreas() {
		/*List<ListObject> list = new ArrayList<ListObject>();
		String sql="SELECT DATE_FORMAT(sdate,'%Y-%m') key1,DATE_FORMAT(sdate,'%Y-%m') value1 FROM rpt_m_customer GROUP BY key1";
		SimpleReportDAO sdao=new SimpleReportDAO();
		map.clear();
		map.put("sqltext", sql);
		this.selectList=sdao.getSimpleList(map);
		*/
		GregorianCalendar g=new GregorianCalendar();
		if (yearMonths == null) {
			yearMonths = new ArrayList<>();
		}
		String patten = "yyyy-MM";
		Date ds = DateUtil.getDate("2014-04", patten);
		Date de = DateUtil.addMonth(DateUtil.getDate(new Date(), patten), 1);
		while (ds.before(de)) {
			int m=ds.getMonth();
			int month=(int)g.get(Calendar.MONTH);
			int day=(int)g.get(Calendar.DATE);
			String dd=DateUtil.format(ds, patten);
			System.out.println(dd);
			if(m==month){//本月
    			if(day>26){
    				dd=dd+"-"+26;
    			}else{
    				dd=dd+"-"+day;
    			}
    			
    		}else{
    			dd=dd+"-"+26;
    		}
			yearMonths.add(new ListObject(dd, DateUtil.format(ds, patten)));
			ds = DateUtil.addMonth(ds, 1);
		}
		
		return yearMonths;

	}

	public List<Map<String, Object>> getResultList() {
		return super.getRlist();
	}
}
