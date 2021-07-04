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

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.adm.dao.AssetItemDAO;
import com.qkj.adm.domain.AssetItem;

public class AssetItemAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AssetItemAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AssetItemDAO dao = new AssetItemDAO();

	private AssetItem assetItem;
	private List<AssetItem> assetItems;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;资产物品列表";
	
	public String getPath() {
		return path;
	}

	public AssetItem getAssetItem() {
		return assetItem;
	}

	public void setAssetItem(AssetItem assetItem) {
		this.assetItem = assetItem;
	}

	public List<AssetItem> getAssetItems() {
		return assetItems;
	}

	public void setAssetItems(List<AssetItem> assetItems) {
		this.assetItems = assetItems;
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
		ContextHelper.isPermit("QKJ_ADM_ASSETITEM_LIST");
		try {
			map.clear();
			if (assetItem != null) map.putAll(ToolsUtil.getMapByBean(assetItem));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str))
					.toString()));
			this.setAssetItems(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;资产物品列表";
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
				this.setAssetItem(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAssetItem(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assetItem_list'>资产物品列表</a>&nbsp;&gt;&nbsp;添加资产物品";
			} else if ("mdy".equals(viewFlag)) {
				if (!(assetItem == null || assetItem.getUuid() == null)) {
					this.setAssetItem((AssetItem) dao.get(assetItem.getUuid()));
					path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assetItem_list'>资产物品列表</a>&nbsp;&gt;&nbsp;修改资产物品";
				} else {
					this.setAssetItem(null);
				}
			} else {
				this.setAssetItem(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETITEM_ADD");
		try {
			assetItem.setUuid(ToolsUtil.getUUID("M"));
			assetItem.setIs_use(0);
			assetItem.setAdd_user(ContextHelper.getUserLoginUuid());
			assetItem.setAdd_time(new Date());
			assetItem.setLm_user(ContextHelper.getUserLoginUuid());
			dao.add(assetItem);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 在此处,op_user会被当作类似创建的原uuid参数被传入
	 * 
	 * @return
	 * @throws Exception
	 */
	public String addSimilar() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETITEM_ADD");
		try {
			// 先把传入的UUID转变成op_user
			assetItem.setOp_user(assetItem.getUuid());
			assetItem.setUuid(ToolsUtil.getUUID("M"));
			assetItem.setIs_use(0);
			assetItem.setAdd_user(ContextHelper.getUserLoginUuid());
			assetItem.setAdd_time(new Date());
			assetItem.setLm_user(ContextHelper.getUserLoginUuid());
			dao.addSimilar(assetItem);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addSimilar 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!addSimilar 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETITEM_MDY");
		try {
			assetItem.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(assetItem);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String own() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETITEM_OWN");
		try {
			assetItem.setLm_user(ContextHelper.getUserLoginUuid());
			assetItem.setOp_user(ContextHelper.getUserLoginUuid());
			assetItem.setOp_time(new Date());
			dao.own(assetItem);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!own 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!own 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETITEM_DEL");
		try {
			dao.delete(assetItem);
			setMessage("删除成功!ID=" + assetItem.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	public String print() throws Exception {
		try {
			if(assetItem!=null){
			map.clear();
			map.put("nuuid", assetItem.getNuuid());
			map.put("lm_time_item", assetItem.getLm_time_item());
			map.put("company", assetItem.getCompany());
			map.put("btype", assetItem.getBtype());
			map.put("ctype", assetItem.getCtype());
			}
			this.setAssetItems(dao.getPrint(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
