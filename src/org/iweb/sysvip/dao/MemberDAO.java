package org.iweb.sysvip.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sysvip.domain.Member;

public class MemberDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getMembersCounts");
		return super.list("sysvip_getMembers", map);
	}

	public Member get(Map<String, Object> map) {
		return (Member) super.get("sysvip_getMembers", map);
	}

	public Member get(String member_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uuid", member_id);
		return (Member) super.get("sysvip_getMembers", map);
	}

	public void add(Object parameters) {
		Member member = (Member) parameters;
		super.add("sysvip_addMember", member);
		MemberCapitalDAO mdao = new MemberCapitalDAO();
		mdao.addCapital(member.getUuid());
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyMember", parameters);
	}

	public int resetPasswords(Object parameters) {
		return super.save("sysvip_resetPasswords", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delMember", parameters);
	}

	public List getCheckMember(Map<String, Object> map) {
		return super.list("sysvip_checkMemberLogin", map);
	}

	public int memberDistribution(Map<String, Object> map) {
		return super.save("sysvip_distributionMember", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
