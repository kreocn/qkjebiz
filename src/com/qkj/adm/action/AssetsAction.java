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
import com.qkj.adm.dao.AssetItemDAO;
import com.qkj.adm.dao.AssetsDAO;
import com.qkj.adm.domain.AssetItem;
import com.qkj.adm.domain.Assets;

public class AssetsAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AssetsAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AssetsDAO dao = new AssetsDAO();

	private Assets assets;
	private List<Assets> assetss;
	private List<AssetItem> assetItems;
	private List<User> ownusers;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;资产列表";
	
	public String getPath() {
		return path;
	}

	public List<User> getOwnusers() {
		return ownusers;
	}

	public void setOwnusers(List<User> ownusers) {
		this.ownusers = ownusers;
	}

	public List<AssetItem> getAssetItems() {
		return assetItems;
	}

	public void setAssetItems(List<AssetItem> assetItems) {
		this.assetItems = assetItems;
	}

	public Assets getAssets() {
		return assets;
	}

	public void setAssets(Assets assets) {
		this.assets = assets;
	}

	public List<Assets> getAssetss() {
		return assetss;
	}

	public void setAssetss(List<Assets> assetss) {
		this.assetss = assetss;
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
			if (assets == null) assets = new Assets();
			if (assets.getResidue_num_begin() == null) assets.setResidue_num_begin(1);
			map.putAll(ToolsUtil.getMapByBean(assets));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str))
					.toString()));
			this.setAssetss(dao.list(map));
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
				this.setAssets(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAssets(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assets_list?viewFlag=relist'>资产列表</a>&nbsp;&gt;&nbsp;添加资产";
			} else if ("mdy".equals(viewFlag)) {
				if (!(assets == null || assets.getUuid() == null)) {
					this.setAssets((Assets) dao.get(assets.getUuid()));

					AssetItemDAO adao = new AssetItemDAO();
					map.clear();
					map.put("asset_id", assets.getUuid());
					this.setAssetItems(adao.list(map));

					UserDAO udao = new UserDAO();
					map.clear();
					ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "uuid");
					this.setOwnusers(udao.list(map));
					path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assets_list?viewFlag=relist'>资产列表</a>&nbsp;&gt;&nbsp;修改资产";
				} else {
					this.setAssets(null);
				}
			} else {
				this.setAssets(null);
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
			assets.setAdd_user(ContextHelper.getUserLoginUuid());
			assets.setAdd_time(new Date());
			assets.setLm_user(ContextHelper.getUserLoginUuid());
			// assets.setLm_time(new Date());
			dao.add(assets);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_MDY");
		try {
			assets.setLm_user(ContextHelper.getUserLoginUuid());
			// assets.setLm_time(new Date());
			dao.save(assets);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_DEL");
		try {
			dao.delete(assets);
			setMessage("删除成功!ID=" + assets.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
