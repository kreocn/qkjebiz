package com.qkj.ware.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class OutStockDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("outStock_getOutStocksCounts");
		return super.list("outStock_getOutStocks", map);
	}

	public List listPower(Map<String, Object> map) {
		setCountMapid("outStock_getOutStocksCountsByPower");
		return super.list("outStock_getpower", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("outStock_getOutStocks", map);
	}

	public Object add(Object parameters) {
		return super.add("outStock_addOutStock", parameters);
	}

	public int save(Object parameters) {
		return super.save("outStock_mdyOutStock", parameters);
	}
	
	public int saveTotal(Object parameters) {
		return super.save("outStock_mdyOutStockByTotal", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("outStock_delOutStock", parameters);
	}
	
	public int updateSend(Object parameters){
		return super.save("outStock_mdySend", parameters);
	}
	
	//销售出库填加会员信息
	public int updateStockSale(Object parameters){
		return super.save("outStock_mdyOutStockSale", parameters);
	}
	//送审
	public int updateCheck(Object parameters){
		return super.save("outStock_mdyCheck", parameters);
	}
	//经理审
	public int updateCheckManage(Object parameters){
			return super.save("outStock_mdyCheckManage", parameters);
	}
	//总监审
	public int updateCheckCoo(Object parameters){
			return super.save("outStock_mdyCheckCoo", parameters);
	}
	//备注
	public int updateNote(Object parameters){
			return super.save("outStock_mdyNote", parameters);
	}
	public int updatebs(Object parameters){
		return super.save("outStock_mdyOutStockBs", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
