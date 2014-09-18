package com.qkj.ware.action;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.InStockHDAO;
import com.qkj.ware.domain.InStockH;

public class InStockHAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(InStockHAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InStockHDAO dao = new InStockHDAO();

	private InStockH inStockH;
	private List<InStockH> inStockHs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public InStockH getInStockH() {
		return inStockH;
	}

	public void setInStockH(InStockH inStockH) {
		this.inStockH = inStockH;
	}

	public List<InStockH> getInStockHs() {
		return inStockHs;
	}

	public void setInStockHs(List<InStockH> inStockHs) {
		this.inStockHs = inStockHs;
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
		ContextHelper.isPermit("QKJ_WARE_INSTOCKH_LIST");
		try {
			map.clear();
			if (inStockH != null)
				map.putAll(ToolsUtil.getMapByBean(inStockH));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setInStockHs(dao.list(map));
			this.setRecCount(dao.getResultCount());
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
				this.setInStockH(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInStockH(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(inStockH == null || inStockH.getUuid()>0)) {
					this.setInStockH((InStockH) dao.get(inStockH.getUuid()));
				} else {
					this.setInStockH(null);
				}
			} else {
				this.setInStockH(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCKH_ADD");
		try {
			//inStockH.setLm_user(ContextHelper.getUserLoginUuid());
			//inStockH.setLm_time(new Date());
			dao.add(inStockH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCKH_MDY");
		try {
			//inStockH.setLm_user(ContextHelper.getUserLoginUuid());
			//inStockH.setLm_time(new Date());
			dao.save(inStockH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCKH_DEL");
		try {
			dao.delete(inStockH);
			setMessage("删除成功!ID=" + inStockH.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
