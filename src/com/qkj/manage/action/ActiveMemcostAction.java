package com.qkj.manage.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActiveMemcostDAO;
import com.qkj.manage.domain.ActiveF;
import com.qkj.manage.domain.ActiveM;
import com.qkj.manage.domain.ActiveMemcost;

public class ActiveMemcostAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ActiveMemcostAction.class);
	private ActiveMemcostDAO dao = new ActiveMemcostDAO();
	private ActiveDAO adao = new ActiveDAO();

	private ActiveMemcost activeMemcost;
	private List<ActiveMemcost> activeMemcosts;
	private String message;
	private String viewFlag;
	private ActiveM activeM;
	private ActiveF activeF;
	
	
	public ActiveM getActiveM() {
		return activeM;
	}

	public void setActiveM(ActiveM activeM) {
		this.activeM = activeM;
	}

	public ActiveF getActiveF() {
		return activeF;
	}

	public void setActiveF(ActiveF activeF) {
		this.activeF = activeF;
	}

	public ActiveMemcost getActiveMemcost() {
		return activeMemcost;
	}

	public void setActiveMemcost(ActiveMemcost activeMemcost) {
		this.activeMemcost = activeMemcost;
	}

	public List<ActiveMemcost> getActiveMemcosts() {
		return activeMemcosts;
	}

	public void setActiveMemcosts(List<ActiveMemcost> activeMemcosts) {
		this.activeMemcosts = activeMemcosts;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEMEMCOST_ADD");
		try {
			activeMemcost.setWith_score(0);
			activeMemcost.setStatus(1);
			dao.add(activeMemcost);
			adao.mdyActiveMtPrice(activeMemcost.getActive_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEMEMCOST_DEL");
		try {
			dao.delete(activeMemcost);
			adao.mdyActiveMtPrice(activeMemcost.getActive_id());
			setMessage("删除成功!ID=" + activeMemcost.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	
	public String addClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEMEMCOSTCLOSE_ADD");
		try {
			activeMemcost.setStatus(2);
			dao.add(activeMemcost);
			adao.mdyActiveCloseMtPrice(activeMemcost.getActive_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String delClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEMEMCOSTCLOSE_DEL");
		try {
			dao.delete(activeMemcost);
			adao.mdyActiveCloseMtPrice(activeMemcost.getActive_id());
			setMessage("删除成功!ID=" + activeMemcost.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	public String saveMP() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDY");
		int state=0;
		try {
			state=activeM.getStatus();
			dao.saveM(activeM);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		if(state==1){
			return "SUCCESS";
		}else{
			return "CLOSESUCCESS";
		}
		
	}
	public String saveFP() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDY");
		int state=0;
		try {
			state=activeF.getStatus();
			dao.saveF(activeF);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		if(state==1){
			return "SUCCESS";
		}else{
			return "CLOSESUCCESS";
		}
	}
	
	public String delM() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEM_DEL");
		int state=0;
		try {
			state=activeM.getStatus();
			dao.deleteM(activeM);
			setMessage("删除成功!ID=" + activeM.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		if(state==1){
			return "SUCCESS";
		}else{
			return "CLOSESUCCESS";
		}
	}
	
	public String delF() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEF_DEL");
		int state=0;
		try {
			state=activeF.getStatus();
			dao.deleteF(activeF);
			setMessage("删除成功!ID=" + activeF.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		if(state==1){
			return "SUCCESS";
		}else{
			return "CLOSESUCCESS";
		}
	}
	
}
