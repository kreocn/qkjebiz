package com.qkj.manage.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.RebatesProductDAO;
import com.qkj.manage.domain.RebatesProduct;

public class RebatesProductAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(RebatesProductAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private RebatesProductDAO dao = new RebatesProductDAO();

	private RebatesProduct rebatesProduct;
	private List<RebatesProduct> rebatesProducts;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public RebatesProduct getRebatesProduct() {
		return rebatesProduct;
	}

	public void setRebatesProduct(RebatesProduct rebatesProduct) {
		this.rebatesProduct = rebatesProduct;
	}

	public List<RebatesProduct> getRebatesProducts() {
		return rebatesProducts;
	}

	public void setRebatesProducts(List<RebatesProduct> rebatesProducts) {
		this.rebatesProducts = rebatesProducts;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATESPRODUCT_LIST");
		try {
			map.clear();
			if (rebatesProduct != null)
				map.putAll(ToolsUtil.getMapByBean(rebatesProduct));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setRebatesProducts(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setRebatesProduct(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setRebatesProduct(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", rebatesProduct.getUuid());
				if (null == map.get("uuid"))
					this.setRebatesProduct(null);
				else
					this.setRebatesProduct((RebatesProduct) dao.list(map).get(0));
			} else {
				this.setRebatesProduct(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATESPRODUCT_ADD");
		try {
			dao.add(rebatesProduct);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATESPRODUCT_MDY");
		try {
			// rebatesProduct.setLm_user(ContextHelper.getUserLoginUuid());
			// rebatesProduct.setLm_time(new Date());
			dao.save(rebatesProduct);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATESPRODUCT_DEL");
		try {
			dao.delete(rebatesProduct);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
