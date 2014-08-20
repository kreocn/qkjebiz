package com.qkj.manage.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.TravelCustomerDAO;
import com.qkj.manage.domain.TravelCustomer;

public class TravelCustomerAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(TravelCustomerAction.class);
	private TravelCustomerDAO dao = new TravelCustomerDAO();

	private TravelCustomer travelCustomer;
	private List<TravelCustomer> travelCustomers;
	private String message;
	private String viewFlag;

	public TravelCustomer getTravelCustomer() {
		return travelCustomer;
	}

	public void setTravelCustomer(TravelCustomer travelCustomer) {
		this.travelCustomer = travelCustomer;
	}

	public List<TravelCustomer> getTravelCustomers() {
		return travelCustomers;
	}

	public void setTravelCustomers(List<TravelCustomer> travelCustomers) {
		this.travelCustomers = travelCustomers;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD");
		try {
			dao.add(travelCustomer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_MDY");
		try {
			dao.save(travelCustomer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_DEL");
		try {
			dao.delete(travelCustomer);
			setMessage("删除成功!ID=" + travelCustomer.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
