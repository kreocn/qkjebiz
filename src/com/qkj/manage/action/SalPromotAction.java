package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.check.SalProCheckSkip;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.dao.SalPromotDAO;
import com.qkj.manage.domain.Approve;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.domain.SalPromot;

public class SalPromotAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(SalPromotAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private SalPromotDAO dao = new SalPromotDAO();
	private SalProCheckSkip cocs = new SalProCheckSkip();
	private ApproveDAO apdao = new ApproveDAO();

	private SalPromot salPromot;
	private List<SalPromot> salPromots;

	private Approve approve;
	private List<Approve> approves;
	private String isApprover;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String checkstatus;
	private String noteflag;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;促销活动";
	private int salstate;
	// 个人工作标识
	private String perWorkF;
	private static String perWorkFlag = null;

	private List<CloseOrder> allsigns;
	private CloseOrder sign;

	public List<CloseOrder> getAllsigns() {
		return allsigns;
	}

	public void setAllsigns(List<CloseOrder> allsigns) {
		this.allsigns = allsigns;
	}

	public CloseOrder getSign() {
		return sign;
	}

	public void setSign(CloseOrder sign) {
		this.sign = sign;
	}

	public List<Approve> getApproves() {
		return approves;
	}

	public void setApproves(List<Approve> approves) {
		this.approves = approves;
	}

	public String getIsApprover() {
		return isApprover;
	}

	public void setIsApprover(String isApprover) {
		this.isApprover = isApprover;
	}

	public Approve getApprove() {
		return approve;
	}

	public void setApprove(Approve approve) {
		this.approve = approve;
	}

	public String getPerWorkF() {
		return perWorkF;
	}

	public void setPerWorkF(String perWorkF) {
		this.perWorkF = perWorkF;
	}

	public static String getPerWorkFlag() {
		return perWorkFlag;
	}

	public static void setPerWorkFlag(String perWorkFlag) {
		SalPromotAction.perWorkFlag = perWorkFlag;
	}

	public int getSalstate() {
		return salstate;
	}

	public void setSalstate(int salstate) {
		this.salstate = salstate;
	}

	public String getPath() {
		return path;
	}

	public SalPromot getSalPromot() {
		return salPromot;
	}

	public void setSalPromot(SalPromot salPromot) {
		this.salPromot = salPromot;
	}

	public List<SalPromot> getSalPromots() {
		return salPromots;
	}

	public void setSalPromots(List<SalPromot> salPromots) {
		this.salPromots = salPromots;
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

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public String getCheckstatus() {
		return checkstatus;
	}

	public void setCheckstatus(String checkstatus) {
		this.checkstatus = checkstatus;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT");
		String code = ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (salPromot == null) salPromot = new SalPromot();
			ContextHelper.setSearchDeptPermit4Search("QKJ_SALPRO_SALPROMOT",map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_SALPRO_SALPROMOT", map, salPromot, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			/*if (ContextHelper.isAdmin()) {// 管理员

			} else {
				map.put("add_user_dept", code);
			}*/
			this.setSalPromots(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;促销活动列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		if (perWorkFlag == null || perWorkFlag.equals("null")) {
			return "success";
		} else {
			perWorkFlag = null;
			return "perSuccess";
		}
	}

	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		if ((perWorkF == null || perWorkF.equals("null")) && perWorkFlag == null) {
			perWorkFlag = null;
		} else {
			perWorkFlag = "perWork";
		}
		try {
			if (null == viewFlag) {
				this.setSalPromot(null);
				setMessage("你没有选择任何操作!");
				return "SUCCESS";
			} else if ("add".equals(viewFlag)) {
				this.setSalPromot(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;增加促销活动";
				return "SUCCESS";
			} else if ("mdy".equals(viewFlag)) {
				if (!(salPromot == null || salPromot.getUuid() == null)) {
					this.setSalPromot((SalPromot) dao.get(salPromot.getUuid()));
				} else {
					this.setSalPromot(null);
				}

				map.clear();
				map.put("int_id", salPromot.getUuid());
				map.put("approve_type", 4);
				this.setApproves(apdao.list(map));

				/* 检查当前用户是否已经审阅 */
				if (apdao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
				System.out.println(isApprover);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;增加促销活动";
				return "SUCCESS";
			} else if ("view".equals(viewFlag)) {
				if (!(salPromot == null || salPromot.getUuid() == null)) {
					this.setSalPromot((SalPromot) dao.get(salPromot.getUuid()));
				} else {
					this.setSalPromot(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;促销活动详情";
				return "VIEWSUCCESS";
			} else {
				this.setSalPromot(null);
				setMessage("无操作类型!");
				return "SUCCESS";
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}

	}

	public String view() throws Exception {
		if (!(salPromot == null || salPromot.getUuid() == null)) {
			this.setSalPromot((SalPromot) dao.get(salPromot.getUuid()));
		} else {
			this.setSalPromot(null);
		}

		map.clear();
		map.put("allsign", 1);
		map.put("biz_id", salPromot.getUuid());
		this.setAllsigns(dao.allsign(map));
		System.out.println(allsigns.size());

		this.setSign((CloseOrder) dao.sign(salPromot.getUuid()));
		path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;促销活动详情";
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_ADD");
		try {
			String adddept = salPromot.getAdd_user_dept();
			adddept = adddept.replaceAll(" ", "");
			adddept = adddept.replaceAll(",", "");
			salPromot.setAdd_user_dept(adddept);
			salPromot.setAdd_user(ContextHelper.getUserLoginUuid());
			salPromot.setAdd_time(new Date());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			if (salPromot.getPriority() == null) {
				salPromot.setPriority(0);
			}
			if (salPromot.getRebate() == null) {
				salPromot.setRebate(0.0);
			}
			salPromot.setStatus(0);
			dao.add(salPromot);
			addProcess("SALPRO_ADD", "新增活动", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_MDY");
		try {
			String adddept = salPromot.getAdd_user_dept();
			adddept = adddept.replaceAll(" ", "");
			adddept = adddept.substring(adddept.indexOf(",") + 1, adddept.length());
			salPromot.setAdd_user_dept(adddept);
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.save(salPromot);
			addProcess("SALPRO_ADD", "新增活动", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_DEL");
		try {
			dao.delete(salPromot);
			setMessage("删除成功!ID=" + salPromot.getUuid());
			addProcess("SALPRO_ADD", "新增活动", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审阅
	 * 
	 * @return
	 * @throws Exception
	 */
	public String approve() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_APPROVE");
		try {
			apdao.add(approve, 4, salPromot.getUuid());
			addProcess("SALPRO_APPROVE", "促销活动-增加一条审阅信息", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approve 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approve 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 删除审阅
	 * 
	 * @return
	 * @throws Exception
	 */
	public String approveDel() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_APPROVE");
		try {
			apdao.deleteLast(approve, 4, salPromot.getUuid());
			addProcess("SALPRO_APPROVEDEL", "促销活动-删除一条审阅信息", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String status1() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SDSTATUS1");
		try {
			/*
			 * mdyStatus(1);// 待审核
			 * // 同时进入销售部审核流程
			 * mdySDStatus(10, ContextHelper.getUserLoginUuid());
			 * // 销售管理部默认为已签收
			 * mdySMDStatus(10, ContextHelper.getUserLoginUuid());
			 */
			cocs.checkSkip(salPromot, "status1");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK5");
		try {
			mdySDStatus(5, ContextHelper.getUserLoginUuid());

			salPromot.setFd_status(0);
			salPromot.setFd_user(ContextHelper.getUserLoginUuid());
			salPromot.setFd_time(new Date());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.savefdStatus(salPromot);

			salPromot.setStatus(0);
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.saveStatus(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区经理通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SDSTATUS30");
		try {
			// mdyCloseOrderSDStatus(30,userid);
			cocs.checkSkip(salPromot, "check20");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总监通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SDSTATUS40");
		try {
			// mdyCloseOrderSDStatus(40,userid);
			cocs.checkSkip(salPromot, "check30");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SDSTATUS50");
		try {
			// mdyCloseOrderSDStatus(50,userid);
			cocs.checkSkip(salPromot, "check40");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 签收
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS0");
		try {
			mdySMDStatus(10, ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus5() throws Exception {
		try {
			mdySMDStatus(5, ContextHelper.getUserLoginUuid());

			salPromot.setFd_status(0);
			salPromot.setFd_user(ContextHelper.getUserLoginUuid());
			salPromot.setFd_time(new Date());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.savefdStatus(salPromot);

			salPromot.setStatus(0);
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.saveStatus(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售管理经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SMDSTATUS30");
		try {
			// mdyCloseOrderSMDStatus(30,userid);
			cocs.checkSkip(salPromot, "mdyCloseOrderSMDStatus10");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SMDSTATUS40");
		try {
			// mdyCloseOrderSMDStatus(40,userid);
			cocs.checkSkip(salPromot, "mdyCloseOrderSMDStatus40");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管副总已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SMDSTATUS50");
		try {
			// mdyCloseOrderSMDStatus(50,userid);
			cocs.checkSkip(salPromot, "mdyCloseOrderSMDStatus50");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCloseOrderSMDStatus60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SMDSTATUS60");
		try {
			mdySMDStatus(60, ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 董事通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCloseOrderSMDStatus70() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_SMDSTATUS70");
		try {
			mdySMDStatus(70, ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String checkfd10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_SALPRO_FDSTATUS10");
		try {
			//mdyFDStatus(10);
			//mdyStatus(2);
			cocs.checkSkip(salPromot, "checkfd10");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String checkfd5() throws Exception {
		// ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK40");
		try {
			mdyFDStatus(5);
			mdyStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 查询添加人是办事处以下还是大区以上
	 * 
	 * @return
	 * @throws Exception
	 */
	public boolean checkDept(String dept) throws Exception {
		if (dept.length() >= 5) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 改销售部审批状态通用函数
	 * 
	 * @param sd_status
	 * @return
	 * @date 2014-4-26 上午10:20:39
	 */
	public int mdySDStatus(int sd_status, String userid) {
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
		salPromot.setSd_status(sd_status);
		salPromot.setSd_time(new Date());
		salPromot.setSd_user(userid);
		salPromot.setLm_user(userid);
		salPromot.setLm_time(new Date());
		String note = "促销活动-销售审核状态变更-" + noteflag;
		addProcess("SALPRO_MDY_SDSTATUS", note, userid);
		return dao.saveSdStatus(salPromot);
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdySMDStatus(int smd_status, String userid) {
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
		salPromot.setSmd_status(smd_status);
		salPromot.setSmd_time(new Date());
		salPromot.setSmd_user(userid);
		salPromot.setLm_user(userid);
		salPromot.setLm_time(new Date());
		String note = "促销活动-销管审核状态变更-" + noteflag;
		addProcess("SALPRO_MDY_SMDSTATUS", note, userid);
		return dao.saveSmdStatus(salPromot);
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
		salPromot.setStatus(status);
		salPromot.setLm_user(ContextHelper.getUserLoginUuid());
		salPromot.setLm_time(new Date());
		String note = "促销活动状态变更-" + noteflag;
		addProcess("SALPRO_MDY_STATUS", note, ContextHelper.getUserLoginUuid());
		return dao.saveStatus(salPromot);
	}

	/**
	 * 改财务审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyFDStatus(int smd_status) {
		if (smd_status == 5) {
			noteflag = "退回";
		}
		if (smd_status == 10) {
			noteflag = "通过";
		}
		salPromot.setFd_status(smd_status);
		salPromot.setFd_user(ContextHelper.getUserLoginUuid());
		salPromot.setFd_time(new Date());

		salPromot.setLm_user(ContextHelper.getUserLoginUuid());
		salPromot.setLm_time(new Date());
		String note = "促销活动--财务状态变更-" + noteflag;
		addProcess("SALPRO_MDY_FDSTATUS", note, ContextHelper.getUserLoginUuid());
		return dao.savefdStatus(salPromot);
	}

	private void addProcess(String p_sign, String p_note, String userLogin) {
		ProcessDAO pdao = new ProcessDAO();
		if (salPromot != null) {/* 单据状态，销售状态，销管状态，财务 */
			pdao.addProcess(5, salPromot.getUuid(), p_sign, p_note, salPromot.getStatus(), salPromot.getSd_status(), salPromot.getSmd_status(), salPromot.getFd_status(), userLogin);
		}
	}

}
