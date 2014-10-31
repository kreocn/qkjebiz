package com.qkj.ware.action;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
	private List<Warepowers> warepowers;
	private List<Ware> wares;
	private List<User> users;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;仓库权限管理";
	
	
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
			System.out.println(warepowers.size());
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
			//warepower.setLm_user(ContextHelper.getUserLoginUuid());
			//warepower.setLm_time(new Date());
			String code=null;
			String user_id=null;
			String codename=null;
			String son="0";
			if((warepower.getDept_code()==null||warepower.getDept_code().equals(""))&&(warepower.getUsername()==null||warepower.getUsername().equals(""))){
				this.setMessage("部门和用户不能全为空！");
			}else{
				if((warepower.getDept_code()!=null&&!warepower.getDept_code().equals(""))){
					code=warepower.getDept_code();
					codename=warepower.getDept_name();
				}
				if(warepower.getUsername()!=null&&!warepower.getUsername().equals("")){
					user_id=warepower.getUsername();
				}
				if(warepower.getSon()!=null&&warepower.getSon()!=""){
					son=warepower.getSon();
				}
				
				if (!(warepowers == null || warepowers.size() == 0)) {
					for (int i = 0, n = warepowers.size(); i < n; i++) {
						warepower = warepowers.get(i);
						if(warepower.getPrvg()==null||warepower.getPrvg().equals("")){
							continue;
						}
						warepower.setUsername(user_id);
						warepower.setDept_code(code);
						warepower.setDept_name(codename);
						warepower.setSon(son);
						dao.add(warepower);
					}
				}
			}
			
			
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
			dao.save(warepower);
		
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
}
