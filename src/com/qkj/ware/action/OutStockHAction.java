package com.qkj.ware.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.OutStockH;
import com.qkj.ware.dao.OutStockHDAO;

public class OutStockHAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OutStockHAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OutStockHDAO dao = new OutStockHDAO();

	private OutStockH outStockH;
	private List<OutStockH> outStockHs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public OutStockH getOutStockH() {
		return outStockH;
	}

	public void setOutStockH(OutStockH outStockH) {
		this.outStockH = outStockH;
	}

	public List<OutStockH> getOutStockHs() {
		return outStockHs;
	}

	public void setOutStockHs(List<OutStockH> outStockHs) {
		this.outStockHs = outStockHs;
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
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCKH_LIST");
		try {
			map.clear();
			if (outStockH != null)
				map.putAll(ToolsUtil.getMapByBean(outStockH));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setOutStockHs(dao.list(map));
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
				this.setOutStockH(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setOutStockH(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(outStockH == null || outStockH.getUuid() == null)) {
					this.setOutStockH((OutStockH) dao.get(outStockH.getUuid()));
				} else {
					this.setOutStockH(null);
				}
			} else {
				this.setOutStockH(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCKH_ADD");
		try {
			//outStockH.setLm_user(ContextHelper.getUserLoginUuid());
			//outStockH.setLm_time(new Date());
			dao.add(outStockH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCKH_MDY");
		try {
			//outStockH.setLm_user(ContextHelper.getUserLoginUuid());
			//outStockH.setLm_time(new Date());
			dao.save(outStockH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCKH_DEL");
		try {
			dao.delete(outStockH);
			setMessage("删除成功!ID=" + outStockH.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
