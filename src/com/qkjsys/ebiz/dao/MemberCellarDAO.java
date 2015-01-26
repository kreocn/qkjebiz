package com.qkjsys.ebiz.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ToolsUtil;

import com.qkjsys.ebiz.domain.MemberCellar4Add;

public class MemberCellarDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getMemberCellarsCounts");
		return super.list("sysebiz_getMemberCellars", map);
	}

	public Object get(Integer uuid) {
		Map<String, Object> m = new HashMap<>();
		m.put("uuid", uuid);
		return super.get("sysebiz_getMemberCellars", m);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addMemberCellar", parameters);
	}

	public Object addByOrderID(String order_id) {
		return super.add("sysebiz_addMemberCellarByOrderID", order_id);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyMemberCellar", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delMemberCellar", parameters);
	}

	public int deleteByOrder(Object parameters) {
		return super.delete("sysebiz_delMemberCellarByOrder", parameters);
	}

	/**
	 * 藏酒改变位置时,判断位置是否重复,返回已重复数值,如果大于1,说明系统有异常
	 * 
	 * @param ware_id
	 * @param cellar_position
	 * @return
	 * @date 2014-3-24 下午3:11:23
	 */
	public int checkMemberCellarsPosition(Integer ware_id, String cellar_position) {
		Map<String, Object> m = new HashMap<>();
		m.put("ware_id", ware_id);
		m.put("cellar_position", cellar_position);
		return (int) super.get("sysebiz_checkMemberCellarsPosition", m);
	}

	/**
	 * 取酒订单下判断,如果库存已经为0,则置藏酒标记为为1,代表删除
	 * 
	 * @return
	 * @date 2014-3-23 下午5:15:53
	 */
	public int delCellarByCellarOrderID(String cellar_order_id) {
		return super.save("sysebiz_delCellarByCellarOrderID", cellar_order_id);
	}

	public List listMemberCellars4Add(Map<String, Object> map) {
		return super.list("sysebiz_getMemberCellars4Add", map);
	}

	public void addBatch(MemberCellar4Add memberCellar, String goods_add_id) {
		List<Object> parameters = new ArrayList<>();
		String[] goods_ids = ToolsUtil.spliten(goods_add_id);
		if (goods_ids.length > 0) {
			OrderCellarDAO odao = new OrderCellarDAO();
			// 取得最多需要添加的数量
			int needAddNum = odao.checkOrderCellarsNeedNum(memberCellar.getOrder_goods_id());
			// 取最小值添加,如传入过多参数,后面的参数将被抛弃
			needAddNum = Math.min(needAddNum, goods_ids.length);
			MemberCellar4Add tmp;
			for (int i = 0; i < needAddNum; i++) {
				tmp = memberCellar.clone();
				tmp.setCellar_position(goods_ids[i]);
				parameters.add(tmp);
			}
			super.batchStatment("sysebiz_addCellar2Member", parameters, true);
		}
	}

	public int delete4Add(Integer memberCellarID) {
		return super.delete("sysebiz_delMemberCellar4Add", memberCellarID);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
