package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.PerWorkDao;
import com.qkj.manage.dao.ProTypeDAO;
import com.qkj.manage.domain.PerWork;
import com.qkj.manage.domain.PerWorkSelect;
import com.qkj.manage.domain.Product;

public class PerWorkAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ProductAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private PerWorkDao dao = new PerWorkDao();
	private PerWorkSelectAction wsa=new PerWorkSelectAction();
	
	private List<PerWork> perWorks;
	private PerWork perWork;
	private PerWorkSelect perWorkSelect;
	private List<PerWorkSelect> perWorkSelects;
	
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;个人业务列表";
	
	
	public PerWorkSelect getPerWorkSelect() {
		return perWorkSelect;
	}


	public void setPerWorkSelect(PerWorkSelect perWorkSelect) {
		this.perWorkSelect = perWorkSelect;
	}


	public List<PerWorkSelect> getPerWorkSelects() {
		return perWorkSelects;
	}


	public void setPerWorkSelects(List<PerWorkSelect> perWorkSelects) {
		this.perWorkSelects = perWorkSelects;
	}


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
			String sql=wsa.getSelWork();
			System.out.println(sql);
			if(sql.equals("") || sql==null){
				this.setMessage("您还没有此功能权限,请联系管理员解决！");
			}else{
				this.setPerWorks(dao.list(map,sql));
			}
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;个人工作列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	
	public String listPower() throws Exception {
		ContextHelper.isPermit("QKJ_PERSONAL_WORKPOWERLIST");
		try {
			map.clear();
			if (perWork == null) perWork = new PerWork();
			ContextHelper.setSearchDeptPermit4Search(map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_PERSONAL_WORKPOWERLIST", map, perWork, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setPerWorkSelects(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;个人工作权限列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	
	public String loadPower() throws Exception {
		try {
			ProTypeDAO ptd=new ProTypeDAO();
			if (null == viewFlag) {
				this.setPerWorkSelect(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setPerWorkSelect(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/person/perWorkPower_list?viewFlag=relist'>个人工作权限列表</a>&nbsp;&gt;&nbsp;增加权限";
			} else if ("mdy".equals(viewFlag)) {
				this.setPerWorkSelect((PerWorkSelect) dao.getPower(perWorkSelect.getUuid()));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/person/perWorkPower_list?viewFlag=relist'>个人工作权限列表</a>&nbsp;&gt;&nbsp;修改权限";
			} else {
				this.setPerWorkSelect(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String addPower() throws Exception {
		ContextHelper.isPermit("QKJ_PERSONAL_POWER_ADD");
		try {
			perWorkSelect.setLm_user(ContextHelper.getUserLoginUuid());
			perWorkSelect.setLm_time(new Date());
			dao.addPower(perWorkSelect);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String savePower() throws Exception {
		ContextHelper.isPermit("QKJ_PERSONAL_POWER_MDY");
		try {
			perWorkSelect.setLm_user(ContextHelper.getUserLoginUuid());
			perWorkSelect.setLm_time(new Date());
			dao.savePower(perWorkSelect);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String delPower() throws Exception {
		ContextHelper.isPermit("QKJ_PERSONAL_POWER_DEL");
		try {
			dao.deletePower(perWorkSelect);
			setMessage("删除成功!ID=" + perWorkSelect.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

}
