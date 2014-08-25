package com.qkj.manage.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.TravelProductDAO;
import com.qkj.manage.domain.TravelProduct;

public class TravelProductAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(TravelProductAction.class);
	private TravelProductDAO dao = new TravelProductDAO();

	private TravelProduct travelProduct;
	private List<TravelProduct> travelProducts;
	private String message;
	private String viewFlag;

	public TravelProduct getTravelProduct() {
		return travelProduct;
	}

	public void setTravelProduct(TravelProduct travelProduct) {
		this.travelProduct = travelProduct;
	}

	public List<TravelProduct> getTravelProducts() {
		return travelProducts;
	}

	public void setTravelProducts(List<TravelProduct> travelProducts) {
		this.travelProducts = travelProducts;
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

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELPRODUCT_ADD");
		try {
			dao.add(travelProduct);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELPRODUCT_MDY");
		try {
			dao.save(travelProduct);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELPRODUCT_DEL");
		try {
			dao.delete(travelProduct);
			setMessage("删除成功!ID=" + travelProduct.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
