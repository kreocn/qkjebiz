package com.qkjsys.ebiz.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class CellarOrderDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getCellarOrdersCounts");
		return super.list("sysebiz_getCellarOrders", map);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addCellarOrder", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyCellarOrder", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delCellarOrder", parameters);
	}

	public int mdyCellarOrderStatus(Object parameters) {
		return super.save("sysebiz_mdyCellarOrderStatus", parameters);
	}

	/**
	 * 返回com.qkjsys.ebiz.domain.Order对象
	 * 
	 * @param memberCellarID
	 * @return
	 * @date 2014-1-19 下午6:50:01
	 */
	public Object getOrderByMemberCellarID(Integer memberCellarID) {
		return super.get("sysebiz_getOrderByMemberCellarID", memberCellarID);
	}

	/**
	 * 新订单是,减库存操作
	 * 
	 * @param cellar_order_id
	 * @return
	 * @date 2014-1-20 上午10:23:14
	 */
	public int outCellarStockByCellarOrderID(String cellar_order_id) {
		return super.save("sysebiz_outCellarStockByCellarOrderID", cellar_order_id);
	}

	/**
	 * 作废订单时,返回库存操作
	 * 
	 * @param cellar_order_id
	 * @return
	 * @date 2014-1-20 上午10:23:25
	 */
	public int inCellarStockByCellarOrderID(String cellar_order_id) {
		return super.save("sysebiz_inCellarStockByCellarOrderID", cellar_order_id);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
