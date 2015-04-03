package com.qkj.manage.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.PerWorkDao;
import com.qkj.manage.domain.PerWork;

public class PerWorkAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ProductAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private PerWorkDao dao = new PerWorkDao();
	
	private List<PerWork> perWorks;
	private PerWork perWork;
	
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;个人业务列表";
	
	
	public int getCurrPage() {
		return currPage;
	}


	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}


	public List<PerWork> getPerWorks() {
		return perWorks;
	}


	public void setPerWorks(List<PerWork> perWorks) {
		this.perWorks = perWorks;
	}


	public PerWork getPerWork() {
		return perWork;
	}


	public void setPerWork(PerWork perWork) {
		this.perWork = perWork;
	}


	public String getViewFlag() {
		return viewFlag;
	}


	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
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


	public String getPath() {
		return path;
	}


	public void setPath(String path) {
		this.path = path;
	}


	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_PERSONAL_WORKLIST");
		try {
			map.clear();
			if (perWork == null) perWork = new PerWork();
			ContextHelper.setSearchDeptPermit4Search(map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_PERSONAL_WORKLIST", map, perWork, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			String sql="select * from qkjm_r_active";
			this.setPerWorks(dao.list(map,sql));

			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;个人工作列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

}
