package org.iweb.sysvip.dao;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sysvip.domain.MemberCapital;
import org.iweb.sysvip.domain.MemberCapitalActn;

public class MemberCapitalDAO extends AbstractDAO {

	public void addCapital(String member_id) {
		List<String> m = new LinkedList<>();
		List<Object> p = new LinkedList<>();
		// 添加资产
		m.add("sysvip_addMemberCapital");
		p.add(member_id);
		// 添加ACTN
		MemberCapitalActn mc = new MemberCapitalActn();
		mc.setMember_id(member_id);
		mc.setHtype(0);
		mc.setMode(0);
		mc.setNote("会员账户初始化");
		mc.setLm_user(ContextHelper.getUserLoginUuid());
		m.add("sysvip_addMemberCapitalActn");
		p.add(mc);
		// 添加History
		m.add("sysvip_addMemberCapitalHistory");
		p.add(member_id);

		super.batchStatment(m, p, false);
	}

	/**
	 * 改变用户资产
	 * 
	 * @param memberCapital
	 * @param mode
	 *            1资金账户增加 2减少 3消费积分增加 4减少 5返利积分增加 6减少 7随量积分增加 8减少 9score_x增加 10减少 11score_y增加 12减少 13money_x增加 14减少
	 *            15money_y增加 16减少
	 * @param actn_mode
	 *            日志产生方式 0系统自动 1人工修改 2返利单添加
	 * @param actn_note
	 *            日志说明
	 * @see org.iweb.sysvip.domain.MemberCapitalActn
	 * @date 2014-2-20 上午11:54:40
	 */
	public void mdyCapital(MemberCapital memberCapital, int mode, int actn_mode, String actn_note) {
		// memberCapital.getMoney()
		List<String> m = new LinkedList<>();
		List<Object> p = new LinkedList<>();
		// 先判断资产参数并修改
		int htype = mode; // ACTN参数
		String cmap = "";// 判断修改的map
		switch (mode) {
		case 1: // 增加资产
			if (memberCapital.getMoney() == null || memberCapital.getMoney() == Double.NaN) {
				memberCapital.setMoney(0.0);
			}
			cmap = "sysvip_mdyMemberCapitalMoney";
			break;
		case 2: // 减少资产
			if (memberCapital.getMoney() == null || memberCapital.getMoney() == Double.NaN) {
				memberCapital.setMoney(0.0);
			} else {
				memberCapital.setMoney(0 - memberCapital.getMoney());
			}
			cmap = "sysvip_mdyMemberCapitalMoney";
			break;
		case 3: // 增加消费积分
			if (memberCapital.getScore() == null) {
				memberCapital.setScore(0);
			}
			cmap = "sysvip_mdyMemberCapitalScore";
			break;
		case 4: // 减少消费积分
			if (memberCapital.getScore() == null) {
				memberCapital.setScore(0);
			} else {
				memberCapital.setScore(0 - memberCapital.getScore());
			}
			cmap = "sysvip_mdyMemberCapitalScore";
			break;
		case 5: // 增加返利积分
			if (memberCapital.getRe_score() == null) {
				memberCapital.setRe_score(0);
			}
			cmap = "sysvip_mdyMemberCapitalREScore";
			break;
		case 6: // 减少返利积分
			if (memberCapital.getRe_score() == null) {
				memberCapital.setRe_score(0);
			} else {
				memberCapital.setRe_score(0 - memberCapital.getRe_score());
			}
			cmap = "sysvip_mdyMemberCapitalREScore";
			break;

		// 7随量积分增加 8减少 9score_x增加 10减少 11score_y增加 12减少 13money_x增加 14减少 15money_y增加 16减少
		case 7: // 增加随量积分
			if (memberCapital.getWith_score() == null) {
				memberCapital.setWith_score(0);
			}
			cmap = "sysvip_mdyMemberCapitalWithScore";
			break;
		case 8: // 减少随量积分
			if (memberCapital.getWith_score() == null) {
				memberCapital.setWith_score(0);
			} else {
				memberCapital.setWith_score(0 - memberCapital.getWith_score());
			}
			cmap = "sysvip_mdyMemberCapitalWithScore";
			break;
		case 9: // 增加ScoreX
			if (memberCapital.getScore_x() == null) {
				memberCapital.setScore_x(0);
			}
			cmap = "sysvip_mdyMemberCapitalScoreX";
			break;
		case 10: // 减少ScoreX
			if (!(memberCapital.getScore_x() == null)) {
				memberCapital.setScore_x(0 - memberCapital.getScore_x());
			}
			cmap = "sysvip_mdyMemberCapitalScoreX";
			break;
		case 11: // 增加ScoreY
			if (memberCapital.getScore_y() == null) {
				memberCapital.setScore_y(0);
			}
			cmap = "sysvip_mdyMemberCapitalScoreY";
			break;
		case 12: // 减少ScoreY
			if (!(memberCapital.getScore_y() == null)) {
				memberCapital.setScore_y(0 - memberCapital.getScore_y());
			}
			cmap = "sysvip_mdyMemberCapitalScoreY";
			break;
		case 13: // 增加MoneyX
			if (memberCapital.getMoney_x() == null || memberCapital.getMoney_x() == Double.NaN) {
				memberCapital.setMoney_x(0.0);
			}
			cmap = "sysvip_mdyMemberCapitalMoneyX";
			break;
		case 14: // 减少资产
			if (memberCapital.getMoney_x() == null || memberCapital.getMoney_x() == Double.NaN) {
				memberCapital.setMoney_x(0.0);
			} else {
				memberCapital.setMoney_x(0 - memberCapital.getMoney_x());
			}
			cmap = "sysvip_mdyMemberCapitalMoneyX";
			break;

		case 15: // 增加资产
			if (memberCapital.getMoney_y() == null || memberCapital.getMoney_y() == Double.NaN) {
				memberCapital.setMoney_y(0.0);
			}
			cmap = "sysvip_mdyMemberCapitalMoneyY";
			break;
		case 16: // 减少资产
			if (memberCapital.getMoney_y() == null || memberCapital.getMoney_y() == Double.NaN) {
				memberCapital.setMoney_y(0.0);
			} else {
				memberCapital.setMoney(0 - memberCapital.getMoney_y());
			}
			cmap = "sysvip_mdyMemberCapitalMoneyY";
			break;
		default:
			return;
		}
		// 修改资产
		m.add(cmap);
		p.add(memberCapital);
		// 添加ACTN
		MemberCapitalActn mc = new MemberCapitalActn();
		mc.setMember_id(memberCapital.getMember_id());
		mc.setHtype(htype);
		mc.setMode(actn_mode);
		mc.setNote(actn_note);
		mc.setMoney(memberCapital.getMoney());
		mc.setLm_user(actn_mode == 1 ? ContextHelper.getUserLoginUuid() : "SYSTEM");
		m.add("sysvip_addMemberCapitalActn");
		p.add(mc);
		// 添加History
		m.add("sysvip_addMemberCapitalHistory");
		p.add(memberCapital.getMember_id());
		super.batchStatment(m, p, false);
	}

