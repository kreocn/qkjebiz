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
import com.qkj.manage.dao.CustomerDAO;
import com.qkj.manage.dao.CustomerRecodeDAO;
import com.qkj.manage.domain.Customer;
import com.qkj.manage.domain.CustomerRecode;

public class CustomerAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CustomerAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CustomerDAO dao = new CustomerDAO();

	private Customer customer;
	private List<Customer> customers;
	private List<CustomerRecode> customerRecodes;
	private String message;
	private String viewFlag;
	private String mode;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;客户列表";
	
	public String getPath() {
		return path;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public List<CustomerRecode> getCustomerRecodes() {
		return customerRecodes;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public List<Customer> getCustomers() {
		return customers;
	}

	public void setCustomers(List<Customer> customers) {
		this.customers = customers;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMER_LIST");
		try {
			map.clear();
			if (customer == null) {
				customer = new Customer();
			}
			if (ToolsUtil.isEmpty(customer.getDept_code())) {
				// 必须有部门,防止Permit_dept为null的情况
				customer.setDept_code(ContextHelper.getUserLoginDept());
				customer.setDept_name(ContextHelper.getUserLoginDeptName());
			}
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_CUSTOMER_LIST", map, customer, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map
					.get(Parameters.Current_Page_Str)).toString()));
			this.setCustomers(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;客户列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setCustomer(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				// this.setCustomer(null);
				customer = new Customer();
				customer.setDept_code(ContextHelper.getUserLoginDept());
				customer.setDept_name(ContextHelper.getUserLoginDeptName());
				customer.setManager(ContextHelper.getUserLoginUuid());
				customer.setStage(0);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/customer_list?viewFlag=relist'>客户列表</a>&nbsp;&gt;&nbsp;增加客户信息";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", customer.getUuid());
				if (null == map.get("uuid")) this.setCustomer(null);
				else this.setCustomer((Customer) dao.list(map).get(0));
				if (!ToolsUtil.isEmpty(customer.getDistribution())) {
					customer.setDistributions(customer.getDistribution().split(","));
				}

				if (!ToolsUtil.isEmpty(customer.getFailed_reason())) {
					customer.setFailed_reasons(customer.getFailed_reason().split(","));
				}

				CustomerRecodeDAO cdao = new CustomerRecodeDAO();
				map.clear();
				map.put("customer_id", customer.getUuid());
				map.put("order_type", "uuidAsc");
				customerRecodes = cdao.list(map);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/customer_list?viewFlag=relist'>客户列表</a>&nbsp;&gt;&nbsp;修改客户信息";
			} else {
				this.setCustomer(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMER_ADD");
		try {
			customer.setAdd_time(new Date());
			customer.setAdd_user(ContextHelper.getUserLoginUuid());
			customer.setDistribution(ToolsUtil.Array2String(customer.getDistributions() == null ? new String[] {}
					: customer.getDistributions(), ","));
			customer.setFailed_reason(ToolsUtil.Array2String(customer.getFailed_reasons() == null ? new String[] {}
					: customer.getFailed_reasons(), ","));
			dao.add(customer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMER_MDY");
		try {
			customer.setDistribution(ToolsUtil.Array2String(customer.getDistributions() == null ? new String[] {}
					: customer.getDistributions(), ","));
			customer.setFailed_reason(ToolsUtil.Array2String(customer.getFailed_reasons() == null ? new String[] {}
					: customer.getFailed_reasons(), ","));
			customer.setLm_user(ContextHelper.getUserLoginUuid());
			customer.setLm_time(new Date());
			dao.save(customer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMER_DEL");
		try {
			int i = dao.delete(customer);
			if (i == 0) setMessage("删除失败!8小时之前录入的回访记录不能删除.");
			else setMessage("删除成功!ID=" + customer.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String relist() throws Exception {
		return SUCCESS;
	}
}
