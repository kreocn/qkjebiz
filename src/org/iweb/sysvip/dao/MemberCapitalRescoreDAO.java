package org.iweb.sysvip.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sysvip.domain.MemberCapitalRescore;

public class MemberCapitalRescoreDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getMemberCapitalRescoresCounts");
		return super.list("sysvip_getMemberCapitalRescores", map);
	}

	public Object add(Object parameters) {
		return super.add("sysvip_addMemberCapitalRescore", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyMemberCapitalRescore", parameters);
	}

	public void mdyStatus(Object parameters) {
		// 改变状态
		super.save("sysvip_mdyMemberCapitalRescoreStatus", parameters);

		MemberCapitalRescore memberCapitalRescore = (MemberCapitalRescore) parameters;
		// 如果主管审核通过,则直接扣积分
		if (memberCapitalRescore.getStatus() == 2) {
			MemberCapitalDAO mdao = new MemberCapitalDAO();
			mdao.mdyCapitalDecreaseRe_score(memberCapitalRescore.getMember_id(), memberCapitalRescore.getScore(), 1,
					"人工减少了返利积分" + memberCapitalRescore.getScore() + ",记录编号:" + memberCapitalRescore.getUuid() + " 操作员:"
							+ ContextHelper.getUserLoginInfo().getUser_name());
		}
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delMemberCapitalRescore", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
