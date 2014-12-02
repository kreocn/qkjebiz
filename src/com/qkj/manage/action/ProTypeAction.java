package com.qkj.manage.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.ProType;
import com.qkj.manage.dao.ProTypeDAO;

public class ProTypeAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ProTypeAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ProTypeDAO dao = new ProTypeDAO();

	private ProType proType;
	private List<ProType> proTypes;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品类型";
	public String getPath() {
		return path;
	}

	public ProType getProType() {
		return proType;
	}

	public void setProType(ProType proType) {
		this.proType = proType;
	}

	public List<ProType> getProTypes() {
		return proTypes;
	}

	public void setProTypes(List<ProType> proTypes) {
		this.proTypes = proTypes;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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
	
	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_LIST");
		try {
			map.clear();
			if (proType != null)
				map.putAll(ToolsUtil.getMapByBean(proType));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setProTypes(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品类型列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setProType(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setProType(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/proType_relist'>产品类型列表</a>&nbsp;&gt;&nbsp;增加产品类型";
			} else if ("mdy".equals(viewFlag)) {
				if (!(proType == null || proType.getUuid() == null)) {
					this.setProType((ProType) dao.get(proType.getUuid()));
				} else {
					this.setProType(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/proType_relist'>产品类型列表</a>&nbsp;&gt;&nbsp;增加产品类型";
			} else {
				this.setProType(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_ADD");
		try {
			proType.setLm_user(ContextHelper.getUserLoginUuid());
			proType.setLm_time(new Date());
			dao.add(proType);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_MDY");
		try {
			proType.setLm_user(ContextHelper.getUserLoginUuid());
			proType.setLm_time(new Date());
			dao.save(proType);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_DEL");
		try {
			dao.delete(proType);
			setMessage("删除成功!ID=" + proType.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
