package com.qkj.ware.dao;
import java.util.*;

import org.iweb.sys.AbstractDAO;
public class StockDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("stock_getStocksCounts");
		return super.list("stock_getStocks", map);
	}
	
	public List listByPower(Map<String, Object> map) {
		setCountMapid("stock_getStocksCountsByPower");
		return super.list("stock_getPower", map);
	}
	
	public Object fingByPro(Map<String, Object> map){
		return super.get("stock_getStocks", map);
	}
	
	public List listBig(Map<String, Object> map) {
		return super.list("stock_getStocksBig", map);
	}
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("stock_getStocks", map);
	}

	public Object add(Object parameters) {
		return super.add("stock_addStock", parameters);
	}

	public int save(Object parameters) {
		return super.save("stock_mdyStock", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("stock_delStock", parameters);
	}
	
	public int updateTotle(Map<String, Object> map){
		return super.save("stock_mdyQuantity", map);
	}
	
	public int updateTotleById(Map<String, Object> map){
		return super.save("stock_mdyQuantityById", map);
	}
	
	public int updateFreezeNumById(Map<String, Object> map){
		return super.save("stock_mdyFreezeNumById", map);
	}
	
	public int updatborrow (Map<String, Object> map){
		return super.save("stock_borrow", map);
	}
	
	//综合查询
	public List listPowerByGroup(Map<String, Object> map) {
		setCountMapid("stock_getStocksCountsByGroup");
		return super.list("stock_getPowerByGroup", map);
	}
	public List listByGroup(Map<String, Object> map) {
		setCountMapid("stock_getPowerCountsByGroup");
		return super.list("stock_getByGroup", map);
	}
	
	//盘点
	public List listCheck(Map<String, Object> map) {
		return super.list("stock_getChecks", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
