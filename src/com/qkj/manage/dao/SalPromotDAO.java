package com.qkj.manage.dao;
import java.util.*;

import org.iweb.sys.AbstractDAO;
public class SalPromotDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("salpro_getSalPromotsCounts");
		return super.list("salpro_getSalPromots", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("salpro_getSalPromots", map);
	}

	public Object add(Object parameters) {
		return super.add("salpro_addSalPromot", parameters);
	}

	public int save(Object parameters) {
		return super.save("salpro_mdySalPromot", parameters);
	}
	
	public int saveFstatus(Object parameters) {
		return super.save("salpro_mdyFstauts", parameters);
	}
	
	public int saveStatus(Object parameters) {
		return super.save("salpro_mdyStatus", parameters);
	}
	public int saveSmdStatus(Object parameters) {
		return super.save("salpro_mdySmdStatus", parameters);
	}
	
	public int saveSdStatus(Object parameters) {
		return super.save("salpro_mdySdStatus", parameters);
	}
	
	public int savefdStatus(Object parameters) {
		return super.save("salpro_mdyFdStatus", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("salpro_delSalPromot", parameters);
	}

	public List listPower(Map<String, Object> map) {
		return super.list("salpro_getSalPromotsPower", map);
	}
	
	public List allsign(Map<String, Object> map) {
		return super.list("qkjmanage_salProAllsign", map);
	}
	
	public Object sign(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("biz_id", uuid);
		return super.get("qkjmanage_getsalProsign", map);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}
