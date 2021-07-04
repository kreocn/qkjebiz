package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.common.logic.CommonLogic;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.UserRole;
import org.iweb.sys.encrypt.EncryptMD5;
import org.iweb.sysvip.dao.MemberAddressDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberAddress;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.CustomerDAO;
import com.qkj.manage.dao.CustomerRecodeDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.Customer;
import com.qkj.manage.domain.CustomerRecode;

public class MemberAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberAction.class);
	private EncryptMD5 md5 = new EncryptMD5();
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberDAO dao = new MemberDAO();
	private UserRoleDAO role_dao = new UserRoleDAO();
	private ActiveDAO activedao=new ActiveDAO();
	private Customer customer;
	private String customer_id;
	private List<Active> active;
	public List<Active> getActive() {
		return active;
	}

	public void setActive(List<Active> active) {
		this.active = active;
	}

	public String getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

	private Member member;
	private CustomerDAO cdao = new CustomerDAO();
	private List<CustomerRecode> customerRecodes;
	public List<CustomerRecode> getCustomerRecodes() {
		return customerRecodes;
	}

	public void setCustomerRecodes(List<CustomerRecode> customerRecodes) {
		this.customerRecodes = customerRecodes;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	private List<Member> members;
	private List<UserRole> roles;

	private MemberAddress memberAddress;
	private List<MemberAddress> memberAddresses;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;工时管理";

	public String getPath() {
		return path;
	}

	public MemberAddress getMemberAddress() {
		return memberAddress;
	}

	public void setMemberAddress(MemberAddress memberAddress) {
		this.memberAddress = memberAddress;
	}

	public List<MemberAddress> getMemberAddresses() {
		return memberAddresses;
	}

	public void setMemberAddresses(List<MemberAddress> memberAddresses) {
		this.memberAddresses = memberAddresses;
	}

	public List<UserRole> getRoles() {
		return roles;
	}

	public void setRoles(List<UserRole> roles) {
		this.roles = roles;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
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
		ContextHelper.isPermit("SYSVIP_MEMBER_LIST");
		try {
			map.clear();
			if (member == null) member = new Member();
			ContextHelper.setSearchDeptPermit4Search("SYSVIP_MEMBER_LIST",map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("SYSVIP_MEMBER_LIST", map, member, viewFlag);

			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setMembers(dao.list(map));
			this.setRecCount(dao.getResultCount());

			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;会员列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setMember(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				member = new Member();
				member.setDept_code(ContextHelper.getUserLoginDept());
				member.setDept_name(ContextHelper.getUserLoginDeptName());
				member.setManager(ContextHelper.getUserLoginUuid());
				// this.setMember(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysvip/member_list?viewFlag=relist'>会员列表</a>&nbsp;&gt;&nbsp;添加会员";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				String uuid="";
				if(member==null){
					uuid=customer_id;
				}else{
					uuid=member.getUuid();
				}
				map.put("uuid", uuid);
				if (null == map.get("uuid")) {
					viewFlag = "add";
					member = new Member();
					member.setDept_code(ContextHelper.getUserLoginDept());
					member.setDept_name(ContextHelper.getUserLoginDeptName());
					member.setManager(ContextHelper.getUserLoginUuid());
					// this.setMember(null);
				} else this.setMember((Member) dao.list(map).get(0));
				map.clear();
				MemberAddressDAO mdao = new MemberAddressDAO();
				map.put("member_id", member.getUuid());
				this.setMemberAddresses(mdao.list(map));
				if(member.getIs_customers().equals("1")){
					load1();
				}
				CustomerRecodeDAO cdao = new CustomerRecodeDAO();
				map.clear();
				map.put("customer_id", member.getUuid());
				map.put("order_type", "uuidAsc");
				customerRecodes = cdao.list(map);
				active=activedao.svipList(map);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysvip/member_list?viewFlag=relist'>会员列表</a>&nbsp;&gt;&nbsp;修改会员信息";
			} else {
				this.setMember(null);
				setMessage("无操作类型!");
			}
			// 读取用户级别
			this.setRoles(role_dao.listUserRole(null));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	
	
	public String 	load1() throws Exception {
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
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("muuid", member.getUuid());
				System.out.println(member.getUuid());
				if (null == map.get("muuid")) this.setCustomer(null);
				else this.setCustomer((Customer) cdao.list(map).get(0));
				if (!ToolsUtil.isEmpty(customer.getDistribution())) {
					customer.setDistributions(customer.getDistribution().split(","));
				}
				if (!ToolsUtil.isEmpty(customer.getFailed_reason())) {
					customer.setFailed_reasons(customer.getFailed_reason().split(","));
				}
			
			} else {
				this.setCustomer(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return null;
	}
	
	

	public String add() throws Exception {
		ContextHelper.isPermit("SYSVIP_MEMBER_ADD");
		try {
			if (ToolsUtil.isEmpty(member.getUser_type())) {
				// 如果类型为空,则设定为普通会员
				member.setUser_type("1387114067130001");
			}
			member.setUuid(CommonLogic.getNextMemberID());
			// 此为管理员添加会员
			String passwords = ToolsUtil.getRandomCode(6);
			member.setPasswords(md5.encrypt(passwords));// 设定密码为6位随机数,并进行MD5加密
			// 执行短信发送流程
			
			
			System.out.println("此应该为短信发送,密码为:" + passwords);
			member.setIs_mobile_check(1);
			member.setReg_type(1);
			member.setReg_time(new Date());
			if(member.getIs_email_check()==null){
				member.setIs_email_check(0);
			}
			 dao.add(member);
			memberAddress.setMember_id(member.getUuid());
			memberAddress.setDefaultaddress(1);
		
			MemberAddressDAO mdao = new MemberAddressDAO();
			mdao.add(memberAddress);
			log.info("成功添加了会员,会员号为:" + member.getUuid());
			
			if(member.getIs_customers().equals("1")){
			
			customer.setMember_id(member.getUuid());
			customer.setManager(member.getManager());
			customer.setDept_code(member.getDept_code());
			customer.setAdd_time(new Date());
			customer.setCon_name(member.getMember_name());
			customer.setCus_name(member.getContact());
			customer.setPhone(member.getMobile());
			customer.setAdd_user(ContextHelper.getUserLoginUuid());
			customer.setDistribution(ToolsUtil.Array2String(customer.getDistributions() == null ? new String[] {}
					: customer.getDistributions(), ","));
			customer.setFailed_reason(ToolsUtil.Array2String(customer.getFailed_reasons() == null ? new String[] {}
					: customer.getFailed_reasons(), ","));
			cdao.add(customer);
			}
			
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
	
	
	
	public String save() throws Exception {
		ContextHelper.isPermit("SYSVIP_MEMBER_MDY");
		try {
			member.setLast_login_time(new Date());
			if (!ToolsUtil.isEmpty(member.getPasswords())) {
				member.setPasswords(md5.encrypt(member.getPasswords()));
			} else {
				member.setPasswords(null);
			}
			dao.save(member);
			
			customer.setDept_code(member.getDept_code());
			customersave();
			
				
			if(member.getIs_customers().equals("1")){
				
				customer.setMember_id(member.getUuid());
				customer.setManager(member.getManager());
				customer.setDept_code(member.getDept_code());
				customer.setAdd_time(new Date());
				customer.setCon_name(member.getMember_name());
				customer.setCus_name(member.getContact());
				customer.setPhone(member.getMobile());
				customer.setAdd_user(ContextHelper.getUserLoginUuid());
				customer.setDistribution(ToolsUtil.Array2String(customer.getDistributions() == null ? new String[] {}
						: customer.getDistributions(), ","));
				customer.setFailed_reason(ToolsUtil.Array2String(customer.getFailed_reasons() == null ? new String[] {}
						: customer.getFailed_reasons(), ","));
				cdao.add(customer);
				}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String customersave() throws Exception {
	/*	ContextHelper.isPermit("QKJ_QKJMANAGE_CUSTOMER_MDY");*/
		try {
			customer.setDistribution(ToolsUtil.Array2String(customer.getDistributions() == null ? new String[] {}
					: customer.getDistributions(), ","));
			customer.setFailed_reason(ToolsUtil.Array2String(customer.getFailed_reasons() == null ? new String[] {}
					: customer.getFailed_reasons(), ","));
			customer.setLm_user(ContextHelper.getUserLoginUuid());
			customer.setLm_time(new Date());
			cdao.save(customer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	
	
	
	

	public String del() throws Exception {
		ContextHelper.isPermit("SYSVIP_MEMBER_DEL");
		try {
			dao.delete(member);
			setMessage("删除成功!ID=" + member.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 客户分配
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-30 下午9:36:13
	 */
	public String distribution() throws Exception {
		ContextHelper.isPermit("SYSVIP_MEMBER_DISTRIBUTION");
		try {
			if (member == null || ToolsUtil.isEmpty(member.getUuid()) || ToolsUtil.isEmpty(member.getDept_code())) {
				this.setMessage("参数缺失!");
			} else {
				map.clear();
				map.put("uuids", ToolsUtil.spliten(member.getUuid()));
				map.put("dept_code", member.getDept_code());
				map.put("manager", member.getManager());
				dao.memberDistribution(map);
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!distribution 数据更改失败:", e);
			throw new Exception(this.getClass().getName() + "!distribution 数据更改失败:", e);
		}
		return SUCCESS;
	}

	public String get_Member() throws Exception {
		boolean flag = true;
		try {
		
			HttpServletRequest request = ServletActionContext.getRequest();
			String mid = request.getParameter("params");
			map.clear();
			map.put("uuid", mid);
			this.setMembers(dao.list(map));
			if (members.size() != 1) {
				flag = false;
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.getWriter().print(flag);
		return null;
	}
	
	public String get_MemberMobile() throws Exception {
		boolean flag = true;
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			HttpServletRequest request = ServletActionContext.getRequest();
			String mid = request.getParameter("params");
			String puid=request.getParameter("puid");
			map.clear();
			map.put("mobile", mid);
			if(puid!=null){
				map.put("puid", puid);
			}
			this.setMembers(dao.list(map));
			if (members.size() >0) {
				flag = false;
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		ServletActionContext.getResponse().getWriter().print(flag);
		return null;
	}
	
	
	
	
	
	
	
}
