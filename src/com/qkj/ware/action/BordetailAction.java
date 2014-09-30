package com.qkj.ware.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.Bordetail;
import com.qkj.ware.dao.BordetailDAO;

public class BordetailAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(BordetailAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private BordetailDAO dao = new BordetailDAO();

	private Bordetail bordetail;
	private List<Bordetail> bordetails;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public Bordetail getBordetail() {
		return bordetail;
	}

	public void setBordetail(Bordetail bordetail) {
		this.bordetail = bordetail;
	}

	public List<Bordetail> getBordetails() {
		return bordetails;
	}

	public void setBordetails(List<Bordetail> bordetails) {
		this.bordetails = bordetails;
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
		//ContextHelper.isPermit("QKJ_BORDETAIL_BORDETAIL_LIST");
		try {
			map.clear();
			if (bordetail != null)
				map.putAll(ToolsUtil.getMapByBean(bordetail));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setBordetails(dao.list(map));
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
				this.setBordetail(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setBordetail(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(bordetail == null || bordetail.getUuid() == null)) {
					this.setBordetail((Bordetail) dao.get(bordetail.getUuid()));
				} else {
					this.setBordetail(null);
				}
			} else {
				this.setBordetail(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_BORDETAIL_BORDETAIL_ADD");
		try {
			//bordetail.setLm_user(ContextHelper.getUserLoginUuid());
			//bordetail.setLm_time(new Date());
			dao.add(bordetail);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_BORDETAIL_BORDETAIL_MDY");
		try {
			//bordetail.setLm_user(ContextHelper.getUserLoginUuid());
			//bordetail.setLm_time(new Date());
			dao.save(bordetail);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_BORDETAIL_BORDETAIL_DEL");
		try {
			dao.delete(bordetail);
			setMessage("删除成功!ID=" + bordetail.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
