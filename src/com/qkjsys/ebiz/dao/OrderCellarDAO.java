package com.qkjsys.ebiz.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

import com.qkjsys.ebiz.domain.OrderCellar;

public class OrderCellarDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getOrderCellarsCounts");
		return super.list("sysebiz_getOrderCellars", map);
	}

	public OrderCellar get(Integer uuid) {
		Map<String, Object> m = new HashMap<>();
		m.put("uuid", uuid);
		return (OrderCellar) super.get("sysebiz_getOrderCellars", m);
	}

	public List listOrderGoods(Map<String, Object> map) {
		return super.list("sysebiz_getOrderGoods4Cellars", map);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addOrderCellar", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyOrderCellar", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delOrderCellar", parameters);
	}

	public int delByOrderGoods(Integer order_goods_id) {
		return super.delete("sysebiz_delOrderCellarByOrderGoods", order_goods_id);
	}

	public int delByOrder(String order_id) {
		return super.delete("sysebiz_delOrderCellarByOrder", order_id);
	}

	public String addBatch(List<OrderCellar> orderCellars) {
		String failMsg = "";
		Map<String, Object> m = new HashMap<>();
		List<Object> list = new ArrayList<>();

		MemberCellarDAO mdao = new MemberCellarDAO();
		for (int i = 0, n = orderCellars.size(); i < n; i++) {
			OrderCellar oc = orderCellars.get(i);
			if (oc == null)
				continue;
			// m.put("order_goods_id", oc.getOrder_goods_id());
			m.put("ware_id", oc.getWare_id());
			m.put("cellar_no", oc.getCellar_no());
			m.put("goods_id", oc.getGoods_id());
			if (mdao.list(m).size() > 0) {
				failMsg += "(" + oc.getOrder_goods_id() + "-" + oc.getCellar_no() + ")";
				continue;
			}
			list.add(oc);
		}
		super.batchStatment("sysebiz_addOrderCellar", list, true);
		return failMsg;
	}

	/**
	 * 使用order_id检查配货数量,返回差值
	 * 
	 * @param order_id
	 * @return
	 * @date 2014-1-18 下午8:56:30
	 */
	public Integer checkOrderCellarsIsComplete(String order_id) {
		return (Integer) super.get("sysebiz_checkOrderCellarsIsComplete", order_id);
	}

	/**
	 * 使用order_goods_id检查配货数量,返回差值
	 * 
	 * @param order_goods_id
	 * @return
	 * @date 2014-1-18 下午8:56:30
	 */
	public Integer checkOrderCellarsNeedNum(Integer order_goods_id) {
		return (Integer) super.get("sysebiz_checkOrderCellarsNeedNum", order_goods_id);
	}

	public int getResultCount() {
		return super.getResultCount();
	}

	/********* NEW LIST *********/
	/**
	 * 得到订单的商品列表
	 * 
	 * @param order_id
	 * @return
	 * @date 2014-3-20 下午2:55:39
	 */
	public List listOrderGoods(String order_id) {
		return super.listByObject("sysebiz_getGoodsByOrderID", order_id);
	}
}
