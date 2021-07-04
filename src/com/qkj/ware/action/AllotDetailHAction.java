package com.qkj.ware.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.AllotDetailH;
import com.qkj.ware.dao.AllotDetailHDAO;

public class AllotDetailHAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AllotDetailHAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AllotDetailHDAO dao = new AllotDetailHDAO();

	private AllotDetailH allotDetailH;
	private List<AllotDetailH> allotDetailHs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public AllotDetailH getAllotDetailH() {
		return allotDetailH;
	}

	public void setAllotDetailH(AllotDetailH allotDetailH) {
		this.allotDetailH = allotDetailH;
	}

	public List<AllotDetailH> getAllotDetailHs() {
		return allotDetailHs;
	}

	public void setAllotDetailHs(List<AllotDetailH> allotDetailHs) {
		this.allotDetailHs = allotDetailHs;
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
		ContextHelper.isPermit("QKJ_WARE_ALLOTDETAILH_LIST");
		try {
			map.clear();
			if (allotDetailH != null)
				map.putAll(ToolsUtil.getMapByBean(allotDetailH));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setAllotDetailHs(dao.list(map));
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
				this.setAllotDetailH(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAllotDetailH(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(allotDetailH == null || allotDetailH.getUuid() == null)) {
					this.setAllotDetailH((AllotDetailH) dao.get(allotDetailH.getUuid()));
				} else {
					this.setAllotDetailH(null);
				}
			} else {
				this.setAllotDetailH(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOTDETAILH_ADD");
		try {
			//allotDetailH.setLm_user(ContextHelper.getUserLoginUuid());
			//allotDetailH.setLm_time(new Date());
			dao.add(allotDetailH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOTDETAILH_MDY");
		try {
			//allotDetailH.setLm_user(ContextHelper.getUserLoginUuid());
			//allotDetailH.setLm_time(new Date());
			dao.save(allotDetailH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOTDETAILH_DEL");
		try {
			dao.delete(allotDetailH);
			setMessage("删除成功!ID=" + allotDetailH.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
