package org.iweb.sys.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.RolePrvg;
import org.iweb.sys.domain.UserPrivilege;
import org.iweb.sys.domain.UserRole;
import org.iweb.sys.logic.SpecialPrivilege;
import org.iweb.sys.logic.SpecialPrivilegeExecute;

import com.opensymphony.xwork2.ActionSupport;

public class UserRoleAction extends ActionSupport {
	private static final long serialVersionUID = -7691462028760421679L;
	private static Log log = LogFactory.getLog(UserRoleAction.class);
	private UserRoleDAO dao = new UserRoleDAO();
	private Map<String, Object> map = new HashMap<String, Object>();

	private UserRole role;
	private List<UserRole> roles;
	private List<UserPrivilege> privileges;
	private List<RolePrvg> rolePrvgs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	private List<String> cd;

	private List<ListObject> newsClass;
	private String[] newsAllowClasses;

	private String specialPrivilegeHtml;

	public String getSpecialPrivilegeHtml() {
		return specialPrivilegeHtml;
	}

	public void setSpecialPrivilegeHtml(String specialPrivilegeHtml) {
		this.specialPrivilegeHtml = specialPrivilegeHtml;
	}

	public String[] getNewsAllowClasses() {
		return newsAllowClasses;
	}

	public void setNewsAllowClasses(String[] newsAllowClasses) {
		this.newsAllowClasses = newsAllowClasses;
	}

	public List<ListObject> getNewsClass() {
		return newsClass;
	}

	public void setNewsClass(List<ListObject> newsClass) {
		this.newsClass = newsClass;
	}

	public List<String> getCd() {
		return cd;
	}

