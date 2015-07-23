package com.qkj.manage.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.Parameters;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.MemberCapital;

import com.qkj.manage.domain.StoresOrder;
import com.qkj.manage.domain.StoresOrderItem;
import com.qkjsys.ebiz.domain.Order;

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
		setCountMapid("qkjStores_Order_update_listCount");
		return super.list("qkjStores_Order_update_list", map);
	}

	public List listOrderItem(Map<String, Object> map) {
		return super.list("qkjStores_Order_update_item_list", map);
	}

	public Object add(Object parameters) {
		Object ob = super.add("qkjStores_addProducts", parameters);
		return ob;
	}

	public int addO(Object parameters,List<StoresOrderItem> storesorderitem,String uuid) {
		int id=0;
		try {
			startTransaction();
			id = (int) super.add("qkjStores_addOrder", parameters);
			StoresDao dao=new StoresDao();
			for (StoresOrderItem storesOrderItem2 : storesorderitem) {
				storesOrderItem2.setOrder_id(id+"");
			}
			dao.add(storesorderitem);
			MemberCapital mc=new MemberCapital();
			if(uuid.equals("")||uuid.equals("0")){
				uuid="q000500";
			}
			mc.setMember_id(uuid);
			StoresOrder s=(StoresOrder)parameters;
			mc.setScore((int)(s.getTotal_price()*Parameters.STORE_INTEGRATION));
			MemberCapitalDAO md=new MemberCapitalDAO();
			md.mdyCapital(mc, 3, 1, "消费积分增加,门店支付,订单编号"+id);
			commitTransaction();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			endTransaction();
		}
		return id;
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
	public int getResultCount() {
		return super.getResultCount();
	}
}
