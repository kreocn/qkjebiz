package org.iweb.common.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.domain.UserLoginInfo;

import com.opensymphony.xwork2.ActionSupport;

public class MainAction extends ActionSupport {
	private static final long serialVersionUID = -7995560530227347448L;
	private static Log log = LogFactory.getLog(MenuAction.class);
	private String message;
	private String user_name;
	private String dept_code;
	private String org_name;
	private String dept_name;

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String nav() throws Exception {
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		this.setUser_name(ulf.getUser_name());
		this.setDept_code(ulf.getDept_code());
		this.setDept_name(ulf.getDept_cname());
		this.setOrg_name(ulf.getOrg_name());
		return SUCCESS;
	}

	public String main() throws Exception {
		return SUCCESS;
	}

}
