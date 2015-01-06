package com.qkj.manage.action;

import org.iweb.sys.ActionAttr;

import com.opensymphony.xwork2.ActionSupport;

public class ManageCommonAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private String message;
	private String path;
	private String viewFlag;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	// only for products
	private String uuidKey;
	private String uuidValue;
	private String backUrl;
	private String actionUrl;
	private String keyName;
	private String prodName;
	private String perName;
	private String numName;
	private String totalName;

	public String getKeyName() {
		return keyName;
	}

	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getUuidKey() {
		return uuidKey;
	}

	public void setUuidKey(String uuidKey) {
		this.uuidKey = uuidKey;
	}

	public String getUuidValue() {
		return uuidValue;
	}

	public void setUuidValue(String uuidValue) {
		this.uuidValue = uuidValue;
	}

	public String getBackUrl() {
		return backUrl;
	}

	public void setBackUrl(String backUrl) {
		this.backUrl = backUrl;
	}

	public String getActionUrl() {
		return actionUrl;
	}

	public void setActionUrl(String actionUrl) {
		this.actionUrl = actionUrl;
	}

	public String getPerName() {
		return perName;
	}

	public void setPerName(String perName) {
		this.perName = perName;
	}

	public String getNumName() {
		return numName;
	}

	public void setNumName(String numName) {
		this.numName = numName;
	}

	public String getTotalName() {
		return totalName;
	}

	public void setTotalName(String totalName) {
		this.totalName = totalName;
	}

	public String products() throws Exception {
		// ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVEPOSMCLOSE_DEL");
		return SUCCESS;
	}

}
