package com.qkj.ware.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.OutDetailH;
import com.qkj.ware.dao.OutDetailHDAO;

public class OutDetailHAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OutDetailHAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OutDetailHDAO dao = new OutDetailHDAO();

	private OutDetailH outDetailH;
	private List<OutDetailH> outDetailHs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public OutDetailH getOutDetailH() {
		return outDetailH;
	}

	public void setOutDetailH(OutDetailH outDetailH) {
		this.outDetailH = outDetailH;
	}

	public List<OutDetailH> getOutDetailHs() {
		return outDetailHs;
	}

	public void setOutDetailHs(List<OutDetailH> outDetailHs) {
		this.outDetailHs = outDetailHs;
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
		ContextHelper.isPermit("QKJ_WARE_OUTDETAILH_LIST");
		try {
			map.clear();
			if (outDetailH != null)
				map.putAll(ToolsUtil.getMapByBean(outDetailH));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setOutDetailHs(dao.list(map));
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
				this.setOutDetailH(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setOutDetailH(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(outDetailH == null || outDetailH.getUuid() == null)) {
					this.setOutDetailH((OutDetailH) dao.get(outDetailH.getUuid()));
				} else {
					this.setOutDetailH(null);
				}
			} else {
				this.setOutDetailH(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTDETAILH_ADD");
		try {
			//outDetailH.setLm_user(ContextHelper.getUserLoginUuid());
			//outDetailH.setLm_time(new Date());
			dao.add(outDetailH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTDETAILH_MDY");
		try {
			//outDetailH.setLm_user(ContextHelper.getUserLoginUuid());
			//outDetailH.setLm_time(new Date());
			dao.save(outDetailH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTDETAILH_DEL");
		try {
			dao.delete(outDetailH);
			setMessage("删除成功!ID=" + outDetailH.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
