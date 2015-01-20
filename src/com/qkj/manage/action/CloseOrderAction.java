package com.qkj.manage.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.dao.CloseOrderDAO;

public class CloseOrderAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CloseOrderAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CloseOrderDAO dao = new CloseOrderDAO();

	private CloseOrder closeOrder;
	private List<CloseOrder> closeOrders;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单";
	public String getPath() {
		return path;
	}

	public CloseOrder getCloseOrder() {
		return closeOrder;
	}

	public void setCloseOrder(CloseOrder closeOrder) {
		this.closeOrder = closeOrder;
	}

	public List<CloseOrder> getCloseOrders() {
		return closeOrders;
	}

	public void setCloseOrders(List<CloseOrder> closeOrders) {
		this.closeOrders = closeOrders;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_LIST");
		try {
			map.clear();
			if (closeOrder != null)
				map.putAll(ToolsUtil.getMapByBean(closeOrder));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setCloseOrders(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单列表";
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
				this.setCloseOrder(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setCloseOrder(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrder_relist'>结案提货单列表</a>&nbsp;&gt;&nbsp;增加结案提货单";
			} else if ("mdy".equals(viewFlag)) {
				if (!(closeOrder == null || closeOrder.getUuid() == null)) {
					this.setCloseOrder((CloseOrder) dao.get(closeOrder.getUuid()));
				} else {
					this.setCloseOrder(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrder_relist'>结案提货单列表</a>&nbsp;&gt;&nbsp;增加结案提货单";
			} else {
				this.setCloseOrder(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_ADD");
		try {
			//closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			//closeOrder.setLm_time(new Date());
			dao.add(closeOrder);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_MDY");
		try {
			//closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			//closeOrder.setLm_time(new Date());
			dao.save(closeOrder);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_DEL");
		try {
			dao.delete(closeOrder);
			setMessage("删除成功!ID=" + closeOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
