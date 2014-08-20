package org.iweb.sys.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.IWebConfig;
import org.iweb.sys.MD5Plus;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.RolePrvg;
import org.iweb.sys.domain.User;
import org.iweb.sys.domain.UserLoginInfo;
import org.iweb.sys.logic.DeptLogic;

import com.opensymphony.xwork2.ActionSupport;

public class UserLoginAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(UserLoginAction.class);
	private User user;
	private Map<String, Object> map = new HashMap<String, Object>();
	private UserDAO dao = new UserDAO();

	private String message;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public void validate() {
		if ("true".equals(IWebConfig.getConfigMap().get("isCheckLoginRand"))
				&& !ContextHelper.getRequest().getParameter("rand")
						.equals(ContextHelper.getRequest().getSession().getAttribute("rand"))) {
			this.setMessage("验证码输入错误!");
			addFieldError("rand", "验证码输入错误!");
		}
	}

	/**
	 * 系统用户专用
	 * 
	 * @return
	 * @throws Exception
	 */
	public String checkLogin() throws Exception {
		map.clear();
		if (user != null && user.getTitle() != null) {
			user.setStatus(1); // 管理员登录验证
			map.putAll(ToolsUtil.getMapByBean(user));
			// map.put("title", user.getTitle());
			String r_passwords = this.getUser().getPasswords();
			List l = dao.listCheck(map);
			if (l.size() == 1) {
				this.setUser((User) l.get(0));
				if ("true".equals(IWebConfig.getConfigMap().get("isPasswordEncrypt")) ? MD5Plus.compare(r_passwords,
						this.getUser().getPasswords()) : r_passwords.equals(this.getUser().getPasswords())) {
					setUserLoginInfo(user, 0);
					this.setMessage("Login Successful");
					return SUCCESS;
				}
			} else if (l.size() == 0) {
				this.setMessage("用户名不存在!");
			} else {
				this.setMessage("用户异常,请尽快和管理员联系,以免发生损失!");
			}
		} else {
			this.setMessage("用户名或密码错误!");
		}
		return INPUT;
	}

	public String logout() throws Exception {
		ContextHelper.Logout();
		setMessage("已安全退出系统");
		return SUCCESS;
	}

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}

	/**
	 * 设置登录Session
	 * 
	 * @param user
	 * @param login_type
	 *            0代表系统用户session 1代表会员中心session
	 */
	private void setUserLoginInfo(User user, int login_type) {
		UserLoginInfo ulf = new UserLoginInfo();
		ulf.setUuid(user.getUuid());
		ulf.setTitle(user.getTitle());
		ulf.setKeys(user.getUkeys());
		ulf.setDept_code(user.getDept_code());
		ulf.setUser_roles(user.getUser_roles());
		ulf.setUser_type(user.getUser_type());
		ulf.setExtra_prvg(user.getExtra_prvg());
		ulf.setWork_id(user.getWork_id());
		ulf.setUser_name(user.getUser_name());

		ulf.setSex(user.getSex());
		ulf.setEmail(user.getEmail());
		ulf.setIs_email_check(user.getIs_email_check());
		ulf.setPhone(user.getPhone());
		ulf.setMobile(user.getMobile());
		ulf.setIs_mobile_check(user.getIs_mobile_check());

		ulf.setPosition(user.getPosition());
		ulf.setPosition_name(user.getPosition_name());
		ulf.setDescriptions(user.getDescriptions());
		ulf.setStatus(user.getStatus());
		ulf.setFilesystem_root(user.getFilesystem_root());
		ulf.setUser_sign(user.getUser_sign());
		ulf.setLm_time(user.getLm_time());
		ulf.setLm_user(user.getLm_user());

		ulf.setSenior_name(user.getSenior_name());

		ulf.setOrg_name("");
		ulf.setDept_cname(user.getDept_cname());

		try {
			switch (ulf.getSex()) {
			case 0:
				ulf.setSex_name("保密");
				break;
			case 1:
				ulf.setSex_name("男");
				break;
			case 2:
				ulf.setSex_name("女");
				break;
			default:
				break;
			}
		} catch (Exception e) {
			ulf.setSex_name("保密");
		}

		try {
			switch (ulf.getStatus()) {
			case 0:
				ulf.setStatus_name("会员");
				break;
			case 1:
				ulf.setStatus_name("系统管理员");
				break;
			case -1:
				ulf.setStatus_name("冻结");
				break;
			default:
				break;
			}
		} catch (Exception e) {
			ulf.setStatus_name("");
		}

		HashMap<String, Object> map = new HashMap<String, Object>();

		if (!ToolsUtil.isEmpty(ulf.getUser_roles())) {
			{// 设置角色列表
				map.clear();
				try {
					map.put("roles", ulf.getUser_roles().split(","));
					if (login_type == 0) {
						ulf.setUser_roles_list((new UserRoleDAO()).listSysRole(map));
					} else if (login_type == 1) {
						ulf.setUser_roles_list((new UserRoleDAO()).listUserRole(map));
					} else {
						ulf.setUser_roles_list(null);
					}
				} catch (Exception e) {
					ulf.setUser_roles_list(null);
				}
			}

			{// 设置权限列表-系统角色列表
				map.clear();
				List<RolePrvg> role_p_list;
				if (ulf.getUser_roles_list() == null || ulf.getUser_roles_list().size() == 0) {
					ulf.setUser_prvg_map(null);
				} else {
					HashMap<String, Integer> p_map = new HashMap<String, Integer>();
					HashMap<String, String> f_map = new HashMap<String, String>();
					String[] roles = new String[ulf.getUser_roles_list().size()];
					for (int i = 0; i < roles.length; i++) {
						roles[i] = ulf.getUser_roles_list().get(i).getUuid();
					}
					map.put("roles", roles);
					map.put("no_tree_view", "A");
					role_p_list = (new UserRoleDAO()).listRolePrvg(map);

					for (int i = 0, n = role_p_list.size(); i < n; i++) {
						if (!(p_map.containsKey(role_p_list.get(i).getPrivilege_id()) && (p_map.get(role_p_list.get(i)
								.getPrivilege_id()) > role_p_list.get(i).getType()))) { // 如已经存在此权限,则从高原则
							p_map.put(role_p_list.get(i).getPrivilege_id(), role_p_list.get(i).getType());
						}

						if (f_map.containsKey(role_p_list.get(i).getPrivilege_id())
								&& !ToolsUtil.isEmpty(f_map.get(role_p_list.get(i).getPrivilege_id()))) {
							String tmp = f_map.get(role_p_list.get(i).getPrivilege_id());
							f_map.put(role_p_list.get(i).getPrivilege_id(), tmp + ","
									+ role_p_list.get(i).getFunction());
						} else {
							f_map.put(role_p_list.get(i).getPrivilege_id(), role_p_list.get(i).getFunction());
						}

						log.info(ulf.getTitle() + ":" + role_p_list.get(i).getPrivilege_id() + "("
								+ role_p_list.get(i).getType() + ":" + role_p_list.get(i).getFunction() + ")");
					}
					ulf.setUser_prvg_map(p_map);
					ulf.setUser_function_map(f_map);
				}
			}
		}

		if (!ToolsUtil.isEmpty(ulf.getUser_type())) {
			{// 设置权限列表--会员中心权限
				map.clear();
				List<RolePrvg> role_p_list;
				HashMap<String, Integer> p_map = new HashMap<String, Integer>();
				HashMap<String, String> f_map = new HashMap<String, String>();

				map.put("role_id", ulf.getUser_type());
				role_p_list = (new UserRoleDAO()).listRolePrvg(map);

				for (int i = 0, n = role_p_list.size(); i < n; i++) {
					if (!(p_map.containsKey(role_p_list.get(i).getPrivilege_id()) && (p_map.get(role_p_list.get(i)
							.getPrivilege_id()) > role_p_list.get(i).getType()))) { // 如已经存在此权限,则从高原则
						p_map.put(role_p_list.get(i).getPrivilege_id(), role_p_list.get(i).getType());
					}

					if (f_map.containsKey(role_p_list.get(i).getPrivilege_id())
							&& !ToolsUtil.isEmpty(f_map.get(role_p_list.get(i).getPrivilege_id()))) {
						String tmp = f_map.get(role_p_list.get(i).getPrivilege_id());
						f_map.put(role_p_list.get(i).getPrivilege_id(), tmp + "," + role_p_list.get(i).getFunction());
					} else {
						f_map.put(role_p_list.get(i).getPrivilege_id(), role_p_list.get(i).getFunction());
					}

					log.info(ulf.getTitle() + ":" + role_p_list.get(i).getPrivilege_id() + "("
							+ role_p_list.get(i).getType() + ":" + role_p_list.get(i).getFunction() + ")");
				}

				ulf.setMember_prvg_map(p_map);
				ulf.setMember_function_map(f_map);
			}
		}

		// 把结果写入SESSION

		HttpSession session = ContextHelper.getRequest().getSession();

		if (login_type == 0) {
			session.setAttribute(Parameters.UserLoginInfo_Session_Str, ulf);
			// 特殊操作,初始化部门
			ContextHelper.getUserLoginInfo().setPermit_depts(DeptLogic.getPermitDept());

			// 写入CKFinder的权限,需配置crossContext="true",主动写入ckframe的application
			if (session.getServletContext().getContext("/ckframe") != null) {
				if ("admin".equals(ulf.getTitle()) || "系统管理员".equals(ulf.getPosition_name())
						|| "ck_admin".equals(ulf.getFilesystem_root())) {
					session.getServletContext().getContext("/ckframe")
							.setAttribute(Parameters.CKFinder_Session_Str, "ck_admin");
				} else if ("ck_manager".equals(ulf.getFilesystem_root()) || "*".equals(ulf.getFilesystem_root())) {
					session.getServletContext().getContext("/ckframe")
							.setAttribute(Parameters.CKFinder_Session_Str, "ck_manager");
				} else if ("ck_news".equals(ulf.getFilesystem_root())) {
					session.getServletContext().getContext("/ckframe")
							.setAttribute(Parameters.CKFinder_Session_Str, "ck_news");
				} else {
					session.getServletContext().getContext("/ckframe")
							.setAttribute(Parameters.CKFinder_Session_Str, "ck_user");
				}
			}
		} else {
			ContextHelper.getRequest().getSession().setAttribute(Parameters.MemberLoginInfo_Session_Str, ulf);
			// 写入CKFinder的权限,需配置crossContext="true",主动写入ckframe的application
			session.getServletContext().getContext("/ckframe")
					.setAttribute(Parameters.CKFinder_Session_Str, "ck_member");
		}

	}

	/**
	 * 会员专用
	 * 
	 * @return
	 * @throws Exception
	 */
	public String memberLoginCheck() throws Exception {
		map.clear();
		if (user != null && user.getTitle() != null) {
			map.putAll(ToolsUtil.getMapByBean(user));
			String r_passwords = this.getUser().getPasswords();
			List l = dao.listCheck(map);
			if (l.size() == 1) {
				this.setUser((User) l.get(0));
				if (this.getUser().getStatus() == -1) {
					this.setMessage("该账户已被冻结!");
					return INPUT;
				}
				if ("true".equals(IWebConfig.getConfigMap().get("isPasswordEncrypt")) ? MD5Plus.compare(r_passwords,
						this.getUser().getPasswords()) : r_passwords.equals(this.getUser().getPasswords())) {
					setUserLoginInfo(user, 1);
					this.setMessage("登录成功!");
					return SUCCESS;
				}
			} else if (l.size() == 0) {
				this.setMessage("用户名不存在!");
			} else {
				this.setMessage("用户异常,请尽快和管理员联系,以免发生损失!");
			}
		} else {
			this.setMessage("用户名或密码错误!");
		}
		return INPUT;
	}
}
