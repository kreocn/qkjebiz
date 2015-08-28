package com.qkj.manage.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.CloseOrderMemcostDAO;
import com.qkj.manage.domain.CloseOrderMemcost;

public class CloseOrderMemcostAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CloseOrderMemcostAction.class);
	private CloseOrderMemcostDAO dao = new CloseOrderMemcostDAO();
	private CloseOrderDAO adao = new CloseOrderDAO();

	private CloseOrderMemcost closeOrderMemcost;
	private List<CloseOrderMemcost> closeOrderMemcosts;
	private String message;
	private String viewFlag;

	public CloseOrderMemcost getCloseOrderMemcost() {
		return closeOrderMemcost;
	}

	public void setCloseOrderMemcost(CloseOrderMemcost closeOrderMemcost) {
		this.closeOrderMemcost = closeOrderMemcost;
	}

	public List<CloseOrderMemcost> getCloseOrderMemcosts() {
		return closeOrderMemcosts;
	}

	public void setCloseOrderMemcosts(List<CloseOrderMemcost> closeOrderMemcosts) {
		this.closeOrderMemcosts = closeOrderMemcosts;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_CloseOrderMEMCOST_ADD");
		try {
			closeOrderMemcost.setWith_score(0);
			closeOrderMemcost.setStatus(1);
			dao.add(closeOrderMemcost);
			adao.mdyCloseOrderMtPrice(closeOrderMemcost.getClose_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CloseOrderMEMCOST_DEL");
		try {
			dao.delete(closeOrderMemcost);
			adao.mdyCloseOrderMtPrice(closeOrderMemcost.getClose_id());
			setMessage("删除成功!ID=" + closeOrderMemcost.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

}
