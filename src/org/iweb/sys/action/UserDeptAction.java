package org.iweb.sys.action;

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
import org.iweb.sys.dao.UserDeptDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.UserDept;

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

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;用户权限信息";

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
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", userDept.getUuid());
				this.setUserDept((UserDept) dao.get(userDept.getUuid()));
			} else {
				this.setUserDept(null);
				setMessage("无操作类型!");
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		try {
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
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

}
