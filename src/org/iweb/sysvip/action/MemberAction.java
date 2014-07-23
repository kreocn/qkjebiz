package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.MD5Plus;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.UserRole;
import org.iweb.sysvip.dao.MemberAddressDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberAddress;

import com.opensymphony.xwork2.ActionSupport;

public class MemberAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberDAO dao = new MemberDAO();
	private UserRoleDAO role_dao = new UserRoleDAO();

	private Member member;
	private List<Member> members;
	private List<UserRole> roles;

	private MemberAddress memberAddress;
	private List<MemberAddress> memberAddresses;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

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
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("SYSVIP_MEMBER_LIST", map, member, viewFlag);

			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setMembers(dao.list(map));
			this.setRecCount(dao.getResultCount());
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
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", member.getUuid());
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

	public String add() throws Exception {
		ContextHelper.isPermit("SYSVIP_MEMBER_ADD");
		try {
			if (ToolsUtil.isEmpty(member.getUser_type())) {
				// 如果类型为空,则设定为普通会员
				member.setUser_type("1387114067130001");
			}
			// 此为管理员添加会员
			String passwords = ToolsUtil.getRandomCode(6);
			member.setPasswords(MD5Plus.encrypt(passwords));// 设定密码为6位随机数,并进行MD5加密
			// 执行短信发送流程
			System.out.println("此应该为短信发送,密码为:" + passwords);

			member.setIs_mobile_check(1);
			member.setReg_type(1);
			member.setReg_time(new Date());
			String uuid = (String) dao.add(member);

			memberAddress.setMember_id(uuid);
			memberAddress.setDefaultaddress(1);
			MemberAddressDAO mdao = new MemberAddressDAO();
			mdao.add(memberAddress);
			log.info("成功添加了会员,会员号为:" + uuid);
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
				member.setPasswords(MD5Plus.encrypt(member.getPasswords()));
			} else {
				member.setPasswords(null);
			}
			dao.save(member);
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
				map.put("uuids", ToolsUtil.getSplitUuids(member.getUuid()));
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
}
