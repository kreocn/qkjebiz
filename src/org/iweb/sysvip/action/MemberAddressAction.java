package org.iweb.sysvip.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.MemberAddressDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberAddress;

import com.opensymphony.xwork2.ActionSupport;

public class MemberAddressAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberAddressAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberAddressDAO dao = new MemberAddressDAO();

	private Member member;
	private MemberAddress memberAddress;
	private List<MemberAddress> memberAddresss;

	private String member_id;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public MemberAddress getMemberAddress() {
		return memberAddress;
	}

	public void setMemberAddress(MemberAddress memberAddress) {
		this.memberAddress = memberAddress;
	}

	public List<MemberAddress> getMemberAddresss() {
		return memberAddresss;
	}

	public void setMemberAddresss(List<MemberAddress> memberAddresss) {
		this.memberAddresss = memberAddresss;
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
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERADDRESS_LIST");
		try {
			map.clear();
			if (memberAddress != null)
				map.putAll(ToolsUtil.getMapByBean(memberAddress));
			// map.putAll(ContextHelper.getDefaultRequestMap4Page());
			// this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setMemberAddresss(dao.list(map));
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
				this.setMemberAddress(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setMember_id(memberAddress.getMember_id());
				this.setMemberAddress(null);
				MemberDAO mdao = new MemberDAO();
				map.clear();
				map.put("uuid", this.getMember_id());
				this.setMember((Member) mdao.list(map).get(0));
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", memberAddress.getUuid());
				if (null == map.get("uuid"))
					this.setMemberAddress(null);
				else
					this.setMemberAddress((MemberAddress) dao.list(map).get(0));
				this.setMember_id(memberAddress.getMember_id());
			} else {
				this.setMemberAddress(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERADDRESS_ADD");
		try {
			// memberAddress.setLm_user(ContextHelper.getUserLoginUuid());
			// memberAddress.setLm_time(new Date());
			dao.add(memberAddress);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERADDRESS_MDY");
		try {
			// memberAddress.setLm_user(ContextHelper.getUserLoginUuid());
			// memberAddress.setLm_time(new Date());
			dao.save(memberAddress);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERADDRESS_DEL");
		try {
			dao.delete(memberAddress);
			setMessage("删除成功!ID=" + memberAddress.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String changeDefaultAddress() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERADDRESS_MDY");
		try {
			if (!(memberAddress == null || memberAddress.getUuid() == null)) {
				dao.saveDefaultAddr(memberAddress);
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
}
