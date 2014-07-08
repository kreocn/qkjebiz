package org.iweb.sysvip.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sysvip.domain.MemberAddress;

public class MemberAddressDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getMemberAddresssCounts");
		return super.list("sysvip_getMemberAddresss", map);
	}

	public Object add(Object parameters) {
		return super.add("sysvip_addMemberAddress", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyMemberAddress", parameters);
	}

	public void saveDefaultAddr(MemberAddress ma) {
		String map_id = "sysvip_mdyMemberDefaultAddress";
		List<Object> pl = new ArrayList<>();
		MemberAddress ma1 = new MemberAddress();
		ma1.setMember_id(ma.getMember_id());
		ma1.setDefaultaddress(0);
		ma.setDefaultaddress(1);
		pl.add(ma1);
		pl.add(ma);
		super.batchStatment(map_id, pl, false);
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delMemberAddress", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
