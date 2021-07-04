package org.iweb.member.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.member.dao.MemberCenterDAO;
import org.iweb.member.domain.MemberOrderGoods;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.MD5Plus;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.MemberStatusFactory;
import org.iweb.sysvip.dao.MemberAddressDAO;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.CustActives;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberAddress;
import org.iweb.sysvip.domain.MemberCapital;
import org.iweb.sysvip.domain.MemberCapitalActn;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.Active;

public class MemberInfoAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberInfoAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private MemberDAO dao = new MemberDAO();
	private MemberCenterDAO mdao = new MemberCenterDAO();
	private Member member;

	private MemberCapital memberCapital;
	private List<MemberCapitalActn> memberCapitalActns;
	private List<CustActives> custActives;
	private CustActives custActive;

	// 以下为修改密码所用对象
	private String old_passwords;
	private String new_passwords;
	private String new_passwords2;

	// 以下为会员地址对象
	private Integer memberAddressUuid;
	private MemberAddress memberAddress;
	private List<MemberAddress> memberAddresses;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	
	public CustActives getCustActive() {
		return custActive;
	}

	public void setCustActive(CustActives custActive) {
		this.custActive = custActive;
	}

	public List<CustActives> getCustActives() {
		return custActives;
	}

	public void setCustActives(List<CustActives> custActives) {
		this.custActives = custActives;
	}

	public MemberAddress getMemberAddress() {
		return memberAddress;
	}

	public void setMemberAddress(MemberAddress memberAddress) {
		this.memberAddress = memberAddress;
	}

	public Integer getMemberAddressUuid() {
		return memberAddressUuid;
	}

	public void setMemberAddressUuid(Integer memberAddressUuid) {
		this.memberAddressUuid = memberAddressUuid;
	}

	public List<MemberAddress> getMemberAddresses() {
		return memberAddresses;
	}

	public void setMemberAddresses(List<MemberAddress> memberAddresses) {
		this.memberAddresses = memberAddresses;
	}

	public List<MemberCapitalActn> getMemberCapitalActns() {
		return memberCapitalActns;
	}

	public void setMemberCapitalActns(List<MemberCapitalActn> memberCapitalActns) {
		this.memberCapitalActns = memberCapitalActns;
	}

	public MemberCapital getMemberCapital() {
		return memberCapital;
	}

	public void setMemberCapital(MemberCapital memberCapital) {
		this.memberCapital = memberCapital;
	}

	public String getNew_passwords2() {
		return new_passwords2;
	}

	public void setNew_passwords2(String new_passwords2) {
		this.new_passwords2 = new_passwords2;
	}

	public String getOld_passwords() {
		return old_passwords;
	}

	public void setOld_passwords(String old_passwords) {
		this.old_passwords = old_passwords;
	}

	public String getNew_passwords() {
		return new_passwords;
	}

	public void setNew_passwords(String new_passwords) {
		this.new_passwords = new_passwords;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Member getMember() {
		return member;
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

	public String getInfo() throws Exception {
		try {
			// map.clear();
			// map.put("uuid", MemberStatusFactory.getLoginMemberID());
			// this.setMember(dao.get(map));
			this.setMember(MemberStatusFactory.getLoginMember());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!getInfo 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!getInfo 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String saveMember() throws Exception {
		try {
			if (member != null) {
				member.setUuid(MemberStatusFactory.getLoginMemberID());
				mdao.saveMember(member);
				MemberStatusFactory.resetMemberLoginInfo(member);
				this.setMessage("保存成功");
			} else {
				this.setMessage("参数错误");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveMember 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveMember 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String loadPasswordMdy() throws Exception {
		return SUCCESS;
	}

	public String mdyPassword() throws Exception {
		try {
			if (!(ToolsUtil.isEmpty(old_passwords) || ToolsUtil.isEmpty(new_passwords))) {
				map.clear();
				map.put("uuid", MemberStatusFactory.getLoginMemberID());
				this.setMember(dao.get(map));
				if (!this.getNew_passwords().equals(this.getNew_passwords2())) {
					this.addFieldError("new_passwords2_error", "两次密码输入不正确");
				} else if (member.getPasswords().equals(MD5Plus.encrypt(old_passwords))) {
					member.setPasswords(MD5Plus.encrypt(new_passwords));
					mdao.mdyPassword(member);
					this.setMessage("修改成功");
					return SUCCESS;
				} else {
					this.addFieldError("old_passwords_error", "原密码错误输入错误");
				}
			} else {
				this.setMessage("参数错误");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveMember 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveMember 数据更新失败:", e);
		}
		return INPUT;
	}

	public String getCapital() throws Exception {
		try {
			MemberCapitalDAO mdao = new MemberCapitalDAO();
			this.setMemberCapital(mdao.get(MemberStatusFactory.getLoginMemberID()));

			map.clear();
			map.put("member_id", MemberStatusFactory.getLoginMemberID());
			map.put("limit", 30);
			this.setMemberCapitalActns(mdao.listCapitalActn(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!getCapital 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!getCapital 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String getAddress() throws Exception {
		try {
			MemberAddressDAO mdao = new MemberAddressDAO();
			map.clear();
			map.put("member_id", MemberStatusFactory.getLoginMemberID());
			this.setMemberAddresses(mdao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!getAddress 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!getAddress 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String addAddress() throws Exception {
		try {
			MemberAddressDAO adao = new MemberAddressDAO();
			memberAddress.setMember_id(MemberStatusFactory.getLoginMemberID());
			memberAddress.setDefaultaddress(0);
			adao.add(memberAddress);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveAddress 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!saveAddress 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String saveAddress() throws Exception {
		try {
			memberAddress.setMember_id(MemberStatusFactory.getLoginMemberID());
			mdao.saveMemberAddress(memberAddress);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveAddress 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!saveAddress 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String changeDefaultAddress() throws Exception {
		try {
			if (!(memberAddressUuid == null)) {
				MemberAddressDAO mdao = new MemberAddressDAO();
				MemberAddress ma = new MemberAddress();
				ma.setUuid(memberAddressUuid);
				ma.setMember_id(MemberStatusFactory.getLoginMemberID());
				mdao.saveDefaultAddr(ma);
				this.setMessage("修改成功");
			} else {
				this.setMessage("参数错误");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!changeDefaultAddress 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!changeDefaultAddress 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String getActive() throws Exception {
		try {
			MemberCapitalDAO mdao = new MemberCapitalDAO();
			map.clear();
			if (custActive == null)
				custActive = new CustActives();
			map.put("member_id", MemberStatusFactory.getLoginMemberID());
			map.putAll(MemberStatusFactory.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCustActives(mdao.listCustActives(map));
			this.setRecCount(mdao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!getCapital 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!getCapital 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
