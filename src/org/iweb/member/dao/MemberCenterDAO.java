/**
 * 
 */
package org.iweb.member.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sysvip.domain.MemberCapital;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-6 下午3:39:27
 */
public class MemberCenterDAO extends AbstractDAO {
	public List listMemberOrderGoods(Map<String, Object> map) {
		setCountMapid("sysebiz_getMemberOrderGoodsCount");
		return super.list("sysebiz_getMemberOrderGoods", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}

	public void saveMember(Object parameters) {
		super.save("member_mdyMember", parameters);
	}

	public void mdyPassword(Object parameters) {
		super.save("member_changePasswords", parameters);
	}

	public void saveMemberAddress(Object parameters) {
		super.save("sysvip_mdyMemberAddressByMember", parameters);
	}

	public int getMemberCellarSum(String member_id) {
		return (int) super.get("sysebiz_getMemberCellarSum", member_id);
	}
}
