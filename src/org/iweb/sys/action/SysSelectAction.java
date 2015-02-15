package org.iweb.sys.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.logic.DeptLogic;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 系统选择项Action,包含部门列表/角色列表/用户列表
 * 
 * @author Kreo
 */
public class SysSelectAction extends ActionSupport {
	private static final long serialVersionUID = -3585352950575438601L;
	private static Log log = LogFactory.getLog(SysSelectAction.class);

	private Map<String, Object> map = new HashMap<String, Object>();

	private List<Department> depts;
	// dept_code为当先登录人的部门代码
	// 为空时表示以{dept_code}为起始部门,
	// 当dept_mode=0时,则代表以{dept_code的父部门}作为起始部门,如dept_code的父部门为空,则此参数无效
	private Integer dept_mode;

	// 起始部门代码,为以后集团化运营打下基础
	private String dept_code;
	private String check_code;//订单发货部门

	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public Integer getDept_mode() {
		return dept_mode;
	}

	public void setDept_mode(Integer dept_mode) {
		this.dept_mode = dept_mode;
	}

	public String getCheck_code() {
		return check_code;
	}

	public void setCheck_code(String check_code) {
		this.check_code = check_code;
	}

	public String dept_select_limit() throws Exception {
		ContextHelper.isPermit("SYS_SELECT_DEPT_LIMIT_LIST");
		Integer permitType = ContextHelper.getPermitType("SYS_SELECT_DEPT_LIMIT_LIST");
		try {
			DepartmentDAO dao = new DepartmentDAO();
			if (ContextHelper.isAdmin() || permitType == 2) {
				this.setDepts(dao.list(null));
			} else if (permitType == 1) {
				// 则只显示自己对应的下级部门及直属上级部门
				if (dept_mode == 0) { // 以{dept_code的父部门}作为起始部门
					map.clear();
					map.put("dept_code", ContextHelper.getUserLoginInfo().getDept_code());
					this.setDepts(dao.list(map));
					String p_dept = ((Department) this.getDepts().get(0)).getParent_dept();
					if (ToolsUtil.isEmpty(p_dept)) { // 如父部门为空,则还是以本身作为起始
						this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", ContextHelper
								.getUserLoginInfo().getDept_code(), 2, true));
					} else {
						this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", p_dept, 2, true));
					}
				} else { // 以自身部门为起始部门
					this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", ContextHelper
							.getUserLoginInfo().getDept_code(), 3, true));
				}
			} else if (permitType == 0) {
				map.clear();
				map.put("dept_code", ContextHelper.getUserLoginInfo().getDept_code());
				this.setDepts(dao.list(map));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!limit_dept_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!limit_dept_select 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String dept_select_all() throws Exception {
		// ContextHelper.isPermit("SYS_SELECT_DEPT_LIST");
		try {
			if (ContextHelper.checkPermit("SYS_SELECT_DEPT_LIST")) {
				DepartmentDAO dao = new DepartmentDAO();
				this.setDepts(dao.list(null));
			} else {
				return dept_permit_select();
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!all_dept_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!all_dept_select 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String dept_permit_select() throws Exception {
		ContextHelper.isPermit("GLOBAL_PRVG_DEPT_FUNCTION");
		try {
			DepartmentDAO dao = new DepartmentDAO();
			map.clear();
			if (ContextHelper.getUserLoginInfo().getPermit_depts() == null)
				map.put("dept_code", ContextHelper.getUserLoginDept()); // 能选到自己的部门
			else
				map.put("dept_codes", ContextHelper.getUserLoginPermitDepts());
			if(check_code!=null){
				map.remove("dept_code");
				map.remove("dept_codes");
			}
			this.setDepts(dao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!dept_permit_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!dept_permit_select 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
