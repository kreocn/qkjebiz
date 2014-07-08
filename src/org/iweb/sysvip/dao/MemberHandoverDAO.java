package org.iweb.sysvip.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sysvip.domain.MemberHandover;

public class MemberHandoverDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getMemberHandoversCounts");
		return super.list("sysvip_getMemberHandovers", map);
	}

	public Object add(Object parameters) {
		return super.add("sysvip_addMemberHandover", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyMemberHandover", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delMemberHandover", parameters);
	}

	public int MemberHandoverByHandoverIDs(Map<String, Object> map) {
		return super.save("sysvip_MemberHandoverByHandoverIDs", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
