package com.qkj.manage.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.MemberCapital;

import com.qkj.manage.domain.Rebates;
import com.qkj.manage.domain.RebatesLading;

public class RebatesDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("qkjmanage_getRebatessCounts");
		return super.list("qkjmanage_getRebatess", map);
	}

	public Object add(Object parameters) {
		return super.add("qkjmanage_addRebates", parameters);
	}

	public int save(Object parameters) {
		return super.save("qkjmanage_mdyRebates", parameters);
	}

	public void delete(Object parameters) {
		Integer rebates_id = ((Rebates) parameters).getUuid();
		List<String> ms = new ArrayList<>();
		List<Object> ls = new ArrayList<>();
		// 标记Ladings 为[未返利]
		ms.add("qkjmanage_mdyLadingRebatesFlagByRebatesID");
		Map<String, Object> m = new HashMap<>();
		m.put("rebates_flag", 0);
		m.put("lm_user", ContextHelper.getUserLoginUuid());
		m.put("rebates_id", rebates_id);
		ls.add(m);
		// 删除RebatesLadings
		ms.add("qkjmanage_delRebatesLadings");
		ls.add(rebates_id);
		// 删除RebatesProducts
		ms.add("qkjmanage_delRebatesProductByRebatesID");
		ls.add(rebates_id);
		// 删除返利单
		ms.add("qkjmanage_delRebates");
		ls.add(parameters);

		// 批量操作
		super.batchStatment(ms, ls, false);
	}

	public int mdyStatus(Object parameters) {
		return super.save("qkjmanage_mdyRebatesStatus", parameters);
	}

	public void addRebatesLadingBatch(Integer rebates_id, String[] ladings) {
		if (ladings != null && ladings.length > 0) {
			// 增加RebatesLading
			List<String> ms = new ArrayList<>();
			List<Object> ls = new ArrayList<>();
			for (int i = 0; i < ladings.length; i++) {
				ms.add("qkjmanage_addRebatesLading");
				ls.add(new RebatesLading(rebates_id, ladings[i]));
			}
			// 标记Ladings 为[返利中]
			ms.add("qkjmanage_mdyLadingRebatesFlagByRebatesID");
			Map<String, Object> m = new HashMap<>();
			m.put("rebates_flag", 1);
			m.put("lm_user", ContextHelper.getUserLoginUuid());
			m.put("rebates_id", rebates_id);
			ls.add(m);
			// 批量提交
			super.batchStatment(ms, ls, false);
		}
	}

	public List listRebatesLadings(Map<String, Object> map) {
		return super.list("qkjmanage_getRebatesLadings", map);
	}

	public int delRebatesLadings(Integer rebates_id) {
		return super.delete("qkjmanage_delRebatesLadings", rebates_id);
	}

	public int mdyOutFlag(Object parameters) {
		return super.save("qkjmanage_mdyRebatesOutFlag", parameters);
	}

	public int mdyFDCheck(Object parameters) {
		Rebates p = (Rebates) parameters;
		int i = super.save("qkjmanage_mdyRebatesFDCheck", p);
		MemberCapitalDAO mdao = new MemberCapitalDAO();
		// 如果没有随量积分,则不需要启动返积分的流程
		if (!(p.getWith_score() == null || p.getWith_score() == 0)) {
			MemberCapital memberCapital = new MemberCapital();
			memberCapital.setMember_id(p.getMember_id());
			memberCapital.setWith_score(p.getWith_score());
			mdao.mdyCapital(memberCapital, 7, 2, "返利单编号[" + p.getUuid() + "]增加了随量积分[" + p.getWith_score() + "]");
		}
		// 如果没有返利积分,则不需要启动返积分的流程
		if (!(p.getRe_score() == null || p.getRe_score() == 0)) {
			MemberCapital memberCapital = new MemberCapital();
			memberCapital.setMember_id(p.getMember_id());
			memberCapital.setRe_score(p.getRe_score());
			mdao.mdyCapital(memberCapital, 5, 2, "返利单编号[" + p.getUuid() + "]增加了返利积分[" + p.getRe_score() + "]");
		}
		// 标记Ladings 为[已返利]
		Map<String, Object> m = new HashMap<>();
		m.put("rebates_flag", 2);
		m.put("lm_user", ContextHelper.getUserLoginUuid());
		m.put("rebates_id", p.getUuid());
		LadingDAO ldao = new LadingDAO();
		ldao.mdyLadingRebatesFlagByRebatesID(m);
		return i;
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
