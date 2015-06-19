package com.qkj.manage.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.CloseOrderPosmDAO;
import com.qkj.manage.domain.CloseOrderPosm;

public class CloseOrderPosmAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CloseOrderPosmAction.class);
	private CloseOrderDAO adao = new CloseOrderDAO();
	private CloseOrderPosmDAO dao = new CloseOrderPosmDAO();

	private CloseOrderPosm closePosm;
	private String message;
	private String viewFlag;

	public CloseOrderPosm getClosePosm() {
		return closePosm;
	}

	public void setClosePosm(CloseOrderPosm closePosm) {
		this.closePosm = closePosm;
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
		//ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSM_ADD");
		try {
			closePosm.setStatus(1);
			dao.add(closePosm);
			adao.updateTotal(closePosm.getCloseOrder_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSM_DEL");
		try {
			dao.delete(closePosm);
			adao.updateTotal(closePosm.getCloseOrder_id());
			setMessage("删除成功!ID=" + closePosm.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	
}
