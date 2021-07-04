package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class InDetailDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("inDetail_getInDetailsCounts");
		return super.list("inDetail_getInDetails", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("inDetail_getInDetails", map);
	}

	public Object add(Object parameters) {
		return super.add("inDetail_addInDetail", parameters);
	}

	public int save(Object parameters) {
		return super.save("inDetail_mdyInDetail", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("inDetail_delInDetail", parameters);
	}
	
	public int delLading(Map<String, Object> map){
		return super.delete("inDetail_delLading", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
