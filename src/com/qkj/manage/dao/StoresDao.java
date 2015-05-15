package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class StoresDao extends AbstractDAO {
	public List list(Map<String, Object> map) {
		super.setDb_num(1);
		List list=super.list("qkjStores_getProducts", map);
		return list;
	}
	public List listOrder(Map<String, Object> map) {
		super.setDb_num(1);

		return super.list("qkjStores_Order_update_list", map);
	}
	public List listOrderItem(Map<String, Object> map) {
		super.setDb_num(1);

		return super.list("qkjStores_Order_update_item_list", map);
	}
	public Object add(Object parameters) {
		super.setDb_num(1);
		Object ob=super.add("qkjStores_addProducts", parameters);
		return ob;
	}
	public Object addO(Object parameters) {
		super.setDb_num(1);
		Object ob=super.add("qkjStores_addOrder", parameters);
		return ob;
	}
	public Object delete(Object parameters) {
		super.setDb_num(1);
		Object ob=super.delete("qkjStores_OrderItemDelete", parameters);
		return ob;
	}
	public Object saveOrderItem(Object parameters) {
		super.setDb_num(1);
		Object ob=super.save("qkjStores_orderPrice", parameters);
		return ob;
	}
}
