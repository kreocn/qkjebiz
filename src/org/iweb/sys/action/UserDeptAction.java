package org.iweb.sys.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.dao.PositionDAO;
import org.iweb.sys.dao.UserDeptDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.Position;
import org.iweb.sys.domain.User;
import org.iweb.sys.domain.UserDept;
import org.iweb.sys.domain.UserRole;

import com.opensymphony.xwork2.ActionSupport;

public class UserDeptAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(UserAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private UserDeptDAO dao = new UserDeptDAO();
	private DepartmentDAO dao2 = new DepartmentDAO();
	private UserRoleDAO dao3 = new UserRoleDAO();

	private List<UserDept> userDepts;
	private UserDept userDept;
	private List<Position> positions;
	private List<UserRole> roles;
	private List<UserRole> userRoles;
	private String[] uroles;
	private List<Department> depts;
	private User user;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;用户权限信息";

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

	public String[] getUroles() {
		return uroles;
	}

	public void setUroles(String[] uroles) {
		this.uroles = uroles;
	}

	public List<UserRole> getRoles() {
		return roles;
	}

	public void setRoles(List<UserRole> roles) {
		this.roles = roles;
	}

	public List<UserRole> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(List<UserRole> userRoles) {
		this.userRoles = userRoles;
	}

	public List<Position> getPositions() {
		return positions;
	}

	public void setPositions(List<Position> positions) {
		this.positions = positions;
	}

	public List<UserDept> getUserDepts() {
		return userDepts;
	}

	public void setUserDepts(List<UserDept> userDepts) {
		this.userDepts = userDepts;
	}

	public UserDept getUserDept() {
		return userDept;
	}

	public void setUserDept(UserDept userDept) {
		this.userDept = userDept;
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

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String list() throws Exception {
		try {
			map.clear();
			if (userDept == null) {
				userDept = new UserDept();
			}
			map.putAll(ToolsUtil.getMapByBean(userDept));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setUserDepts(dao.list(map));
			this.setRecCount(dao.getResultCount());
			//path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;用户权限信息";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setUserDept(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setUserDept(null);
				this.setUserDepts(null);
				this.setUserRoles(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", userDept.getUuid());
				this.setUserDept((UserDept) dao.get(userDept.getUuid()));
				
				if (!ToolsUtil.isEmpty(userDept.getRoles())) {
					uroles = userDept.getRoles().split(",");
				}

				if (!ToolsUtil.isEmpty(userDept.getRoles())) {
					map.clear();
					map.put("roles", userDept.getRoles().split(","));
					this.setUserRoles(dao3.listSysRole(map));
				} else {
					this.setUserRoles(null);
				}
			} else {
				this.setUserDept(null);
				setMessage("无操作类型!");
			}
			
			// 得到用户拥有的角色

						if (ContextHelper.isAdmin() || ContextHelper.checkPermit("SYS_MANAGER_ROLE_LISTALL")) { // 如果是超级管理员
							// 可以选到所有的部门
							this.setDepts(dao2.list(null));
							// 可以选到所有的角色
							this.setRoles(dao3.listSysRole(null));
						} else {
							this.setDepts(ToolsUtil.getTreeNode(dao2.list(null), "dept_code", "parent_dept", ContextHelper.getUserLoginInfo().getDept_code(), 2, true));
							// 只能选到自己的角色
							this.setRoles(ContextHelper.getUserLoginInfo().getUser_roles_list());
						}

						if ("mdy".equals(viewFlag)) {
							this.removeExistRoles(this.getRoles(), this.getUserRoles());
						}
			PositionDAO pdao = new PositionDAO();
			this.setPositions(pdao.list(null));

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		try {
			userDept.setLm_time(new Date());
			userDept.setRoles(ToolsUtil.Array2String(uroles == null ? new String[] {} : uroles, ","));
			dao.add(userDept);
		} catch (Exception e) {
			// setMessage("数据更新失败!" + e.getMessage());
			log.error(this.getClass().getName() + "!add 数据添加失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		try {
			userDept.setLm_time(new Date());
			userDept.setRoles(ToolsUtil.Array2String(uroles == null ? new String[] {} : uroles, ","));
			dao.save(userDept);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		try {
			dao.delete(userDept);
			setMessage("删除成功!ID=" + userDept.getUuid());
			user=new User();
			user.setUuid(userDept.getUser_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}
	
	/**
	 * 去除已经拥有的roles
	 * 
	 * @param l_roles
	 *            列表
	 * @param e_roles
	 *            需要去除的roles
	 * @date 2014-4-22 下午10:28:09
	 */
	private void removeExistRoles(List<UserRole> l_roles, List<UserRole> e_roles) {
		if (l_roles != null && e_roles != null) {
			List<UserRole> d_roles = new ArrayList<>();
			for (UserRole u1 : l_roles) {
				for (UserRole u2 : e_roles) {
					if (u1.getUuid().equals(u2.getUuid())) {
						d_roles.add(u1);
					}
				}
			}
			l_roles.removeAll(d_roles);
			d_roles.clear();
		}
	}

}
