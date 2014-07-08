package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ApplyDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.Apply;

public class ApplyAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ApplyAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ApplyDAO dao = new ApplyDAO();

	private Apply apply;
	private List<Apply> applys;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

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
			ContextHelper.setSearchDeptPermit4Search(map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_APPLY_LIST", map, apply, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map
					.get(Parameters.Current_Page_Str)).toString()));
			this.setApplys(dao.list(map));
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_VIEW");
		try {
			if (null == viewFlag) {
				this.setApply(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setApply(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(apply == null || apply.getUuid() == null)) {
					this.setApply((Apply) dao.get(apply.getUuid()));
				} else {
					this.setApply(null);
				}
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
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/* 审核流程 */
	// 状态 0:新事由 5:已退回 10:待审核 20:大区经理已审 30:运营总监已审
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
	 * 审核不通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK5");
		try {
			check(5);
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
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_DEL");
		try {
			dao.delete(apply);
			setMessage("删除成功!ID=" + apply.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
