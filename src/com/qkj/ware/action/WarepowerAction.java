package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;
import org.iweb.sys.domain.User;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.Warepower;
import com.qkj.ware.dao.WarepowerDAO;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class WarepowerAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(WarepowerAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private WarepowerDAO dao = new WarepowerDAO();

	private Warepower warepower;
	private List<Warepower> warepowers;
	private List<Ware> wares;
	private List<User> users;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Warepower getWarepower() {
		return warepower;
	}

	public void setWarepower(Warepower warepower) {
		this.warepower = warepower;
	}

	public List<Warepower> getWarepowers() {
		return warepowers;
	}

	public void setWarepowers(List<Warepower> warepowers) {
		this.warepowers = warepowers;
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
	

	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_WAREPOWER_WAREPOWER_LIST");
		try {
			map.clear();
			if (warepower != null)
				map.putAll(ToolsUtil.getMapByBean(warepower));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setWarepowers(dao.list(map));
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
				this.setWarepower(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				WareDAO wd=new WareDAO();
				this.setWares(wd.list(null));
				this.setWarepower(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(warepower == null || warepower.getUuid() == null)) {
					this.setWarepower((Warepower) dao.get(warepower.getUuid()));
				} else {
					this.setWarepower(null);
					
				}
				map.clear();
				map.put("user_roles", "1393307368483001");
				this.setUsers(dao.listUser(map));
			} else {
				this.setWarepower(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WAREPOWER_WAREPOWER_ADD");
		try {
			//warepower.setLm_user(ContextHelper.getUserLoginUuid());
			//warepower.setLm_time(new Date());
			dao.add(warepower);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WAREPOWER_WAREPOWER_MDY");
		try {
			//warepower.setLm_user(ContextHelper.getUserLoginUuid());
			//warepower.setLm_time(new Date());
			dao.save(warepower);
			map.clear();
			map.put("ware_id", warepower.getWare_id());
			this.setWarepower((Warepower)dao.list(map).get(0));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WAREPOWER_WAREPOWER_DEL");
		try {
			dao.delete(warepower);
			setMessage("删除成功!ID=" + warepower.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
