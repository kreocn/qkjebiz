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
	private Integer onlyType;// 有值,则只允许选择一类(产品/促销物料/其他)
	private String uuidKey; // 主键值
	private String uuidValue; // 主表uuid Form变量名
	private String backUrl; // 返回的Url
	private String actionUrl;// 提交的Url
	private String keyName;// 子表外键 Form变量名
	private String prodName;// 子表产品ID Form变量名
	private String perName;// 子表单价 Form变量名
	private String numName;// 子表数量 Form变量名
	private String totalName;// 子表总价 Form变量名

	public Integer getOnlyType() {
		return onlyType;
	}

	public void setOnlyType(Integer onlyType) {
		this.onlyType = onlyType;
	}

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
