package com.qkj.manage.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;

import com.qkj.manage.domain.MyProcess;

public class ProcessDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getProcesssCounts");
		return super.list("qkjmanage_getProcesss", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getProcesss", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addProcess", parameters);
	}

	/**
	 * 
	 * @param p_type
	 *            (int)类型0无 1活动 2至事由 3:工时
	 * @param p_bizid
	 * @param p_sign
	 * @param p_note
	 * @param p_status01
	 * @param p_status02
	 * @param p_status03
	 * @param p_status04
	 * @param p_status05
	 */
	public void addProcess(Integer p_type, Integer p_bizid, String p_sign, String p_note, Integer p_status01, Integer p_status02, Integer p_status03,
			Integer p_status04, Integer p_status05,String loginUser) {
		MyProcess process = new MyProcess();
		process.setProcess_id(p_type);
		process.setBiz_id(p_bizid);
		process.setBiz_sign(p_sign);
		process.setBiz_note(p_note);
		process.setBiz_user(loginUser);
		process.setBiz_time(new Date());
		process.setBiz_status01(p_status01);
		process.setBiz_status02(p_status02);
		process.setBiz_status03(p_status03);
		process.setBiz_status04(p_status04);
		process.setBiz_status05(p_status05);
		this.add(process);
	}

	public void addProcess(Integer p_type, Integer p_bizid, String p_sign, String p_note, Integer p_status01, Integer p_status02, Integer p_status03,
			Integer p_status04,String loginUser) {
		addProcess(p_type, p_bizid, p_sign, p_note, p_status01, p_status02, p_status03, p_status04, null,loginUser);
	}

	public void addProcess(Integer p_type, Integer p_bizid, String p_sign, String p_note, Integer p_status01, Integer p_status02, Integer p_status03) {
		addProcess(p_type, p_bizid, p_sign, p_note, p_status01, p_status02, p_status03, null, null);
	}

	public void addProcess(Integer p_type, Integer p_bizid, String p_sign, String p_note, Integer p_status01, Integer p_status02) {
		addProcess(p_type, p_bizid, p_sign, p_note, p_status01, p_status02, null, null, null);
	}

	public void addProcess(Integer p_type, Integer p_bizid, String p_sign, String p_note, Integer p_status01) {
		addProcess(p_type, p_bizid, p_sign, p_note, p_status01, null, null, null, null);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
