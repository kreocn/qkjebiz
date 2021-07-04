package com.qkjsys.ebiz.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.logic.DeptLogic;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.action.warepower;
import com.qkj.ware.dao.WarepowerDAO;
import com.qkj.ware.domain.Warepowers;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class WareAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(WareAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private WareDAO dao = new WareDAO();

	private Ware ware;
	private List<Ware> wares;
	private List<Warepowers> wps;
	private List<Department> depts;
	private Warepowers wp;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;仓库权限管理";
	
	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

	public List<Warepowers> getWps() {
		return wps;
	}

	public void setWps(List<Warepowers> wps) {
		this.wps = wps;
	}

	public Warepowers getWp() {
		return wp;
	}

	public void setWp(Warepowers wp) {
		this.wp = wp;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Ware getWare() {
		return ware;
	}

	public void setWare(Ware ware) {
		this.ware = ware;
	}

	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_WARE_LIST");
		try {
			map.clear();
			if (ware != null)
				map.putAll(ToolsUtil.getMapByBean(ware));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setWares(dao.list(map));
			this.setRecCount(dao.getResultCount());
			WarepowerDAO wpd=new WarepowerDAO();
			if(ware!=null){
				map.clear();
				map.put("ware_id", ware.getUuid());
				this.setWps(wpd.list(map));
			}
			
			DepartmentDAO d=new DepartmentDAO();
			map.clear();
			map.put("type", 1);
			this.setDepts(d.list(map));
			
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;仓库列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String ware_select() throws Exception {
		// ContextHelper.isPermit("GLOBAL_PRVG_DEPT_FUNCTION");
		try {
			this.setWares(dao.list(null));
			
			DepartmentDAO d=new DepartmentDAO();
			map.clear();
			map.put("type", 1);
			this.setDepts(d.list(map));
			
			System.out.println(wares.size());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!ware_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!ware_select 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 20150519 sunshanshan
	 * 仓库权限管理
	 * @return
	 * @throws Exception
	 */
	public String ware_power() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_WARE_LIST");
		try {
			map.clear();
			WarepowerDAO wpd=new WarepowerDAO();
			String warename="";
			if(ware!=null){
				map.clear();
				map.put("ware_id", ware.getUuid());
				this.setWps(wpd.list(map));
				warename=ware.getWare_name();
			}
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;仓库"+warename+"权限列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!ware_power 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!ware_power 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setWare(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setWare(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/ware_list'>仓库列表</a>&nbsp;&gt;&nbsp;增加仓库";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", ware.getUuid());
				if (null == map.get("uuid"))
					this.setWare(null);
				else
					this.setWare((Ware) dao.list(map).get(0));
				DepartmentDAO d=new DepartmentDAO();
				map.clear();
				map.put("type", 1);
				this.setDepts(d.list(map));
			} else {
				this.setWare(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_WARE_ADD");
		try {
			ware.setLm_user(ContextHelper.getUserLoginUuid());
			ware.setLm_time(new Date());
			dao.add(ware);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_WARE_MDY");
		try {
			ware.setLm_user(ContextHelper.getUserLoginUuid());
			ware.setLm_time(new Date());
			dao.save(ware);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_WARE_DEL");
		try {
			dao.delete(ware);
			setMessage("删除成功!ID=" + ware.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
