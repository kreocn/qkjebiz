package com.qkj.ware.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.InDetailH;
import com.qkj.ware.dao.InDetailHDAO;

public class InDetailHAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(InDetailHAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InDetailHDAO dao = new InDetailHDAO();

	private InDetailH inDetailH;
	private List<InDetailH> inDetailHs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public InDetailH getInDetailH() {
		return inDetailH;
	}

	public void setInDetailH(InDetailH inDetailH) {
		this.inDetailH = inDetailH;
	}

	public List<InDetailH> getInDetailHs() {
		return inDetailHs;
	}

	public void setInDetailHs(List<InDetailH> inDetailHs) {
		this.inDetailHs = inDetailHs;
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
		ContextHelper.isPermit("QKJ_WARE_INDETAILH_LIST");
		try {
			map.clear();
			if (inDetailH != null)
				map.putAll(ToolsUtil.getMapByBean(inDetailH));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setInDetailHs(dao.list(map));
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
				this.setInDetailH(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInDetailH(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(inDetailH == null || inDetailH.getUuid() == null)) {
					this.setInDetailH((InDetailH) dao.get(inDetailH.getUuid()));
				} else {
					this.setInDetailH(null);
				}
			} else {
				this.setInDetailH(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INDETAILH_ADD");
		try {
			//inDetailH.setLm_user(ContextHelper.getUserLoginUuid());
			//inDetailH.setLm_time(new Date());
			dao.add(inDetailH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INDETAILH_MDY");
		try {
			//inDetailH.setLm_user(ContextHelper.getUserLoginUuid());
			//inDetailH.setLm_time(new Date());
			dao.save(inDetailH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INDETAILH_DEL");
		try {
			dao.delete(inDetailH);
			setMessage("删除成功!ID=" + inDetailH.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
