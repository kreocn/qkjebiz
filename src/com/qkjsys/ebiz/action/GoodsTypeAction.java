package com.qkjsys.ebiz.action;

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
import com.qkjsys.ebiz.dao.GoodsTypeDAO;
import com.qkjsys.ebiz.domain.GoodsType;

public class GoodsTypeAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(GoodsTypeAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private GoodsTypeDAO dao = new GoodsTypeDAO();

	private GoodsType goodsTypes;
	private List<GoodsType> goodsTypess;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;商品类型列表";
	
	public String getPath() {
		return path;
	}

	public GoodsType getGoodsType() {
		return goodsTypes;
	}

	public void setGoodsType(GoodsType goodsTypes) {
		this.goodsTypes = goodsTypes;
	}

	public List<GoodsType> getGoodsTypes() {
		return goodsTypess;
	}

	public void setGoodsTypes(List<GoodsType> goodsTypess) {
		this.goodsTypess = goodsTypess;
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
		ContextHelper.isPermit("QKJ_EBIZ_GOODSTYPE_LIST");
		try {
			map.clear();
			if (goodsTypes != null)
				map.putAll(ToolsUtil.getMapByBean(goodsTypes));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setGoodsTypes(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;商品类型列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setGoodsType(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setGoodsType(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/goodsType_list?viewFlag=relist'>商品类型列表</a>&nbsp;&gt;&nbsp;添加商品类型";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", goodsTypes.getUuid());
				if (null == map.get("uuid"))
					this.setGoodsType(null);
				else
					this.setGoodsType((GoodsType) dao.list(map).get(0));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/goodsType_list?viewFlag=relist'>商品类型列表</a>&nbsp;&gt;&nbsp;修改商品类型";
			} else {
				this.setGoodsType(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_GOODSTYPE_ADD");
		try {
			goodsTypes.setLm_user(ContextHelper.getUserLoginUuid());
			goodsTypes.setLm_time(new Date());
			dao.add(goodsTypes);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_GOODSTYPE_MDY");
		try {
			goodsTypes.setLm_user(ContextHelper.getUserLoginUuid());
			goodsTypes.setLm_time(new Date());
			dao.save(goodsTypes);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_EBIZ_GOODSTYPE_DEL");
		try {
			dao.delete(goodsTypes);
			setMessage("删除成功!ID=" + goodsTypes.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
