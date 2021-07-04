package com.qkj.ware.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.AllotH;
import com.qkj.ware.dao.AllotHDAO;

public class AllotHAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AllotHAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AllotHDAO dao = new AllotHDAO();

	private AllotH allotH;
	private List<AllotH> allotHs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public AllotH getAllotH() {
		return allotH;
	}

	public void setAllotH(AllotH allotH) {
		this.allotH = allotH;
	}

	public List<AllotH> getAllotHs() {
		return allotHs;
	}

	public void setAllotHs(List<AllotH> allotHs) {
		this.allotHs = allotHs;
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
		ContextHelper.isPermit("QKJ_WARE_ALLOTH_LIST");
		try {
			map.clear();
			if (allotH != null)
				map.putAll(ToolsUtil.getMapByBean(allotH));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setAllotHs(dao.list(map));
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
				this.setAllotH(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAllotH(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(allotH == null || allotH.getUuid() == null)) {
					this.setAllotH((AllotH) dao.get(allotH.getUuid()));
				} else {
					this.setAllotH(null);
				}
			} else {
				this.setAllotH(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOTH_ADD");
		try {
			//allotH.setLm_user(ContextHelper.getUserLoginUuid());
			//allotH.setLm_time(new Date());
			dao.add(allotH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOTH_MDY");
		try {
			//allotH.setLm_user(ContextHelper.getUserLoginUuid());
			//allotH.setLm_time(new Date());
			dao.save(allotH);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOTH_DEL");
		try {
			dao.delete(allotH);
			setMessage("删除成功!ID=" + allotH.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
