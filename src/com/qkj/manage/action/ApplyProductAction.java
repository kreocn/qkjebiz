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
	private ApplyProduct apply;
	private ApplyProductDAO dao=new ApplyProductDAO();
	private static Log log = LogFactory.getLog(ApplyProductAction.class);
	private ApplyDAO adao = new ApplyDAO();

	public ApplyProduct getApply() {
		return apply;
	}

	public void setApply(ApplyProduct apply) {
		this.apply = apply;
	}

	public String add() throws Exception {
	
		try {
			apply.setStatus(1);
			dao.add(apply);
			adao.mdyActiveItPrice(apply.getApply_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
	
	public String del() throws Exception {

		try {
			dao.delete(apply);
			adao.mdyActiveItPrice(apply.getApply_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
