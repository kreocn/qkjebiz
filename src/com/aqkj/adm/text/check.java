package com.aqkj.adm.text;

import java.util.Date;

import org.iweb.sys.ContextHelper;

import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.domain.Active;

public class check {
	private String noteflag = null;
	private Active active;
	private ActiveDAO dao = new ActiveDAO();
	
	public Active getActive() {
		return active;
	}

	public void setActive(Active active) {
		this.active = active;
	}

	public void step1(){//报审
		/*mdyStatus(1);
		// 同时进入销售部审核流程
		mdyActiveSDStatus(10);
		// 销售管理部默认为已签收
		mdyActiveSMDStatus(10);*/
		System.out.println("step1");
	}
	
	public void step2(){//经理大区
		//mdyActiveSDStatus(30);
		System.out.println("step1");
	}
	
	public void step3(){//销管经理
		//mdyActiveSMDStatus(30);
		System.out.println("step3");
	}
	public void step4(){//总监
		mdyActiveSDStatus(40);
	}
	public void step5(){//销管部经理
		mdyActiveSMDStatus(40);
	}
	
	public void step6(){//业务副总
		mdyActiveSDStatus(50);
	}
	public void step7(){//销管副总
		mdyActiveSMDStatus(50);
	}
	
	public void step8(){//总经理
		mdyActiveSMDStatus(60);
	}
	
	public void step9(){//财务
		Active ac = new Active();
		active.setLm_user(ContextHelper.getUserLoginUuid());
		mdyActiveFDStatus(1, 10);
		ac = (Active) dao.get(active.getUuid());
		if (ac.getStatus() <= 2) {
			active.setStatus(2);// 申请通过执行
		}
		dao.mdyActivePass(active);
		addProcess("ACTIVE_APPLY_PASS", "活动申请通过");
	}
	
	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseActiveSDStatus(int close_sd_status) {
		if (close_sd_status == 5) {
			noteflag = "退回";
		}
		if (close_sd_status == 10) {
			noteflag = "待审核";
		}
		if (close_sd_status == 30) {
			noteflag = "大区审核通过";
		}
		if (close_sd_status == 40) {
			noteflag = "总监审核通过";
		}
		if (close_sd_status == 50) {
			noteflag = "副总审核通过";
		}
		if (close_sd_status == 50) {
			noteflag = "总经理审核通过";
		}
		active.setClose_fd_status(0);
		active.setClose_nd_status(0);
		active.setClose_sd_status(close_sd_status);
		active.setClose_sd_time(new Date());
		active.setClose_sd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动结案-销售审核状态变更-" + noteflag;
		addProcess("ACTIVE_CLOSE_SDSTATUS", note);

		return dao.mdyCloseActiveSDStatus(active);
	}
	
	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyActiveSMDStatus(int smd_status) {
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
		active.setFd_status(0);
		active.setSmd_status(smd_status);
		active.setSmd_time(new Date());
		active.setSmd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动申请-销管审核状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_SMDSTATUS", note);
		return dao.mdyActiveSMDStatus(active);
	}
	
	private int mdyStatus(int status) {
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
		active.setStatus(status);
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_STATUS", note);
		return dao.mdyActiveStatus(active);
	}
	
	/**
	 * 改销售部审批状态通用函数
	 * 
	 * @param sd_status
	 * @return
	 * @date 2014-4-26 上午10:20:39
	 */
	public int mdyActiveSDStatus(int sd_status) {
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
		active.setSd_status(sd_status);
		active.setSd_time(new Date());
		active.setSd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动申请-销售审核状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_SDSTATUS", note);
		return dao.mdyActiveSDStatus(active);
	}
	
	/**
	 * 改财务审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyActiveFDStatus(int flag, int smd_status) {
		if (flag == 1) {// 申请
			if (smd_status == 5) {
				noteflag = "退回";
			}
			if (smd_status == 10) {
				noteflag = "通过";
			}
			active.setFd_status(smd_status);
			active.setFd_user(ContextHelper.getUserLoginUuid());
			active.setFd_time(new Date());
			active.setLm_user(ContextHelper.getUserLoginUuid());
			String note = "申请--财务状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_FDSTATUS", note);
			return dao.mdyActiveFDStatus(active);
		} else if (flag == 2) {// 结案
			if (smd_status == 5) {
				noteflag = ContextHelper.getUserLoginName() + "退回";
			}
			if (smd_status == 10) {
				noteflag = ContextHelper.getUserLoginName() + "通过";
			}
			active.setClose_fd_status(smd_status);
			active.setClose_fd_user(ContextHelper.getUserLoginUuid());
			active.setClose_fd_time(new Date());
			active.setLm_user(ContextHelper.getUserLoginUuid());
			String note = "结案--财务状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_FDCSTATUS", note);
			return dao.mdyActiveFDCStatus(active);
		} else {// 数据中心
			if (smd_status == 5) {
				noteflag = "退回";
			}
			if (smd_status == 10) {
				noteflag = "通过";
			}
			active.setClose_nd_status(smd_status);
			active.setClose_nd_user(ContextHelper.getUserLoginUuid());
			active.setClose_nd_time(new Date());
			active.setLm_user(ContextHelper.getUserLoginUuid());
			String note = "结案--数据中心状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_NDCSTATUS", note);
			return dao.mdyActiveNDCStatus(active);
		}

	}
	
	private void addProcess(String p_sign, String p_note) {
		ProcessDAO pdao = new ProcessDAO();
		if (active != null) {
			pdao.addProcess(1, active.getUuid(), p_sign, p_note, active.getStatus(), active.getSd_status(), active.getSmd_status(), active.getClose_sd_status(),
					active.getClose_smd_status());
		}
	}

}
