package org.iweb.sysvip.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class DepositDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getDepositsCounts");
		return super.list("sysvip_getDeposits", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("sysvip_getDeposits", map);
	}

	public Object add(Object parameters) {
		return super.add("sysvip_addDeposit", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyDeposit", parameters);
	}

	public int fd_check(Object parameters) {
		return super.save("sysvip_Deposit_FdCheck", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delDeposit", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
