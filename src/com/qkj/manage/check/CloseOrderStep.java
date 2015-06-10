package com.qkj.manage.check;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.ContextHelper;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.MemberCapital;

import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActiveMemcostDAO;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.ActiveMemcost;
import com.qkj.manage.domain.CloseOrder;

public class CloseOrderStep {
	private String noteflag;
	private CloseOrder closeOrder;
	private CloseOrderDAO dao = new CloseOrderDAO();

	public CloseOrder getCloseOrder() {
		return closeOrder;
	}

	public void setCloseOrder(CloseOrder closeOrder) {
		this.closeOrder = closeOrder;
	}

	/**
	 * 大区经理通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public void check20(String userid) throws Exception {
		mdyCloseOrderSDStatus(30, userid);
	}

	/**
	 * 总监通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public void check30(String userid) throws Exception {
		mdyCloseOrderSDStatus(40, userid);
	}

	/**
	 * 业务副总通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public void check40(String userid) throws Exception {
		mdyCloseOrderSDStatus(50, userid);
	}

	/**
	 * 销售管理经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public void mdyCloseOrderSMDStatus10(String userid) throws Exception {
		mdyCloseOrderSMDStatus(30, userid);
	}

	/**
	 * 销管部经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public void mdyCloseOrderSMDStatus40(String userid) throws Exception {
		mdyCloseOrderSMDStatus(40, userid);
	}

	/**
	 * 销管副总已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public void mdyCloseOrderSMDStatus50(String userid) throws Exception {
		mdyCloseOrderSMDStatus(50, userid);
	}

	/**
	 * 总经理通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public void check60(String userid) throws Exception {
		mdyCloseOrderSMDStatus(60, userid);
	}

	/**
	 * 改销售部审批状态通用函数
	 * 
	 * @param sd_status
	 * @return
	 * @date 2014-4-26 上午10:20:39
	 */
	public int mdyCloseOrderSDStatus(int sd_status, String userid) {
		CloseOrderCheckSkip s=new CloseOrderCheckSkip();
		this.setCloseOrder(s.getCloserOrder());
		if (sd_status == 5) {
			noteflag = "退回";
		}
		if (sd_status == 10) {
			noteflag = "待审核";
		}
		if (sd_status == 30) {
			noteflag = "大区审核通过";
		}
		if (sd_status == 40) {
			noteflag = "总监审核通过";
		}
		if (sd_status == 50) {
			noteflag = "副总审核通过";
		}
		if (sd_status == 50) {
			noteflag = "总经理审核通过";
		}
		closeOrder.setSd_state(sd_status);
		closeOrder.setSd_time(new Date());
		closeOrder.setSd_user(userid);
		closeOrder.setLm_user(userid);
		closeOrder.setLm_time(new Date());
		String note = "提货结案单-销售审核状态变更-" + noteflag;
		addProcess("CLOSEORDER_MDY_SDSTATUS", note, userid);
		return dao.mdyCloseOrderSDStatus(closeOrder);
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseOrderSMDStatus(int smd_status,String userid) {
		CloseOrderCheckSkip s=new CloseOrderCheckSkip();
		this.setCloseOrder(s.getCloserOrder());
		if (smd_status == 5) {
			noteflag = "退回";
		}
		if (smd_status == 10) {
			noteflag = "已签收";
		}
		if (smd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (smd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (smd_status == 50) {
			noteflag = "销管副总审核通过";
		}
		closeOrder.setSmd_status(smd_status);
		closeOrder.setSmd_time(new Date());
		closeOrder.setSmd_user(userid);
		closeOrder.setLm_user(userid);
		closeOrder.setLm_time(new Date());
		String note = "提货结案单-销管审核状态变更-" + noteflag;
		addProcess("CLOSEORDER_MDY_SMDSTATUS", note,userid);
		return dao.mdyCloseOrderSMDStatus(closeOrder);
	}

	private int mdyStatus(int status) {
		CloseOrderCheckSkip s=new CloseOrderCheckSkip();
		this.setCloseOrder(s.getCloserOrder());
		if (status == -1) {
			noteflag = "作废";
		}
		if (status == 0) {
			noteflag = "新申请";
		}
		if (status == 1) {
			noteflag = "申请审批中";
		}
		if (status == 2) {
			noteflag = "申请通过-可以执行";
		}
		if (status == 3) {
			noteflag = "开始结案";
		}
		if (status == 4) {
			noteflag = "结案审批中";
		}
		if (status == 5) {
			noteflag = "结案通过";
		}
		closeOrder.setState(status);
		closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
		closeOrder.setLm_time(new Date());
		String note = "提货结案单状态变更-" + noteflag;
		addProcess("CLOSEORDER_MDY_STATUS", note, ContextHelper.getUserLoginUuid());
		return dao.mdyCloseOrderStatus(closeOrder);
	}

	private void addProcess(String p_sign, String p_note, String userLogin) {
		ProcessDAO pdao = new ProcessDAO();
		if (closeOrder != null) {/* 单据状态，销售状态，销管状态，财务，数据中心 */
			pdao.addProcess(4, closeOrder.getUuid(), p_sign, p_note, closeOrder.getState(), closeOrder.getSd_state(), closeOrder.getSmd_status(), closeOrder.getFd_check_state(),
					closeOrder.getNd_check_state(), userLogin);
		}
	}
}
