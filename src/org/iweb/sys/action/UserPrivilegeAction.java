package org.iweb.sys.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserPrivilegeDAO;
import org.iweb.sys.domain.UserPrivilege;

import com.opensymphony.xwork2.ActionSupport;

public class UserPrivilegeAction extends ActionSupport {

	private static final long serialVersionUID = 2038563412156882147L;
	private UserPrivilegeDAO dao = new UserPrivilegeDAO();
	private static Log log = LogFactory.getLog(UserPrivilegeAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private UserPrivilege privilege;
	private List<UserPrivilege> privileges;
	private String message;

	public UserPrivilege getPrivilege() {
		return privilege;
	}

	public void setPrivilege(UserPrivilege privilege) {
		this.privilege = privilege;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<UserPrivilege> getPrivileges() {
		return privileges;
	}

	public void setPrivileges(List<UserPrivilege> privileges) {
		this.privileges = privileges;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_PRIVILEGE_LIST");
		try {
			map.clear();
			this.setPrivileges(dao.list(null));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_PRIVILEGE_ADD");
		try {
			if (privilege != null) {
				privilege.setUuid(ToolsUtil.getUUID());
				privilege.setLm_user(ContextHelper.getUserLoginTitle());
				privilege.setLm_time(new Date());
				dao.add(privilege);
				setMessage("添加成功!");
			} else {
				setMessage("参数为空!");
				log.warn("UserPrivilegeAction!add 写入失败:参数为空!");
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_PRIVILEGE_MDY");
		try {
			if (privilege != null) {
				privilege.setLm_user(ContextHelper.getUserLoginTitle());
				privilege.setLm_time(new Date());
				dao.save(privilege);
				setMessage("保存成功!ID=" + privilege.getUuid());
			} else {
				System.out.println("参数为空!");
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_PRIVILEGE_DEL");
		try {
			if (privilege != null) {
				dao.delete(privilege);
				setMessage("删除成功!ID=" + privilege.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}
}
