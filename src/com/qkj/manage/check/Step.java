package com.qkj.manage.check;

import java.util.Date;

import org.iweb.sys.ContextHelper;




import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.domain.Active;

public class Step {
	private String noteflag = null;
	private Active active;
	private ActiveDAO dao = new ActiveDAO();
	
	public Active getActive() {
		return active;
	}

	public void setActive(Active active) {
		this.active = active;
	}

	public void step1(String userid){//报审
		mdyStatus(1);
		// 同时进入销售部审核流程
		mdyActiveSDStatus(10,userid);
		// 销售管理部默认为已签收
		mdyActiveSMDStatus(10,userid);
	}
	
	public void step2(String userid){//经理大区
		mdyActiveSDStatus(30,userid);
	}
	
	public void step3(String userid){//销管经理
		mdyActiveSMDStatus(30,userid);
	}
	public void step4(String userid){//总监
		mdyActiveSDStatus(40,userid);
	}
	public void step5(String userid){//销管部经理
		mdyActiveSMDStatus(40,userid);
	}
	
	public void step6(String userid){//业务副总
		mdyActiveSDStatus(50,userid);
	}
	public void step7(String userid){//销管副总
		mdyActiveSMDStatus(50,userid);
	}
	
	public void step8(String userid){//总经理
		mdyActiveSMDStatus(60,userid);
	}
	
	public void step9(String userid){//财务
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
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
	 * 结案流程开始
	 */
	public void step11(String userid){//结案报审
		mdyStatus(4);
		// 同时销售部的流程变成待审核
		mdyCloseActiveSDStatus(10);
		// 同时销管部的流程变成已签收
		mdyCloseActiveSMDStatus(10);
	}
	
	public void step12(String userid){//结案大区审
		mdyCloseActiveSDStatus(30);
	}
	
	public void step13(String userid){//结案销管经理
		mdyCloseActiveSMDStatus(30);
	}
	
	public void step14(String userid){//结案总监
		mdyCloseActiveSDStatus(40);
	}
	
	public void step15(String userid){//结案销管部经理
		mdyCloseActiveSMDStatus(40);
	}
	
	
	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyActiveSMDStatus(int smd_status,String userid) {
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
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
		active.setSmd_user(userid);
		active.setLm_user(userid);
		String note = "活动申请-销管审核状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_SMDSTATUS", note);
		return dao.mdyActiveSMDStatus(active);
	}
	
	private int mdyStatus(int status) {
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
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
	public int mdyActiveSDStatus(int sd_status,String userid) {
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
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
		active.setSd_user(userid);
		active.setLm_user(userid);
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
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
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
	
	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseActiveSDStatus(int close_sd_status) {
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
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
	public int mdyCloseActiveSMDStatus(int close_sd_status) {
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
		if (close_sd_status == 5) {
			noteflag = "退回";
		}
		if (close_sd_status == 10) {
			noteflag = "已签收";
		}
		if (close_sd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (close_sd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (close_sd_status == 50) {
			noteflag = "销管副总审核通过";
		}
		active.setClose_fd_status(0);
		active.setClose_nd_status(0);
		active.setClose_smd_status(close_sd_status);
		active.setClose_smd_time(new Date());
		active.setClose_smd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动结案-销管审核状态变更" + noteflag;
		addProcess("ACTIVE_CLOSE_SMDSTATUS", note);
		return dao.mdyCloseActiveSMDStatus(active);
	}
	
	private void addProcess(String p_sign, String p_note) {
		CheckSkip s=new CheckSkip();
		this.setActive(s.getActive());
		ProcessDAO pdao = new ProcessDAO();
		if (active != null) {
			pdao.addProcess(1, active.getUuid(), p_sign, p_note, active.getStatus(), active.getSd_status(), active.getSmd_status(), active.getClose_sd_status(),
					active.getClose_smd_status());
		}
	}
}
