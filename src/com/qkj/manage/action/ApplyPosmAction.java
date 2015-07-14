package com.qkj.manage.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActivePosmDAO;
import com.qkj.manage.dao.ApplyDAO;
import com.qkj.manage.dao.ApplyPosmDAO;
import com.qkj.manage.domain.ActivePosm;
import com.qkj.manage.domain.ApplyPosm;

public class ApplyPosmAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ApplyPosmAction.class);
	private ApplyPosmDAO dao = new ApplyPosmDAO();

  
	private ApplyPosm applyPosm;
	private String message;
	private String viewFlag;
	private ApplyDAO adao = new ApplyDAO();
	

	public ApplyPosm getApplyPosm() {
		return applyPosm;
	}

	public void setApplyPosm(ApplyPosm applyPosm) {
		this.applyPosm = applyPosm;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSM_ADD");
		try {
			applyPosm.setStatus(1);
			dao.add(applyPosm);
			adao.mdyActiveItPrice(applyPosm.getApply_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
	
	public String del() throws Exception {
		
		try {
			dao.delete(applyPosm);
			adao.mdyActiveItPrice(applyPosm.getApply_id());
			setMessage("删除成功!ID=" + applyPosm.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
}
