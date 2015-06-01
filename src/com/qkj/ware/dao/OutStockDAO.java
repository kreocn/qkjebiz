package com.qkj.ware.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;

import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.ware.action.InStockAction;
import com.qkj.ware.domain.OutDetail;
import com.qkj.ware.domain.OutStock;
import com.qkj.ware.domain.Stock;

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

	public int updateSend(Object parameters) {
		return super.save("outStock_mdySend", parameters);
	}

	// 销售出库填加会员信息
	public int updateStockSale(Object parameters) {
		return super.save("outStock_mdyOutStockSale", parameters);
	}

	// 送审
	public int updateCheck(Object parameters) {
		return super.save("outStock_mdyCheck", parameters);
	}

	// 经理审
	public int updateCheckManage(Object parameters) {
		return super.save("outStock_mdyCheckManage", parameters);
	}

	// 总监审
	public int updateCheckCoo(Object parameters) {
		return super.save("outStock_mdyCheckCoo", parameters);
	}

	// 备注
	public int updateNote(Object parameters) {
		return super.save("outStock_mdyNote", parameters);
	}

	public int updatebs(Object parameters) {
		return super.save("outStock_mdyOutStockBs", parameters);
	}

	public int sure(OutStock outStock) {
		Map<String, Object> map = new HashMap<String, Object>();
		String u = ContextHelper.getUserLoginUuid();
		StockDAO stockdao = new StockDAO();
		Stock stock = new Stock();
		OutDetail outDetail = new OutDetail();
		List<OutDetail> outDetails = new ArrayList();
		List<Stock> stocks = new ArrayList();
		List<Product> produs = new ArrayList<>();

		Product pdi = new Product();
		ProductDAO pd = new ProductDAO();
		try {
			super.startTransaction();
			// 修改库存
			outStock = (OutStock) get(outStock.getUuid());
			OutDetailDAO odd = new OutDetailDAO();
			map.clear();
			map.put("lading_id", outStock.getUuid());
			outDetails = odd.list(map);
			if (outDetails.size() > 0) {
				for (int i = 0; i < outDetails.size(); i++) {
					outDetail = outDetails.get(i);
					List<Product> pros = new ArrayList<>();
					map.clear();
					map.put("uuid", outDetail.getProduct_id());
					pros = pd.list(map);
					if (pros.size() > 0) {
						pdi = pros.get(0);
						pdi.setNum(outDetail.getNum());
						pdi.setDprice(outDetail.getPrice());
						pdi.setDtotle(outDetail.getTotel());
						produs.add(pdi);
					}

					map.clear();
					map.put("product_id", outDetail.getProduct_id());
					map.put("store_id", outStock.getStore_id());
					stocks = stockdao.list(map);// 查询出库仓库是否有此商品
					if (stocks.size() > 0) {
						stock = stocks.get(0);
						map.clear();
						map.put("quantity", stock.getQuantity() - outDetail.getNum());
						map.put("uuid", stock.getUuid());
						stockdao.updateTotleById(map);
					} else {// 填加为负数据库存
						stock = new Stock();
						stock.setProduct_id(outDetail.getProduct_id());
						stock.setStore_id(outStock.getStore_id());
						stock.setQuantity(0 - outDetail.getNum());
						stock.setFreezeNum(0);
						stockdao.add(stock);
					}

				}
			}
			// 修改确认状态
			outStock.setSend(4);
			outStock.setManager_check(1);// 确认
			outStock.setManager_check_user(u);// 确认人
			outStock.setManager_check_time(new Date());// 确认时间
			updateCheck(outStock);

			// 如何是调出仓库自动生成对方的入库单
			if (outStock.getReason() == 6) {
				InStockDAO isa = new InStockDAO();
				isa.addStock(outStock.getUuid(),outStock.getBorrowStore_id(), 4, 1, produs);
			}

			super.commitTransaction();

		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			super.endTransaction();
		}
		return 1;
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
