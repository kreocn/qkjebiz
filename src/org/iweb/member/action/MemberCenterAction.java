package org.iweb.member.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.member.dao.MemberCenterDAO;
import org.iweb.sysvip.MemberStatusFactory;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberCapital;

import com.opensymphony.xwork2.ActionSupport;

public class MemberCenterAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberCenterAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberCenterDAO dao = new MemberCenterDAO();

	private Member member;
	private MemberCapital memberCapital;

	private int cellarSum;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public int getCellarSum() {
		return cellarSum;
	}

	public void setCellarSum(int cellarSum) {
		this.cellarSum = cellarSum;
	}

	public MemberCapital getMemberCapital() {
		return memberCapital;
	}

	public void setMemberCapital(MemberCapital memberCapital) {
		this.memberCapital = memberCapital;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
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

	@Override
	public String execute() throws Exception {
		// 得到用户信息
		this.setMember(MemberStatusFactory.getLoginMember());

		// 得到用户资产
		MemberCapitalDAO mdao = new MemberCapitalDAO();
		this.setMemberCapital(mdao.get(member.getUuid()));

		// 得到用户藏酒总数
		this.setCellarSum(dao.getMemberCellarSum(member.getUuid()));

		return SUCCESS;
	}

	/**
	 * 作为待开发的功能使用,不使用任何方法体
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-3-15 下午4:58:48
	 */
	public String build() throws Exception {
		return SUCCESS;
	}

}
