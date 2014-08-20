package com.qkj.manage.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActiveProductDAO;
import com.qkj.manage.domain.ActiveProduct;

public class ActiveProductAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ActiveProductAction.class);
	private ActiveProductDAO dao = new ActiveProductDAO();
	private ActiveDAO adao = new ActiveDAO();

	private ActiveProduct activeProduct;
	private List<ActiveProduct> activeProducts;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public ActiveProduct getActiveProduct() {
		return activeProduct;
	}

	public void setActiveProduct(ActiveProduct activeProduct) {
		this.activeProduct = activeProduct;
	}

	public List<ActiveProduct> getActiveProducts() {
		return activeProducts;
	}

	public void setActiveProducts(List<ActiveProduct> activeProducts) {
		this.activeProducts = activeProducts;
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

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD");
		try {
			activeProduct.setStatus(1);
			dao.add(activeProduct);
			adao.mdyActiveItPrice(activeProduct.getActive_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL");
		try {
			dao.delete(activeProduct);
			adao.mdyActiveItPrice(activeProduct.getActive_id());
			setMessage("删除成功!ID=" + activeProduct.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String addClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPRODUCTCLOSE_ADD");
		try {
			activeProduct.setStatus(2);
			dao.add(activeProduct);
			adao.mdyActiveCloseItPrice(activeProduct.getActive_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String delClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPRODUCTCLOSE_DEL");
		try {
			dao.delete(activeProduct);
			adao.mdyActiveCloseItPrice(activeProduct.getActive_id());
			setMessage("删除成功!ID=" + activeProduct.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
