package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.CustomerRecodeDAO;
import com.qkj.manage.domain.CustomerRecode;

public class CustomerRecodeAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CustomerRecodeAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CustomerRecodeDAO dao = new CustomerRecodeDAO();

	private CustomerRecode customerRecode;
	private List<CustomerRecode> customerRecodes;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;客户回访记录列表";
	
	public String getPath() {
		return path;
	}

	public CustomerRecode getCustomerRecode() {
		return customerRecode;
	}

	public void setCustomerRecode(CustomerRecode customerRecode) {
		this.customerRecode = customerRecode;
	}

	public List<CustomerRecode> getCustomerRecodes() {
		return customerRecodes;
	}

	public void setCustomerRecodes(List<CustomerRecode> customerRecodes) {
		this.customerRecodes = customerRecodes;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMERRECODE_LIST");
		try {
			map.clear();
			if (customerRecode != null)
				map.putAll(ToolsUtil.getMapByBean(customerRecode));
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCustomerRecodes(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;客户回访记录列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setCustomerRecode(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setCustomerRecode(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(customerRecode == null || customerRecode.getUuid() == null)) {
					this.setCustomerRecode((CustomerRecode) dao.get(customerRecode.getUuid()));
				} else {
					this.setCustomerRecode(null);
				}
			} else {
				this.setCustomerRecode(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMERRECODE_ADD");
		try {
			customerRecode.setAdd_user(ContextHelper.getUserLoginUuid());
			customerRecode.setAdd_time(new Date());
			dao.add(customerRecode);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMERRECODE_MDY");
		try {
			customerRecode.setLm_user(ContextHelper.getUserLoginUuid());
			customerRecode.setLm_time(new Date());
			dao.save(customerRecode);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMERRECODE_DEL");
		try {
			dao.delete(customerRecode);
			setMessage("删除成功!ID=" + customerRecode.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
