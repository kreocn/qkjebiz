package org.iweb.rpt.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.rpt.logic.SimpleReport;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;

public class SimpleReportAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(SimpleReportAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private String initClassName;

	private SimpleReport simpleReport;

	private String headHtml;
	private String resultHtml;
	private String remarkHtml;
	private String message;

	public String getInitClassName() {
		return initClassName;
	}

	public void setInitClassName(String initClassName) {
		this.initClassName = initClassName;
	}

	public String getHeadHtml() {
		return headHtml;
	}

	public void setHeadHtml(String headHtml) {
		this.headHtml = headHtml;
	}

	public String getResultHtml() {
		return resultHtml;
	}

	public void setResultHtml(String resultHtml) {
		this.resultHtml = resultHtml;
	}

	public String getRemarkHtml() {
		return remarkHtml;
	}

	public void setRemarkHtml(String remarkHtml) {
		this.remarkHtml = remarkHtml;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String execute() throws Exception {
		try {
			String c_initClassName = "org.iweb.rpt.logic.Imp.RPT" + initClassName;
			simpleReport = (SimpleReport) Class.forName(c_initClassName).newInstance();
			log.info("Current initClassName:" + c_initClassName);
			ContextHelper.isPermit(simpleReport.getPrvgId());
			simpleReport.init(ContextHelper.getRequest().getParameterMap());
			// simpleReport.setSearchMap();
			this.setHeadHtml(simpleReport.getHeadHtml());
			this.setResultHtml(simpleReport.getResultHtml());
			this.setRemarkHtml(simpleReport.getReportRemark());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!SimpleReport 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!SimpleReport 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
