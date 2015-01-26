package org.iweb.sys.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.IWebConfig;
import org.iweb.sys.MD5Plus;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.dao.PositionDAO;
import org.iweb.sys.dao.UserDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.Position;
import org.iweb.sys.domain.User;
import org.iweb.sys.domain.UserRole;
import org.iweb.sys.exception.PermitException;

import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(UserAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private UserDAO dao = new UserDAO();
	private DepartmentDAO dao2 = new DepartmentDAO();
	private UserRoleDAO dao3 = new UserRoleDAO();

	private User user;
	private List<User> users;
	private List<Department> depts;
	private List<UserRole> roles;
	private List<Position> positions;
	private List<UserRole> userRoles;

	//
	private String[] uroles;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	private String ajaxResult;

	private boolean overSub;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;用户信息";
	
	public String getPath() {
		return path;
	}

	public String[] getUroles() {
		return uroles;
	}

	public void setUroles(String[] uroles) {
		this.uroles = uroles;
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

	public String getAjaxResult() {
		return ajaxResult;
	}

	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

	public List<UserRole> getRoles() {
		return roles;
	}

	public void setRoles(List<UserRole> roles) {
		this.roles = roles;
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

	public boolean isOverSub() {
		return overSub;
	}

	public void setOverSub(boolean overSub) {
		this.overSub = overSub;
	}

	public void validate() {
	}

	public String list() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_LIST");
		try {
			map.clear();
			if (user == null) {
				user = new User();
			}
			if (!ToolsUtil.isEmpty(user.getTitle())) {
				user.setTitle(user.getTitle().toLowerCase());
			}
			map.putAll(ToolsUtil.getMapByBean(user));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setUsers(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;客户信息";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setUser(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setUser(null);
				this.setUserRoles(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", user.getUuid());
				this.setUser((User) dao.get(user.getUuid()));

				if (!ToolsUtil.isEmpty(user.getUser_roles())) {
					uroles = user.getUser_roles().split(",");
				}

				if (!ToolsUtil.isEmpty(user.getUser_roles())) {
					map.clear();
					map.put("roles", user.getUser_roles().split(","));
					this.setUserRoles(dao3.listSysRole(map));
				} else {
					this.setUserRoles(null);
				}

			} else {
				this.setUser(null);
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

	public String iload() throws Exception {
		ContextHelper.isPermit("LOGING_USER_CONFIG_INFO_LOAD");
		try {
			map.clear();
			map.put("uuid", ContextHelper.getUserLoginInfo().getUuid());
			if (null == map.get("uuid")) {
				this.setUser(null);
				this.setRoles(dao3.listSysRole(null));
			} else {
				this.setUser((User) dao.list(map).get(0));
				this.setRoles(ContextHelper.getUserLoginInfo().getUser_roles_list());
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String isave() throws Exception {
		ContextHelper.isPermit("LOGING_USER_CONFIG_INFO_SAVE");
		try {
			user.setLm_user(ContextHelper.getUserLoginTitle());
			user.setTitle(ContextHelper.getUserLoginTitle());
			user.setLm_time(new Date());
			dao.isave(user);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!isave 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!isave 数据更新失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_ADD");
		try {
			user.setUuid(ToolsUtil.getUUID());
			// 统一小写
			user.setTitle(user.getTitle().toLowerCase());
			user.setPasswords("true".equals(IWebConfig.getConfigMap().get("isPasswordEncrypt")) ? MD5Plus.encrypt(user.getPasswords()) : user.getPasswords());
			user.setReg_time(new Date());
			user.setLm_user(ContextHelper.getUserLoginTitle());
			user.setLm_time(new Date());
			user.setStatus(1);
			user.setUser_roles(ToolsUtil.Array2String(uroles == null ? new String[] {} : uroles, ","));
			dao.add(user);
		} catch (Exception e) {
			// setMessage("数据更新失败!" + e.getMessage());
			log.error(this.getClass().getName() + "!add 数据添加失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_MDY");
		if (user.getTitle().equals(IWebConfig.getConfigMap().get("defaultAdministrator")) && !ContextHelper.isAdmin()) { throw new PermitException("你没有权限修改超级管理员帐户!"); }
		try {
			user.setUser_roles(ToolsUtil.Array2String(uroles == null ? new String[] {} : uroles, ","));
			user.setLm_user(ContextHelper.getUserLoginTitle());
			user.setLm_time(new Date());
			dao.save(user);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_DEL");
		try {
			dao.delete(user);
			setMessage("删除成功!ID=" + user.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String changePWD() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_PWD_MDY");
		if (user.getTitle().equals(IWebConfig.getConfigMap().get("defaultAdministrator")) && !ContextHelper.isAdmin()) { throw new PermitException("你没有权限修改超级管理员帐户!"); }
		try {
			map.clear();
			String new_passwords = ContextHelper.getRequest().getParameter("new_passwords");
			String new_passwords2 = ContextHelper.getRequest().getParameter("new_passwords2");

			map.put("uuid", user.getUuid());
			map.put("title", user.getTitle());
			users = dao.list(map);
			if (users.size() == 1) {
				user = users.get(0);
				if (new_passwords.equals(new_passwords2)) {
					user.setPasswords("true".equals(IWebConfig.getConfigMap().get("isPasswordEncrypt")) ? MD5Plus.encrypt(new_passwords) : new_passwords);
					user.setLm_user(ContextHelper.getUserLoginTitle());
					user.setLm_time(new Date());
					dao.changePWD(user);
				} else {
					setMessage("两次密码输入不一致!");
				}
			} else {
				setMessage("未知错误!请按照正规操作途径修改密码!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!changePWD 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!changePWD 数据删除失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String ichangePWD() throws Exception {
		ContextHelper.isPermit("LOGING_USER_CONFIG_INFO_CPWD");
		try {
			map.clear();
			String old_passwords = ContextHelper.getRequest().getParameter("old_passwords");
			String new_passwords = ContextHelper.getRequest().getParameter("new_passwords");
			String new_passwords2 = ContextHelper.getRequest().getParameter("new_passwords2");

			map.put("uuid", user.getUuid());
			map.put("title", user.getTitle());
			users = dao.list(map);
			if (users.size() == 1) {
				user = users.get(0);
				if (new_passwords.equals(new_passwords2)) {
					if ("true".equals(IWebConfig.getConfigMap().get("isPasswordEncrypt")) ? MD5Plus.compare(old_passwords, this.getUser().getPasswords()) : old_passwords
							.equals(this.getUser().getPasswords())) {
						user.setPasswords("true".equals(IWebConfig.getConfigMap().get("isPasswordEncrypt")) ? MD5Plus.encrypt(new_passwords) : new_passwords);
						user.setLm_user(ContextHelper.getUserLoginTitle());
						user.setLm_time(new Date());
						dao.changePWD(user);
					} else {
						System.out.println("原密码输入有误!");
						setMessage("原密码输入有误!");
					}
				} else {
					System.out.println("两次密码输入不一致!");
					setMessage("两次密码输入不一致!");
				}
			} else {
				setMessage("未知错误!请按照正规操作途径修改密码!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!changePWD 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!changePWD 数据删除失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	/**
	 * 无权限控制,可做成通用模块
	 * 
	 * @return
	 * @throws Exception
	 */
	public String memberCheck() throws Exception {
		User u = new User();
		if ("title_check".equals(viewFlag)) {
			u.setTitle(user.getTitle());
		} else if ("mobile_check".equals(viewFlag)) {
			u.setMobile(user.getMobile());
		} else if ("email_check".equals(viewFlag)) {
			u.setEmail(user.getEmail());
		}
		this.setAjaxResult(((Integer) dao.checkMember(u)).toString());
		return SUCCESS;
	}
}
