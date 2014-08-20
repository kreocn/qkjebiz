package com.qkj.manage.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActivePosmDAO;
import com.qkj.manage.domain.ActivePosm;

public class ActivePosmAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ActivePosmAction.class);
	private ActivePosmDAO dao = new ActivePosmDAO();
	private ActiveDAO adao = new ActiveDAO();

	private ActivePosm activePosm;
	private String message;
	private String viewFlag;

	public ActivePosm getActivePosm() {
		return activePosm;
	}

	public void setActivePosm(ActivePosm activePosm) {
		this.activePosm = activePosm;
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
			activePosm.setStatus(1);
			dao.add(activePosm);
			adao.mdyActiveItPrice(activePosm.getActive_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSM_DEL");
		try {
			dao.delete(activePosm);
			adao.mdyActiveItPrice(activePosm.getActive_id());
			setMessage("删除成功!ID=" + activePosm.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String addClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSMCLOSE_ADD");
		try {
			activePosm.setStatus(2);
			dao.add(activePosm);
			adao.mdyActiveCloseItPrice(activePosm.getActive_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addClose 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!addClose 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String delClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSMCLOSE_DEL");
		try {
			dao.delete(activePosm);
			adao.mdyActiveCloseItPrice(activePosm.getActive_id());
			setMessage("删除成功!ID=" + activePosm.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!delClose 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!delClose 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
