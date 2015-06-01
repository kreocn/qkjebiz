package com.qkj.ware.dao;

import java.text.SimpleDateFormat;
import java.util.*;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;

import com.qkj.manage.domain.Product;
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InStock;

public class InStockDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("inStock_getInStocksCounts");
		return super.list("inStock_getInStocks", map);
	}

	public List listbypo(Map<String, Object> map) {
		setCountMapid("inStock_getInStocksCountsByPower");
		return super.list("inStock_getIn", map);
	}

	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("inStock_getInStocks", map);
	}

	public Object add(Object parameters) {
		return super.add("inStock_addInStock", parameters);
	}

	public int save(Object parameters) {
		return super.save("inStock_mdyInStock", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("inStock_delInStock", parameters);
	}

	public int mdyTotalPrice(Integer lading_id) {
		return super.save("qkjmanage_mdyTotalPrice", lading_id);
	}

	public int sure(Object parameters) {
		return super.save("inStock_mdySure", parameters);
	}

	public int send(Object parameters) {
		return super.save("inStock_mdySend", parameters);
	}
	
	public int saveGodUid(Object parameters){
		return super.save("inStock_mdyGodUid", parameters);
	}

	public void addStock(Integer uuid,Integer store_id, Integer reason, Integer goreason, List<Product> products) {
		// TODO Auto-generated method stub
		InDetailDAO idao = new InDetailDAO();
		Product p = new Product();
		// 填加主表
		InStock inStock = new InStock();
		Date d = new Date();
		String u = ContextHelper.getUserLoginUuid();
		String num=getMoveOrderNo();
		inStock.setOrdernum(num);
		inStock.setDate(d);
		inStock.setStore_id(store_id);
		inStock.setReason(reason);// 调货入库
		inStock.setGoreason(goreason);
		inStock.setNote("入库");
		inStock.setLm_user(u);
		inStock.setAdd_user(u);
		inStock.setLm_timer(new Date());
		inStock.setAdd_timer(d);
		inStock.setGoldUuid(uuid);
		add(inStock);
		// 填加子表
		if (products.size() > 0) {
			for (int i = 0; i < products.size(); i++) {
				p = products.get(i);
				InDetail inDetail = new InDetail();
				inDetail.setLading_id(inStock.getUuid());
				inDetail.setProduct_id(p.getUuid());
				inDetail.setNum(p.getNum());
				inDetail.setPrice(p.getDprice());
				inDetail.setTotal(p.getDtotle());
				idao.add(inDetail);
			}
		}
		// 修改主表的总价
		InStockDAO ldao = new InStockDAO();
		ldao.mdyTotalPrice(inStock.getUuid());
	}

	/**
	 * 产生流水号
	 */
	public String getMoveOrderNo() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowdate = sdf.format(new Date());
		char[] a=nowdate.toCharArray();
		String m="";
		for(int i=0;i<a.length;i++){
			if(Character.isDigit(a[i])){
				m+=a[i];
			}
		}
		m=m.substring(0,m.length()-4);
		m = "R" + m+"000"+m.substring(m.length()-1,m.length());
		System.out.println(m);
		return m;
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
