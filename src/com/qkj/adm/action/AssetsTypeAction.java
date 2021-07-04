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
import org.iweb.sys.dao.DepartmentDAO;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.adm.dao.AssetsTypeDAO;
import com.qkj.adm.domain.AssetsType;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class AssetsTypeAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AssetsTypeAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AssetsTypeDAO dao = new AssetsTypeDAO();

	private AssetsType assetstype;
	private List<AssetsType> assetstypes;
	private List<AssetsType> types;
	private String message;
	private List<Ware> wares;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;资产列表";

	public List<AssetsType> getTypes() {
		return types;
	}

	public void setTypes(List<AssetsType> types) {
		this.types = types;
	}

	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}

	public String getPath() {
		return path;
	}

	public AssetsType getAssetstype() {
		return assetstype;
	}

	public void setAssetstype(AssetsType assetstype) {
		this.assetstype = assetstype;
	}

	public List<AssetsType> getAssetstypes() {
		return assetstypes;
	}

	public void setAssetstypes(List<AssetsType> assetstypes) {
		this.assetstypes = assetstypes;
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
			if (assetstype == null) assetstype = new AssetsType();
			map.putAll(ToolsUtil.getMapByBean(assetstype));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str)).toString()));
			this.setAssetstypes(dao.list(map));
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
				this.setAssetstype(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAssetstype(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assets_list?viewFlag=relist'>资产列表</a>&nbsp;&gt;&nbsp;添加资产";
			} else if ("mdy".equals(viewFlag)) {
				if (!(assetstype == null || assetstype.getUuid() == null)) {
					this.setAssetstype((AssetsType) dao.get(assetstype.getUuid()));

					path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/assets_list?viewFlag=relist'>资产列表</a>&nbsp;&gt;&nbsp;修改资产";
				} else {
					this.setAssetstype(null);
				}
			} else {
				this.setAssetstype(null);
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
			assetstype.setLm_user(ContextHelper.getUserLoginUuid());
			assetstype.setLm_time(new Date());
			dao.add(assetstype);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_MDY");
		try {
			assetstype.setLm_user(ContextHelper.getUserLoginUuid());
			assetstype.setLm_time(new Date());
			dao.save(assetstype);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_ASSETS_DEL");
		try {
			dao.delete(assetstype);
			setMessage("删除成功!ID=" + assetstype.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String asset_select() throws Exception {
		/*
		 * map.clear();
		 * this.setAssetstypes(dao.list(map));
		 * System.out.println(assetstypes.size()+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		 */

		try {
			/*WareDAO w = new WareDAO();
			this.setWares(w.list(null));*/

			/*
			 * DepartmentDAO d = new DepartmentDAO();
			 * map.clear();
			 * map.put("type", 1);
			 * this.setDepts(d.list(map));
			 */
			 this.setTypes(dao.list(null));
			 for(int i=0;i<types.size();i++){
				 System.out.println(types.get(i).getTypea()+types.get(i).getUuid()+types.get(i).getParent_type());
			 }
			 System.out.println(types.size()+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!ware_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!ware_select 读取数据错误:", e);
		}

		return SUCCESS;
	}
}
