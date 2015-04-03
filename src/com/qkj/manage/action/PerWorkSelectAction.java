package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.check.SkipStep;
import com.qkj.manage.dao.PerWorkDao;
import com.qkj.manage.domain.PerWork;
import com.qkj.manage.domain.PerWorkSelect;

public class PerWorkSelectAction extends ActionSupport {
	private static List<PerWorkSelect> selectList = new ArrayList<>();

	public List<PerWorkSelect> getSel(int[] a) {
		if (a.length > 0) {
			for (int i = 0; i < a.length; i++) {
				int l = a[i];
				if (l == 0) {// 总监
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS30")) {// 总监活动审核权限
						String s = "a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype";
						String t = "a.`status`=1 AND a.`sd_status`=30 AND a.`smd_status`=30";
						selectList.add(new PerWorkSelect("qkjm_r_active a", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS30")) {// 总监活动审核权限
						String s = "a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype";
						String t = "a.`status`=4 AND a.`close_sd_status`=30 AND a.`close_smd_status`=30";
						selectList.add(new PerWorkSelect("qkjm_r_active a", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_APPLY_CHECK20")) {// 总监至事由审核权限
						String s = "al.uuid perUuid,al.apply_dept apply_dept,al.title title,u.`USER_NAME` apply_user_name,'至事由' AS ptype";
						String t = "al.status=20";
						selectList.add(new PerWorkSelect("qkjm_r_apply al", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_ADM_LEAVE_CHECK20")) {// 工时
						String s = "l.uuid perUuid,l.leave_dept apply_dept,l.cause title,u.`USER_NAME` apply_user_name, CASE l.`leave_type` WHEN 0 THEN '出差' WHEN 1 THEN '请假' WHEN 2 THEN '加班' WHEN 3 THEN '换休' END AS ptype";
						String t = "l.check_status=20";
						selectList.add(new PerWorkSelect("qkja_r_leave l", s, t));
					}

				} else if (l == 1) {// 副总
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS40") || ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS40")) {// 业务副总活动审核权限
						String s = "a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype";
						String t = "a.`status`=1 AND a.`sd_status`=40 AND a.`smd_status`=40";
						selectList.add(new PerWorkSelect("qkjm_r_active a", s, t));

					}
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS40") || ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS40")) {// 业务副总活动结案审核权限
						String s = "a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype";
						String t = "a.`status`=4 AND a.`close_sd_status`=40 AND a.`close_smd_status`=40";
						selectList.add(new PerWorkSelect("qkjm_r_active a", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_APPLY_CHECK30")) {// 总监至事由审核权限
						String s = "al.uuid perUuid,al.apply_dept apply_dept,al.title title,u.`USER_NAME` apply_user_name,'至事由' AS ptype";
						String t = "al.status=30";
						selectList.add(new PerWorkSelect("qkjm_r_apply al", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_ADM_LEAVE_CHECK30")) {
						String s = "l.uuid perUuid,l.leave_dept apply_dept,l.cause title,u.`USER_NAME` apply_user_name, CASE l.`leave_type` WHEN 0 THEN '出差' WHEN 1 THEN '请假' WHEN 2 THEN '加班' WHEN 3 THEN '换休' END AS ptype";
						String t = "l.check_status=30";
						selectList.add(new PerWorkSelect("qkja_r_leave l", s, t));
					}

				} else if (l == 2) {// 总经理
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS50")) {// 总监活动审核权限
						String s = "a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype";
						String t = "a.`status`=1  AND a.`smd_status`=50";
						selectList.add(new PerWorkSelect("qkjm_r_active a", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50")) {// 总监活动审核权限
						String s = "a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype";
						String t = "a.`status`=4 AND a.`close_sd_status`=30 AND a.`close_smd_status`=30";
						selectList.add(new PerWorkSelect("qkjm_r_active a", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_QKJMANAGE_APPLY_CHECK40")) {// 总监至事由审核权限
						String s = "al.uuid perUuid,al.apply_dept apply_dept,al.title title,u.`USER_NAME` apply_user_name,'至事由' AS ptype";
						String t = "al.status=20";
						selectList.add(new PerWorkSelect("qkjm_r_apply al", s, t));
					}
					if (ContextHelper.checkPermit("QKJ_ADM_LEAVE_ACHECK20")) {
						String s = "l.uuid perUuid,l.leave_dept apply_dept,l.cause title,u.`USER_NAME` apply_user_name, CASE l.`leave_type` WHEN 0 THEN '出差' WHEN 1 THEN '请假' WHEN 2 THEN '加班' WHEN 3 THEN '换休' END AS ptype";
						String t = "l.check_status=20";
						selectList.add(new PerWorkSelect("qkja_r_leave l", s, t));
					}

				}
			}
		}
		return selectList;
	}

}
