package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class StoresDao extends AbstractDAO {
	public StoresDao() {
		super.setDb_num(1);
	}

	public List list(Map<String, Object> map) {
		List list = super.list("qkjStores_getProducts", map);
		return list;
	}
	
	public List listWeek(Map<String, Object> map) {
		List list = super.list("qkjStores_getOrderWeek", map);
		return list;
	}
	public List listOrder(Map<String, Object> map) {
		return super.list("qkjStores_Order_update_list", map);
	}

	public List listOrderItem(Map<String, Object> map) {
		return super.list("qkjStores_Order_update_item_list", map);
	}

	public Object add(Object parameters) {
		Object ob = super.add("qkjStores_addProducts", parameters);
		return ob;
	}

	public Object addO(Object parameters) {
		Object ob = super.add("qkjStores_addOrder", parameters);
		return ob;
	}

	public Object delete(Object parameters) {
		Object ob = super.delete("qkjStores_OrderItemDelete", parameters);
		return ob;
	}

	public Object saveOrderItemPrice(Object parameters) {
		Object ob = super.save("qkjStores_orderPrice", parameters);
		return ob;
	}

	public Object saveOrderItem(Object parameters) {
		Object ob = super.save("qkjStores_update_OrderItem", parameters);
		return ob;
	}

	public Object deleteItemandorder(Object parameters) {
		try {
			startTransaction();
			super.delete("qkjStores_delete_OrderAndItem", parameters);
			super.delete("qkjStores_OrderItemDelete", parameters);
			commitTransaction();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			endTransaction();
		}

		return null;
	}
}
