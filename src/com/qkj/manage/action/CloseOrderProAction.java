package com.qkj.manage.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.CloseOrderPro;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.CloseOrderProDAO;

public class CloseOrderProAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CloseOrderProAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CloseOrderProDAO dao = new CloseOrderProDAO();
	private CloseOrderDAO cdao=new CloseOrderDAO();

	private CloseOrderPro closeOrderPro;
	private List<CloseOrderPro> closeOrderPros;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单商品";
	public String getPath() {
		return path;
	}

	public CloseOrderPro getCloseOrderPro() {
		return closeOrderPro;
	}

	public void setCloseOrderPro(CloseOrderPro closeOrderPro) {
		this.closeOrderPro = closeOrderPro;
	}

	public List<CloseOrderPro> getCloseOrderPros() {
		return closeOrderPros;
	}

	public void setCloseOrderPros(List<CloseOrderPro> closeOrderPros) {
		this.closeOrderPros = closeOrderPros;
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
		//ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDERPRO_LIST");
		try {
			map.clear();
			if (closeOrderPro != null)
				map.putAll(ToolsUtil.getMapByBean(closeOrderPro));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setCloseOrderPros(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单商品列表";
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
				this.setCloseOrderPro(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setCloseOrderPro(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrderPro_relist'>结案提货单商品列表</a>&nbsp;&gt;&nbsp;增加结案提货单商品";
			} else if ("mdy".equals(viewFlag)) {
				if (!(closeOrderPro == null || closeOrderPro.getUuid() == null)) {
					this.setCloseOrderPro((CloseOrderPro) dao.get(closeOrderPro.getUuid()));
				} else {
					this.setCloseOrderPro(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrderPro_relist'>结案提货单商品列表</a>&nbsp;&gt;&nbsp;增加结案提货单商品";
			} else {
				this.setCloseOrderPro(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDERPRO_ADD");
		try {
			//closeOrderPro.setLm_user(ContextHelper.getUserLoginUuid());
			//closeOrderPro.setLm_time(new Date());
			dao.add(closeOrderPro);
			cdao.updateTotal(closeOrderPro.getOrder_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDERPRO_MDY");
		try {
			//closeOrderPro.setLm_user(ContextHelper.getUserLoginUuid());
			//closeOrderPro.setLm_time(new Date());
			dao.save(closeOrderPro);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDERPRO_DEL");
		try {
			dao.delete(closeOrderPro);
			cdao.updateTotal(closeOrderPro.getOrder_id());
			setMessage("删除成功!ID=" + closeOrderPro.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
