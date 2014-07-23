package com.qkj.adm.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.adm.dao.LeaveDAO;
import com.qkj.adm.domain.Leave;
import com.qkj.manage.domain.Active;

public class LeaveAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(LeaveAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private LeaveDAO dao = new LeaveDAO();

	private Leave leave;
	private List<Leave> leaves;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

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
			} else if ("mdy".equals(viewFlag)) {
				if (!(leave == null || leave.getUuid() == null)) {
					this.setLeave((Leave) dao.get(leave.getUuid()));
				} else {
					this.setLeave(null);
				}
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

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_ADM_LEAVE_ADD");
		try {
			leave.setLm_user(ContextHelper.getUserLoginUuid());
			leave.setLm_time(new Date());
			dao.add(leave);
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
		return dao.check(leave);
	}

	public int acheck(int p_acheck) {
		leave.setAcheck_status(p_acheck);
		leave.setAcheck_user(ContextHelper.getUserLoginUuid());
		leave.setAcheck_time(new Date());
		leave.setLm_user(ContextHelper.getUserLoginUuid());
		leave.setLm_time(new Date());
		return dao.acheck(leave);
	}

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
}