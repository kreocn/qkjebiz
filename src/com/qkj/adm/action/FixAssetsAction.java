package com.qkj.adm.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserDAO;
import org.iweb.sys.domain.User;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.adm.dao.FixAssetsDAO;
import com.qkj.adm.domain.FixAssets;

public class FixAssetsAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(FixAssetsAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private FixAssetsDAO dao = new FixAssetsDAO();

	private FixAssets fixassets;
	private List<FixAssets> fixassetss;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;资产列表";

	private List<User> ownusers;

	public List<User> getOwnusers() {
		return ownusers;
	}

	public void setOwnusers(List<User> ownusers) {
		this.ownusers = ownusers;
	}

	public String getPath() {
		return path;
	}

	public FixAssets getFixassets() {
		return fixassets;
	}

	public void setFixassets(FixAssets fixassets) {
		this.fixassets = fixassets;
	}

	public List<FixAssets> getFixassetss() {
		return fixassetss;
	}

	public void setFixassetss(List<FixAssets> fixassetss) {
		this.fixassetss = fixassetss;
	}

	public void setPath(String path) {
		this.path = path;
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
		ContextHelper.isPermit("QKJ_ADM_ASSETS_LIST");
		try {
			map.clear();
			if (fixassets == null) fixassets = new FixAssets();
			map.putAll(ToolsUtil.getMapByBean(fixassets));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str)).toString()));
			this.setFixassetss(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;资产列表";
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
				this.setFixassets(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setFixassets(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assets_list?viewFlag=relist'>资产列表</a>&nbsp;&gt;&nbsp;添加资产";
			} else if ("mdy".equals(viewFlag)) {
				if (!(fixassets == null || fixassets.getUuid() == null)) {
					this.setFixassets((FixAssets) dao.get(fixassets.getUuid()));
					
					UserDAO udao = new UserDAO();
					User u=new User();
					map.clear();
					ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "uuid");
					if(fixassets.getOwn_user()!=null && fixassets.getOwn_user()!=""){
						String[] uuid=fixassets.getOwn_user().split(",");
						String name="";
						for(int i=0;i<uuid.length;i++){
							u=(User) udao.get(uuid[i]);
							name+=u.getUser_name()+",";
						}
						fixassets.setOwn_user_name(name.substring(0,name.length()-1));
					}
					//this.setOwnusers(udao.list(map));
					
					path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assets_list?viewFlag=relist'>资产列表</a>&nbsp;&gt;&nbsp;修改资产";
				} else {
					this.setFixassets(null);
				}
			} else {
				this.setFixassets(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_ADD");
		try {
			fixassets.setUuid(ToolsUtil.getUUID("M"));
			fixassets.setAdd_user(ContextHelper.getUserLoginUuid());
			fixassets.setAdd_time(new Date());
			fixassets.setLm_user(ContextHelper.getUserLoginUuid());
			fixassets.setLm_time(new Date());
			fixassets.setUse_time(new Date());//领用时间
			dao.add(fixassets);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String addP() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_ADD");
		try {

			if (!(fixassets == null || fixassets.getUuid() == null)) {
				this.setFixassets((FixAssets) dao.get(fixassets.getUuid()));
			}
			FixAssets f = new FixAssets();
			f = fixassets;
			f.setUuid(ToolsUtil.getUUID("M"));
			f.setAdd_user(ContextHelper.getUserLoginUuid());
			f.setAdd_time(new Date());
			f.setLm_user(ContextHelper.getUserLoginUuid());
			f.setLm_time(new Date());
			dao.add(f);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_MDY");
		try {
			fixassets.setLm_user(ContextHelper.getUserLoginUuid());
			fixassets.setLm_time(new Date());
			fixassets.setUse_time(new Date());//领用时间
			dao.save(fixassets);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_DEL");
		try {
			dao.delete(fixassets);
			setMessage("删除成功!ID=" + fixassets.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
