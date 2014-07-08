package org.iweb.common.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork2.ActionSupport;

public class DefaultAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5402660473816753547L;

	private static Log log = LogFactory.getLog(DefaultAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private HttpServletRequest request;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
}
