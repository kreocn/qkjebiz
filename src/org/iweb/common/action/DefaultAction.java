package org.iweb.common.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.sche.action.ScheAction;
import com.qkj.sche.dao.ScheduleDAO;
import com.qkj.sche.domain.Schedule;

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
	
	private ScheduleDAO dao = new ScheduleDAO();
	private Schedule sche;
	private List<Schedule> sches;
	
	
	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public Schedule getSche() {
		return sche;
	}

	public void setSche(Schedule sche) {
		this.sche = sche;
	}

	public List<Schedule> getSches() {
		return sches;
	}

	public void setSches(List<Schedule> sches) {
		this.sches = sches;
	}

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
	/*	ContextHelper.isPermit("QKJ_SCHE");*/
		String u = ContextHelper.getUserLoginUuid();
		String code = ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (sche != null)
				map.putAll(ToolsUtil.getMapByBean(sche));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			if (ContextHelper.isAdmin()) {// 管理员
				this.setSches(dao.listpage(map));
			}else{
				map.put("puuid", u);
				map.put("ruuid", u);
				map.put("dept_code", code);
				this.setSches(dao.listbypage(map));
			}
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
