package org.iweb.common.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.DESPassword;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

public class OpenJFileSystemAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8334403226031761840L;

	private String date;
	private String validata;
	private String root;
	private String user;

	public String getDate() {
		return date;
	}

	public String getRoot() {
		return root;
	}

	public void setRoot(String root) {
		this.root = root;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getValidata() {
		return validata;
	}

	public void setValidata(String validata) {
		this.validata = validata;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	@Override
	public void validate() {
	}

	@Override
	public String execute() throws Exception {
		ContextHelper.isPermit("SYS_MANAGER_FILESYSTEM_SHOW");
		// DESPassword d = new DESPassword();
		// DESPlus d = new DESPlus();

		date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		validata = DESPassword.passwordEncrypt(date);
		root = ContextHelper.getUserLoginInfo().getFilesystem_root();
		if (ToolsUtil.isEmpty(root)) {
			root = "/";
		}
		user = ContextHelper.getUserLoginTitle();
		return SUCCESS;
	}

}