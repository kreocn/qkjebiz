package com.qkj.manage.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ApplyDAO;
import com.qkj.manage.dao.ApplyProductDAO;
import com.qkj.manage.domain.ActiveProduct;
import com.qkj.manage.domain.ApplyProduct;

public class ApplyProductAction  extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ApplyProduct applyProduct;
	private ApplyProductDAO dao=new ApplyProductDAO();
	private static Log log = LogFactory.getLog(ApplyProductAction.class);
	private ApplyDAO adao = new ApplyDAO();
	public ApplyProduct getApplyProduct() {
		return applyProduct;
	}
	public void setApplyProduct(ApplyProduct applyProduct) {
		this.applyProduct = applyProduct;
	}
	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD");
		try {
			applyProduct.setStatus(1);
			dao.add(applyProduct);
			adao.mdyActiveItPrice(applyProduct.getApply_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
	
	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL");
		try {
			dao.delete(applyProduct);
			adao.mdyActiveItPrice(applyProduct.getApply_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
