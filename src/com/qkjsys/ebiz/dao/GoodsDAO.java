package com.qkjsys.ebiz.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

import com.qkjsys.ebiz.domain.GoodsStock;
import com.qkjsys.ebiz.domain.OrderGoods;

public class GoodsDAO extends AbstractDAO {

	public Object add(Object parameters) {
		return super.add("ebiz_addGoods", parameters);
	}

	public void save(Object parameters) {
		super.save("ebiz_mdyGoods", parameters);
	}

	public void mdyGoodsSales(Object parameters) {
		super.save("ebiz_mdyGoodsSales", parameters);
	}

	public void delete(Object parameters) {
		super.delete("ebiz_delGoods", parameters);
	}

	public List list(Map<String, Object> map) {
		setCountMapid("ebiz_getGoodsCounts");
		return super.list("ebiz_getGoods", map);
	}

	public Object addStock(Integer goods_id, Integer stock_num) {
		GoodsStock gs = new GoodsStock();
		gs.setUuid(goods_id);
		gs.setStock_num(stock_num);
		return super.add("sysebiz_addGoodsStock", gs);
	}

	public void saveFrozeStock(Integer goods_id) {
		super.save("sysebiz_mdyFrozeStock", goods_id);
	}

	/**
	 * 库存调整,直接用MemberCellar中,未分配的数量作为库存
	 * 
	 * @param uuid
	 *            即是goods_id
	 * @date 2014-4-13 下午2:09:28
	 */
	public void saveStock(int uuid) {
		super.save("sysebiz_mdyGoodsStock", uuid);
	}

	/**
	 * 入库(补库存)管理
	 * 
	 * @param goods_id
	 * @date 2014-1-13 下午9:16:59
	 */
	public void saveInStock(GoodsStock gs) {
		super.save("sysebiz_mdyInStock", gs);
	}

	/**
	 * 根据order_id来调整库存情况,直接调整,可以在任何时间使用,也可以作为库存检查使用
	 * 
	 * @param order_id
	 * @date 2014-1-13 下午9:24:47
	 */
	public void mdyStockByOrderID(String order_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderGoodsDAO odao = new OrderGoodsDAO();
		map.put("order_id", order_id);
		List<OrderGoods> orderGoodss = odao.list(map);

		List<String> map_id_list = new ArrayList<>();
		List<Object> parameter_list = new ArrayList<>();

		for (Iterator<OrderGoods> iterator = orderGoodss.iterator(); iterator.hasNext();) {
			OrderGoods og = (OrderGoods) iterator.next();
			map_id_list.add("sysebiz_mdyGoodsStock");
			parameter_list.add(og.getGoods_id());
			map_id_list.add("sysebiz_mdyFrozeStock");
			parameter_list.add(og.getGoods_id());
		}
		super.batchStatment(map_id_list, parameter_list, false);
	}

	/**
	 * 订单作废时，根据order_id来调整库存情况,只能在作废时才能调用(本身不检查)
	 * 
	 * @param order_id
	 * @date 2014-1-13 下午9:24:47
	 */
	public void mdyStockOnOrderInvalid2(String order_id, Integer order_status) {
		Map<String, Object> map = new HashMap<String, Object>();

		String map_id = "";
		// 操作符号,1为操作冻结 2为操作库存 3说明不需要进行库存操作
		int op_flag = 3;
		// 在只冻结的时候,只需返还冻结即可
		if (order_status > 0 && order_status < 36) {
			op_flag = 1;
			map_id = "sysebiz_mdyFrozeStock";
		} else if (order_status >= 36) { // 仓库已经出货,则需要重新入库
			op_flag = 2;
			map_id = "sysebiz_mdyGoodsStock";
		}

		OrderGoodsDAO odao = new OrderGoodsDAO();
		map.clear();
		map.put("order_id", order_id);
		List<OrderGoods> orderGoodss = odao.list(map);

		List<Object> parameter_list = new ArrayList<>();

		for (Iterator<OrderGoods> iterator = orderGoodss.iterator(); iterator.hasNext();) {
			OrderGoods og = (OrderGoods) iterator.next();
			if (op_flag == 1) {
				parameter_list.add(og.getGoods_id());
			} else if (op_flag == 2) {
				parameter_list.add(new GoodsStock(og.getGoods_id(), og.getOrder_num()));
			}
		}
		super.batchStatment(map_id, parameter_list, false);
	}

	public void createCellarsByGoodsID(int goods_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_goods_id", goods_id);
		super.procedure("createCellarsByGoodsID", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