	public void setCd(List<String> cd) {
		this.cd = cd;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public UserRole getRole() {
		return role;
	}

	public void setRole(UserRole role) {
		this.role = role;
	}

	public List<UserRole> getRoles() {
		return roles;
	}

	public void setRoles(List<UserRole> roles) {
		this.roles = roles;
	}

	public List<UserPrivilege> getPrivileges() {
		return privileges;
	}

	public void setPrivileges(List<UserPrivilege> privileges) {
		this.privileges = privileges;
	}

	public List<RolePrvg> getRolePrvgs() {
		return rolePrvgs;
	}

	public void setRolePrvgs(List<RolePrvg> rolePrvgs) {
		this.rolePrvgs = rolePrvgs;
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

	@Override
	public void validate() {
		// setRequest();
	}

	public String list() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_ROLE_LIST");
		try {
			map.clear();
			map = ContextHelper.getDefaultRequestMap4Page();
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			if (ContextHelper.isAdmin() || ContextHelper.checkPermit("SYS_MANAGER_ROLE_LISTALL")) {
				this.setRoles(dao.listSysRole(map));
				this.setRecCount(dao.getResultCount());
			} else {
				this.setRoles(ContextHelper.getUserLoginInfo().getUser_roles_list());
				this.setRecCount(this.getRoles().size());
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误.", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误.", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				setRole(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				setRole(null);
				this.setRolePrvgs(dao.listRolePrvgAdd());
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", role.getUuid());
				if (null == map.get("uuid")) {
					this.setRole(null);
					this.setRolePrvgs(dao.listRolePrvgAdd());
				} else {
					this.setRole((UserRole) dao.listSysRole(map).get(0));
					map.clear();
					map.put("role_id", role.getUuid());
					setRolePrvgs(dao.listRolePrvgAll(map));

					this.setSpecialPrivilegeHtml(""); // 设定一个初始值
					SpecialPrivilegeExecute spe = new SpecialPrivilegeExecute();
					for (Iterator<RolePrvg> list = getRolePrvgs().iterator(); list.hasNext();) {
						RolePrvg rp = (RolePrvg) list.next();
						if (!ToolsUtil.isEmpty(rp.getRole_id())) { // 非空代表此角色拥有此权限
							this.setSpecialPrivilegeHtml(this.getSpecialPrivilegeHtml() + spe.getRealFromHtml(rp.getPrivilege_id(), rp.getFunction()));
						}
					}
				}
			} else {
				setRole(null);
				setMessage("无操作类型!");
			}
			// this.setPrivileges(dao2.list(null));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误.", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误,", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_ROLE_ADD");
		try {
			role.setUuid(ToolsUtil.getUUID());
			role.setRole_type(1);
			role.setLm_user(ContextHelper.getUserLoginTitle());
			role.setLm_time(new Date());
			// dao.add(role);
			dao.add(role, cd);
		} catch (Exception e) {
			// setMessage("数据更新失败!" + e.getMessage());
			log.error(this.getClass().getName() + "!add 数据添加失败.", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败.", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_ROLE_MDY");
		try {
			role.setLm_user(ContextHelper.getUserLoginTitle());
			role.setLm_time(new Date());
			dao.save(role, cd);

			// 特殊功能保存
			SpecialPrivilegeExecute spe = new SpecialPrivilegeExecute();
			for (Map.Entry<String, String> entry : spe.getSpecialPrivilegeShowValues().entrySet()) {
				RolePrvg rImp = new RolePrvg();
				rImp.setRole_id(role.getUuid());
				rImp.setPrivilege_id(entry.getKey());
				rImp.setType(1);
				rImp.setFunction(entry.getValue());
				dao.saveRolePrvg(rImp);
			}

			setMessage("保存成功!");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败.", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败.", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_ROLE_DEL");
		try {
			dao.delete(role);
			setMessage("删除成功!ID=" + role.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败.", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败.", e);
		}
		return SUCCESS;
	}

	public String roleprvgLoad() throws Exception {
		try {
			map.clear();
			map.put("role_id", role.getUuid());
			setRolePrvgs(dao.listRolePrvg(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!roleprvgLoad 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!roleprvgLoad 读取数据错误.", e);
		}
		return SUCCESS;
	}

	public String roleprvgSave() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_ROLE_PRVG_SAVE");
		try {
			map.clear();
			map.put("role_id", role.getUuid());
			setRolePrvgs(dao.listRolePrvg(map));
			for (int i = 0, n = getRolePrvgs().size(); i < n; i++) {
				getRolePrvgs().get(i).setType(
						Integer.parseInt((String) (ToolsUtil.isEmpty(ContextHelper.getParameter(getRolePrvgs().get(i).getPrivilege_id())) ? "0"
								: ContextHelper.getParameter(getRolePrvgs().get(i).getPrivilege_id()))));
			}
			dao.saveRolePrvg(getRolePrvgs());

			// 传递参数,关闭ModelDiv
			setViewFlag("closewin");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!roleprvgSave 数据更新失败.", e);
			throw new Exception(this.getClass().getName() + "!roleprvgSave 数据更新失败.", e);
		}
		return SUCCESS;
	}

	/**************** 以下为会员组管理内容 *************************/
	/**
	 * 列出会员组
	 * 
	 * @return
	 * @throws Exception
	 */
	public String listGroup() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_GROUP_LIST");
		try {
			this.setRoles(dao.listUserRole(null));
			this.setRecCount(this.getRoles().size());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!listUser 读取数据错误.", e);
			throw new Exception(this.getClass().getName() + "!listUser 读取数据错误.", e);
		}
		return SUCCESS;
	}

	public String loadAddGroup() throws Exception {
		this.setViewFlag("add");
		setRole(null);
		this.setRolePrvgs(dao.listUserRolePrvgAdd());
		return SUCCESS;
	}

	public String addSaveGroup() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_GROUP_ADDSAVE");
		try {
			role.setUuid(ToolsUtil.getUUID());
			role.setRole_type(0);
			role.setLm_user(ContextHelper.getUserLoginTitle());
			role.setLm_time(new Date());
			dao.add(role, cd);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addSaveGroup 数据添加失败.", e);
			throw new Exception(this.getClass().getName() + "!addSaveGroup 数据添加失败.", e);
		}
		return SUCCESS;
	}

	public String loadMdyGroup() throws Exception {
		this.setViewFlag("mdy");
		map.clear();
		map.put("uuid", role.getUuid());
		if (null == map.get("uuid")) {
			this.setRole(null);
			this.setRolePrvgs(dao.listRolePrvgAdd());
		} else {
			this.setRole((UserRole) dao.listUserRole(map).get(0));
			map.clear();
			map.put("role_id", role.getUuid());
			setRolePrvgs(dao.listUserRolePrvgAll(map));

			this.setSpecialPrivilegeHtml(""); // 设定一个初始值
			SpecialPrivilegeExecute spe = new SpecialPrivilegeExecute();
			for (Iterator<RolePrvg> list = getRolePrvgs().iterator(); list.hasNext();) {
				RolePrvg rp = (RolePrvg) list.next();
				if (!ToolsUtil.isEmpty(rp.getRole_id())) { // 非空代表此角色拥有此权限
					this.setSpecialPrivilegeHtml(this.getSpecialPrivilegeHtml() + spe.getRealFromHtml(rp.getPrivilege_id(), rp.getFunction()));
				}
			}
		}
		return SUCCESS;
	}

	public String mdySaveGroup() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_USER_GROUP_MDYSAVE");
		try {
			role.setLm_user(ContextHelper.getUserLoginTitle());
			role.setLm_time(new Date());
			dao.save(role, cd);

			// 特殊功能保存
			SpecialPrivilegeExecute spe = new SpecialPrivilegeExecute();
			for (Map.Entry<String, String> entry : spe.getSpecialPrivilegeShowValues().entrySet()) {
				RolePrvg rImp = new RolePrvg();
				rImp.setRole_id(role.getUuid());
				rImp.setPrivilege_id(entry.getKey());
				rImp.setType(1);
				rImp.setFunction(entry.getValue());
				dao.saveRolePrvg(rImp);
			}

			setMessage("保存成功!");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败.", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败.", e);
		}
		return SUCCESS;
	}
}
