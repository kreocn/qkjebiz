package org.iweb.sys.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.domain.Department;

import com.opensymphony.xwork2.ActionSupport;

public class DepartmentAction extends ActionSupport implements ServletRequestAware {

	private static final long serialVersionUID = 2030216096119839098L;
	private static Log log = LogFactory.getLog(DepartmentAction.class);
	private DepartmentDAO dao = new DepartmentDAO();
	private Map<String, Object> map = new HashMap<String, Object>();
	private HttpServletRequest request;

	private Department dept;
	private List<Department> depts;
	private String message;

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}

	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_DEPT_LIST");
		Integer permitType = ContextHelper.getPermitType("SYS_MANAGER_DEPT_LIST");
		try {
			if (ContextHelper.isAdmin() || permitType == 2) {
				this.setDepts(dao.list(null));
			} else if (permitType == 1) {
				// 则只显示自己对应的下级部门及直属上级部门
				this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", ContextHelper
						.getUserLoginInfo().getDept_code(), 3, true));
			} else if (permitType == 0) {
				map.clear();
				map.put("dept_code", ContextHelper.getUserLoginInfo().getDept_code());
				this.setDepts(dao.list(map));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_DEPT_ADD");
		try {
			dao.startTransaction();
			dept.setUuid(ToolsUtil.getUUID());
			dept.setLm_user(ContextHelper.getUserLoginTitle());
			dept.setLm_time(new Date());
			dao.add(dept);
			dao.commitTransaction();
			setMessage("添加成功!");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		} finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_DEPT_MDY");
		try {
			dao.startTransaction();
			dept.setLm_user(ContextHelper.getUserLoginTitle());
			dept.setLm_time(new Date());
			dao.save(dept);
			dao.commitTransaction();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 保存数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 保存数据错误:" + ToolsUtil.getStackTraceHTML(e));
		} finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_DEPT_DEL");
		try {
			dao.startTransaction();
			dao.delete(dept);
			dao.commitTransaction();
			setMessage("删除成功!ID=" + dept.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		} finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}
}
