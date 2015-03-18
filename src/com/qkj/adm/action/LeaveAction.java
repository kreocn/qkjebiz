package com.qkj.adm.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.adm.dao.LeaveDAO;
import com.qkj.adm.domain.Leave;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.domain.Approve;

public class LeaveAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(LeaveAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private LeaveDAO dao = new LeaveDAO();
	private ApproveDAO apdao = new ApproveDAO();

	private Leave leave;
	private List<Leave> leaves;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	private Approve approve;
	private List<Approve> approves;
	private String isApprover;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;工时管理";

	public String getPath() {
		return path;
	}

	public Leave getLeave() {
		return leave;
	}

	public void setLeave(Leave leave) {
		this.leave = leave;
	}

	public List<Leave> getLeaves() {
		return leaves;
	}

	public void setLeaves(List<Leave> leaves) {
		this.leaves = leaves;
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

	public Approve getApprove() {
		return approve;
	}

	public void setApprove(Approve approve) {
		this.approve = approve;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_LIST");
		try {
			map.clear();
			if (leave == null) leave = new Leave();
			ContextHelper.setSearchDeptPermit4Search(map, "leave_depts", "leave_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_ADM_LEAVE_LIST", map, leave, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setLeaves(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;工时申请单列表";
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
		try {
			if (null == viewFlag) {
				this.setLeave(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				leave.setLeave_dept(ContextHelper.getUserLoginDept());
				leave.setLeave_dept_name(ContextHelper.getUserLoginDeptName());
				leave.setLeave_user(ContextHelper.getUserLoginUuid());
				leave.setLeave_user_name(ContextHelper.getUserLoginName());
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/leave_list?viewFlag=relist'>工时列表</a>&nbsp;&gt;&nbsp;添加申请单";
			} else if ("mdy".equals(viewFlag)) {
				if (!(leave == null || leave.getUuid() == null)) {
					this.setLeave((Leave) dao.get(leave.getUuid()));
				} else {
					this.setLeave(null);
				}

				map.clear();
				map.put("int_id", leave.getUuid());
				map.put("approve_type", 2);
				this.setApproves(apdao.list(map));

				/* 检查当前用户是否已经审阅 */
				if (apdao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/adm/leave_list?viewFlag=relist'>工时列表</a>&nbsp;&gt;&nbsp;修改申请单";
			} else {
				this.setLeave(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String print() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE");
		try {
			if (!(leave == null || leave.getUuid() == null)) {
				this.setLeave((Leave) dao.get(leave.getUuid()));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!print 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!print 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ADD");
		try {
			leave.setLm_user(ContextHelper.getUserLoginUuid());
			leave.setLm_time(new Date());
			leave.setUuid((Integer) dao.add(leave));
			addProcess("LEAVE_ADD", "工时-新增");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_MDY");
		try {
			leave.setLm_user(ContextHelper.getUserLoginUuid());
			leave.setLm_time(new Date());
			dao.save(leave);
			addProcess("LEAVE_MDY", "工时-修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_DEL");
		try {
			dao.delete(leave);
			setMessage("删除成功!ID=" + leave.getUuid());
			addProcess("LEAVE_DEL", "工时-删除");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/* 审核状态 0 新单 5退回 10待审核 20大区经理已审 30运营总监已审 40业务副总已审 */
	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check0() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_CHECK0");
		try {
			check(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 已受理
	 * 
	 * @return
	 * @throws Exception
	 */
	public String acheck8() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ACHECK8");
		try {
			acheck(8);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!acheck8 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!acheck0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 省外请假单需过办事处经理审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check9() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_CHECK9");
		try {
			// 只有省外运营中心的出差申请单才需要办事处经理审核
			if (leave.getLeave_type() == 0 && leave.getLeave_dept().startsWith("211")) check(15);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check9 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check9 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区经理审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check10() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_CHECK10");
		try {
			check(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 运营总监审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check20() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_CHECK20");
		try {
			check(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check20 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check20 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check30() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_CHECK30");
		try {
			check(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String acheck0() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ACHECK0");
		try {
			acheck(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!acheck0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!acheck0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政副总审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String acheck10() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ACHECK10");
		try {
			acheck(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!acheck10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!acheck10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核
	 * 
	 * @return
	 * @throws Exception
	 */
	public String acheck20() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ACHECK20");
		try {
			acheck(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!acheck20 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!acheck20 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_CHECK5");
		try {
			check(5);
			acheck(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public int check(int p_check) {
		leave.setCheck_status(p_check);
		leave.setCheck_user(ContextHelper.getUserLoginUuid());
		leave.setCheck_time(new Date());
		leave.setLm_user(ContextHelper.getUserLoginUuid());
		leave.setLm_time(new Date());
		addProcess("LEAVE_STATUS_CHANGE", "工时-业务审核状态变更");
		return dao.check(leave);
	}

	public int acheck(int p_acheck) {
		leave.setAcheck_status(p_acheck);
		leave.setAcheck_user(ContextHelper.getUserLoginUuid());
		leave.setAcheck_time(new Date());
		leave.setLm_user(ContextHelper.getUserLoginUuid());
		leave.setLm_time(new Date());
		addProcess("LEAVE_ADMSTATUS_CHANGE", "工时-行政审核状态变更");
		return dao.acheck(leave);
	}

	private void addProcess(String p_sign, String p_note) {
		ProcessDAO pdao = new ProcessDAO();
		if (leave != null) {
			pdao.addProcess(3, leave.getUuid(), p_sign, p_note, leave.getCheck_status(), leave.getAcheck_status());
		}
	}

	/**
	 * 补偿标记管理
	 * 
	 * @return
	 * @throws Exception
	 */
	public String allowance() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ALLOWANCE");
		try {
			leave.setAllowance_date(new Date());
			leave.setLm_user(ContextHelper.getUserLoginUuid());
			leave.setLm_time(new Date());
			dao.allowance(leave);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!allowance 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!allowance 数据更新失败:", e);
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
		ContextHelper.isPermit("QKJ_ADM_LEAVE_APPROVE");
		try {
			apdao.add(approve, 2, leave.getUuid());
			addProcess("LEAVE_APPROVE", "工时-增加一条审阅信息");
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
		ContextHelper.isPermit("QKJ_ADM_LEAVE_APPROVEDELLAST");
		try {
			apdao.deleteLast(approve, 2, leave.getUuid());
			addProcess("LEAVE_APPROVEDEL", "工时-删除一条审阅信息");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
