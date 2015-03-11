package com.qkj.manage.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;

import com.qkj.manage.domain.Approve;

public class ApproveDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getApprovesCounts");
		return super.list("qkjmanage_getApproves", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("qkjmanage_getApproves", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addApprove", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyApprove", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("qkjmanage_delApprove", parameters);
	}

	public int deleteLast(Object parameters) {
		return super.delete("qkjmanage_delLastUserApprove", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}

	// 以下是Logic判断部分
	/**
	 * 
	 */
	public Object add(Approve approve, Integer approve_type, Object p_id) {
		if (approve == null) approve = new Approve();
		if (p_id == null || approve_type == null || "".equals(p_id)) {
			return 0;
		} else if (approve_type == 0) {// 至事由审阅
			approve.setApprove_type(0);
			approve.setInt_id((Integer) p_id);
			approve.setAd_time(new Date());
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		} else if (approve_type == 1) {// 活动审阅
			approve.setApprove_type(1);
			approve.setInt_id((Integer) p_id);
			approve.setAd_time(new Date());
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		} else if (approve_type == 2) {// 工时审阅
			approve.setApprove_type(2);
			approve.setInt_id((Integer) p_id);
			approve.setAd_time(new Date());
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		} else if (approve_type == 3) {// 结案提货审阅
			approve.setApprove_type(3);
			approve.setInt_id((Integer) p_id);
			approve.setAd_time(new Date());
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		} else {
			return 0;
		}
		return add(approve);
	}

	public int deleteLast(Approve approve, Integer approve_type, Object p_id) {
		if (approve == null) approve = new Approve();
		if (p_id == null || approve_type == null || "".equals(p_id)) {
			return 0;
		} else if (approve_type == 0) {// 至事由审阅
			approve.setApprove_type(0);
			approve.setInt_id((Integer) p_id);
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		} else if (approve_type == 1) {// 活动管理审阅
			approve.setApprove_type(1);
			approve.setInt_id((Integer) p_id);
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		}else if (approve_type == 2) {// 工时管理审阅
			approve.setApprove_type(2);
			approve.setInt_id((Integer) p_id);
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		}else if (approve_type == 3) {// 结案提货审阅
			approve.setApprove_type(3);
			approve.setInt_id((Integer) p_id);
			approve.setCheck_user(ContextHelper.getUserLoginUuid());
		} else {
			return 0;
		}
		return deleteLast(approve);
	}

	/**
	 * 判断user是否已经参与审阅
	 * 
	 * @param approves
	 * @param user_uuid
	 * @return
	 */
	public boolean userIsIn(List<Approve> approves, String user_uuid) {
		if (approves == null || approves.size() == 0 || user_uuid == null || "".equals(user_uuid)) return false;
		else {
			for (Iterator<Approve> iterator = approves.iterator(); iterator.hasNext();) {
				Approve approve = iterator.next();
				if (user_uuid.equals(approve.getCheck_user())) return true;
			}
		}
		return false;
	}
}
