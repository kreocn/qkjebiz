package com.qkj.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class ApplyDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getApplysCounts");
		return super.list("qkjmanage_getApplys", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getApplys", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addApply", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyApply", parameters);
	}

	public int check(Object parameters) {
		return super.save("qkjmanage_checkApply", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delApply", parameters);
	}

	public int spcheck(Object parameters) {
		return super.save("qkjmanage_spcheckApply", parameters);
	}
	
	public List listUserSign(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("biz_id", uuid);
		return super.list("qkjmanage_getApplysUserSign", map);
	}

	public Object sign(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("biz_id", uuid);
		return super.get("qkjmanage_getApplysSign", map);
	}	
	
	// 发货信息修改
	public int mdyShipInfo(Object parameters) {
		return super.save("qkjmanage_mdyApplyShipInfo", parameters);
	}
	//修改总价
	
	public int mdyActiveItPrice(String apply_id) {
		return super.save("qkjmanage_mdyApplyItPrice", apply_id);
	}
	
	public int mdyApplyGoflag(Object parameters) {
		return super.save("qkjmanage_mdyGoflag", parameters);
	}
	public void saveTotalPrice(Object parameters){
	super.save("qkjmanage_ApplyTotalPrice", parameters);
	}

	
	public void push(Object parameters){
		super.save("qkjmanage_ApplyPush", parameters);
		}
	public int getResultCount() {
		return super.getResultCount();
	}
}
