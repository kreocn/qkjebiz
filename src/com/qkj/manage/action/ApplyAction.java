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
import com.qkj.manage.dao.ApplyDAO;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.domain.Apply;
import com.qkj.manage.domain.Approve;

public class ApplyAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ApplyAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ApplyDAO dao = new ApplyDAO();
	private ApproveDAO adao = new ApproveDAO();
	private Apply apply;
	private List<Apply> applys;
	private Approve approve;
	private List<Approve> approves;
	private String isApprover;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;至事由管理";

	public String getPath() {
		return path;
	}

	public String getIsApprover() {
		return isApprover;
	}

	public void setIsApprover(String isApprover) {
		this.isApprover = isApprover;
	}

	public List<Approve> getApproves() {
		return approves;
	}

	public void setApproves(List<Approve> approves) {
		this.approves = approves;
	}

	public Approve getApprove() {
		return approve;
	}

	public void setApprove(Approve approve) {
		this.approve = approve;
	}

	public Apply getApply() {
		return apply;
	}

	public void setApply(Apply apply) {
		this.apply = apply;
	}

	public List<Apply> getApplys() {
		return applys;
	}

	public void setApplys(List<Apply> applys) {
		this.applys = applys;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_LIST");
		try {
			map.clear();
			if (apply == null) {
				apply = new Apply();
			}

			// 特殊审核权限
			if (apply.getStatus_sp() != null) {
				if (apply.getStatus_sp() == 25) {
					apply.setSp_check_status(10);
					apply.setStatus(20);
				} else if (apply.getStatus_sp() == 20) {
					apply.setSp_check_status(0);
					apply.setStatus(apply.getStatus_sp());
				} else {
					apply.setStatus(apply.getStatus_sp());
					apply.setSp_check_status(null);
				}
			}
			ContextHelper.setSearchDeptPermit4Search(map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_APPLY_LIST", map, apply, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str)).toString()));
			this.setApplys(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;至事由列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_VIEW");
		try {
			if (null == viewFlag) {
				this.setApply(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setApply(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/apply_list?viewFlag=relist'>至事由列表</a>&nbsp;&gt;&nbsp;增加至事由";
			} else if ("mdy".equals(viewFlag)) {
				if (!(apply == null || apply.getUuid() == null)) {
					this.setApply((Apply) dao.get(apply.getUuid()));
				} else {
					this.setApply(null);
				}
				map.clear();
				map.put("int_id", apply.getUuid());
				map.put("approve_type", 0);
				this.setApproves(adao.list(map));
				/* 检查当前用户是否已经审阅 */
				if (adao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/apply_list?viewFlag=relist'>至事由列表</a>&nbsp;&gt;&nbsp;至事由详情";
			} else {
				this.setApply(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String view() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_VIEW");
		try {
			if (apply == null || apply.getUuid() == null) {
				this.setApply(null);
				setMessage("无显示数据.");
			} else {
				this.setApply((Apply) dao.get(apply.getUuid()));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!view 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!view 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_ADD");
		try {
			apply.setStatus(0);
			apply.setApply_dept(ContextHelper.getUserLoginDept());
			apply.setApply_user(ContextHelper.getUserLoginUuid());
			apply.setApply_time(new Date());
			apply.setLm_user(ContextHelper.getUserLoginUuid());
			apply.setUuid((Integer) dao.add(apply));

			addProcess("APPLY_ADD", "至事由-新增");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_MDY");
		try {
			apply.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(apply);

			addProcess("APPLY_MDY", "至事由-修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/* 审核流程 */
	// 状态 -1:已作废 0:新事由 5:已退回 10:待审核 20:大区经理已审 30:运营总监已审
	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK0");
		try {
			check(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 作废
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check_1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK_1");
		try {
			check(-1);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check_1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check_1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核不通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK5");
		try {
			check(5);
			spcheck(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String spt() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_SPT");
		try {
			check(5);
			spcheck(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	
	/**
	 * 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK10");
		try {
			check(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 运营总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK20");
		try {
			check(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check20 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check20 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 销售副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK30");
		try {
			check(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check30 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK40");
		try {
			check(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 特殊审核权限,通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String spcheck10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_SPCHECK10");
		try {
			spcheck(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!spcheck10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!spcheck10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 特殊审核权限,退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String spcheck5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_SPCHECK5");
		try {
			spcheck(5);
			// 退回时,单子同时被退回
			check(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!spcheck5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!spcheck5 数据更新失败:", e);
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_APPROVE");
		try {
			adao.add(approve, 0, apply.getUuid());
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_APPROVEDELLAST");
		try {
			adao.deleteLast(approve, 0, apply.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 修改发货信息
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyShipInfo() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDYAPPLYSHIPINFO");
		try {
			dao.mdyShipInfo(apply);
			addProcess("APPLY_CHANGE_STATUS", "至事由-出货状态更改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 状态更改通用函数
	 * 
	 * @param p_status
	 */
	public void check(int p_status) {
		apply.setStatus(p_status);
		apply.setCheck_user(ContextHelper.getUserLoginUuid());
		apply.setCheck_time(new Date());
		apply.setLm_user(ContextHelper.getUserLoginUuid());
		dao.check(apply);
		addProcess("APPLY_CHANGE_STATUS", "至事由-状态更改");
	}

	/**
	 * 状态更改通用函数
	 * 
	 * @param p_status
	 */
	public void spcheck(int p_sp_check_status) {
		apply.setSp_check_status(p_sp_check_status);
		apply.setSp_check_user(ContextHelper.getUserLoginUuid());
		apply.setSp_check_time(new Date());
		if(p_sp_check_status==10){
			apply.setStatus(20);
			apply.setCheck_user(ContextHelper.getUserLoginUuid());
			apply.setCheck_time(new Date());
			apply.setLm_user(ContextHelper.getUserLoginUuid());
		}
		dao.spcheck(apply);
		addProcess("APPLY_CHANGE_SPSTATUS", "至事由-特别状态更改");
	}

	private void addProcess(String p_sign, String p_note) {
		ProcessDAO pdao = new ProcessDAO();
		if (apply != null) {
			pdao.addProcess(2, apply.getUuid(), p_sign, p_note, apply.getStatus(), apply.getSp_check_status(), apply.getShip_status());
		}
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_DEL");
		try {
			dao.delete(apply);
			addProcess("APPLY_DEL", "至事由-删除");
			setMessage("删除成功!ID=" + apply.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