	public void mdyCapital(String member_id, Double money, Integer score, Integer re_score, int mode, int actn_mode,
			String actn_note) {
		MemberCapital memberCapital = new MemberCapital();
		memberCapital.setMember_id(member_id);
		memberCapital.setMoney(money);
		memberCapital.setScore(score);
		memberCapital.setRe_score(re_score);
		mdyCapital(memberCapital, mode, actn_mode, actn_note);
	}

	public void mdyCapitalDecreaseRe_score(String member_id, Integer re_score, int actn_mode, String actn_note) {
		MemberCapital memberCapital = new MemberCapital();
		memberCapital.setMember_id(member_id);
		memberCapital.setRe_score(re_score);
		mdyCapital(memberCapital, 6, actn_mode, actn_note);
	}

	public int delCapital(Object parameters) {
		return super.delete("sysvip_delMemberCapital", parameters);
	}

	public List listCapitalActn(Map<String, Object> map) {
		setCountMapid("sysvip_getMemberCapitalActnCounts");
		return super.list("sysvip_getMemberCapitalActn", map);
	}

	public MemberCapital get(String member_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("member_id", member_id);
		return (MemberCapital) super.get("sysvip_getMemberCapital", map);
	}
	
	public List listCustActives(Map<String, Object> map) {
		setCountMapid("sysvip_getCustActivesCounts");
		return super.list("sysvip_getCustActives", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
