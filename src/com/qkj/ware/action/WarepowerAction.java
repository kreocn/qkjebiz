package com.qkj.ware.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.User;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.WarepowerDAO;
import com.qkj.ware.domain.Warepowers;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class WarepowerAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(WarepowerAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private WarepowerDAO dao = new WarepowerDAO();

	private Warepowers warepower;
	private Ware ware;
	private List<Warepowers> warepowers;
	private List<Ware> wares;
	private List<User> users;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;仓库权限管理";
	
	
	public Ware getWare() {
		return ware;
	}

	public void setWare(Ware ware) {
		this.ware = ware;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Warepowers getWarepower() {
		return warepower;
	}

	public void setWarepower(Warepowers warepower) {
		this.warepower = warepower;
	}

	public List<Warepowers> getWarepowers() {
		return warepowers;
	}

	public void setWarepowers(List<Warepowers> warepowers) {
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
		ContextHelper.isPermit("QKJ_WARE_WAREPOWER_LIST");
		try {
			map.clear();
			if (warepower != null)
				map.putAll(ToolsUtil.getMapByBean(warepower));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setWarepowers(dao.list(map));
			WareDAO wd=new WareDAO();
			this.setWares(wd.list(null));
			this.setRecCount(dao.getResultCount());
			this.setWarepower(null);
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;仓库权限列表";
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
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/warepower/warepower_list'>仓库权限列表</a>&nbsp;&gt;&nbsp;增加仓库权限";
			} else if ("mdy".equals(viewFlag)) {
				if (!(warepower == null || warepower.getUuid() == null)) {
					this.setWarepower((Warepowers) dao.get(warepower.getUuid()));
				} else {
					
					this.setWarepower(null);
					
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/warepower/warepower_list'>仓库权限列表</a>&nbsp;&gt;&nbsp;仓库权限详情";
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
		ContextHelper.isPermit("QKJ_WARE_WAREPOWER_ADD");
		try {
			if(warepower.getSon()==null || warepower.getSon().equals("")){
				warepower.setSon("0");
			}
			warepower.setWare_id(ware.getUuid());
			warepower.setWare_name(ware.getWare_name());
			dao.add(warepower);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_WAREPOWER_MDY");
		try {
			//warepower.setLm_user(ContextHelper.getUserLoginUuid());
			//warepower.setLm_time(new Date());
			if(warepower.getSon()==null || warepower.getSon().equals("")){
				warepower.setSon("0");
			}
			warepower.setWare_id(ware.getUuid());
			dao.save(warepower);
			WareDAO wd=new WareDAO();
			map.clear();map.put("uuid", ware.getUuid());
			this.setWares(wd.list(map));
			if(wares.size()>0){
				this.setWare(wares.get(0));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_WAREPOWER_DEL");
		try {
			dao.delete(warepower);
			setMessage("删除成功!ID=" + warepower.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	
	public String checkUser() throws Exception {
		boolean flag = true;
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			HttpServletRequest request = ServletActionContext.getRequest();
			String userid = request.getParameter("userid");
			String wareid=request.getParameter("wareid");
			map.clear();
			map.put("username", userid);
			map.put("ware_id", wareid);
			List<Warepowers> ps=new ArrayList<>();
			ps=dao.list(map);
			if(ps.size()>0){
				flag = false;
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		ServletActionContext.getResponse().getWriter().print(flag);
		return null;
	}
}
