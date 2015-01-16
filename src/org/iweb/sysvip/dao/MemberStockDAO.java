package org.iweb.sysvip.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class MemberStockDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysvip_getMemberStocksCounts");
		return super.list("sysvip_getMemberStocks", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("sysvip_getMemberStocks", map);
	}

	public Object add(Object parameters) {
		return super.add("sysvip_addMemberStock", parameters);
	}
	
	public void addList(List<Object> parameter_list) {
		super.batchStatment("sysvip_addMemberStock", parameter_list, false);
	}
	
	public Object savemh(Object parameters){
		return super.add("sysvip_addMemberStockHistory", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysvip_mdyMemberStock", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysvip_delMemberStock", parameters);
	}
	
	public void delCheck(List<Object> parameter_list) {
		super.batchStatment("sysvip_delMemberStock", parameter_list, false);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
