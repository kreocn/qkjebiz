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
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InStock;
import com.qkj.ware.domain.OutDetail;
import com.qkj.ware.domain.OutStock;
import com.qkj.ware.domain.Stock;

public class OutStockDAO extends AbstractDAO {
	private Map<String, Object> map = new HashMap<String, Object>();
	public List list(Map<String, Object> map) {
		setCountMapid("outStock_getOutStocksCounts");
		return super.list("outStock_getOutStocks", map);
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

	// 送审
	public int updateCheck(Object parameters) {
		return super.save("outStock_mdyCheck", parameters);
	}

	// 备注
	public int updateNote(Object parameters) {
		return super.save("outStock_mdyNote", parameters);
	}

	public int updatebs(Object parameters) {
		return super.save("outStock_mdyOutStockBs", parameters);
	}
	
	public int updateboflag(Object parameters) {
		return super.save("outStock_mdyBoFlag", parameters);
	}

	/**
	 * 订单确认
	 * 
	 * @param outStock
	 * @return
	 */
	public int sure(OutStock outStock) {
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
				isa.addStock(outStock.getUuid(), outStock.getBorrowStore_id(), outStock.getStore_id(),4, 1, produs);
			}

			super.commitTransaction();

		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			super.endTransaction();
		}
		return 1;
	}

	/**
	 * 取消订单
	 * 
	 * @return
	 */
	public int cencle(OutStock outStock) {
		try {
			OutDetail outDetail = new OutDetail();
			List<OutDetail> outDetails = new ArrayList();
			super.startTransaction();
			OutDetailDAO odao = new OutDetailDAO();
			List<Stock> stocks = new ArrayList();
			Stock stock = new Stock();
			// 修改单据状态
			outStock.setSend(5);
			updateSend(outStock);
			// 修改库存
			StockDAO stockdao = new StockDAO();
			map.clear();
			map.put("lading_id", outStock.getUuid());
			outDetails=odao.list(map);
			if (outDetails.size() > 0) {
				for (int i = 0; i < outDetails.size(); i++) {
					outDetail=outDetails.get(i);
					map.clear();
					map.put("product_id", outDetail.getProduct_id());
					map.put("store_id", outStock.getStore_id());
					stocks=stockdao.list(map);// 查询出库仓库是否有此商品
					if (stocks.size() > 0) {
						stock=stocks.get(0);
						map.clear();
						map.put("quantity", stock.getQuantity() + outDetail.getNum());
						map.put("uuid", stock.getUuid());
						stockdao.updateTotleById(map);
					}
				}
			}
			// 修改对应入库单状态（调货）取消发货
			if (outStock.getReason() == 6) {
				InStockDAO id = new InStockDAO();
				InStock in = new InStock();
				in.setGoldUuid(outStock.getUuid());
				in.setGoflag(1);
				id.saveGodUid(in);
			}
			super.commitTransaction();
		}  catch (Exception e) {
			// TODO: handle exception
		} finally {
			super.endTransaction();
		}
		return 1;
	}
	
	public void addStock(Integer uuid, Integer store_id, Integer borrow_id,Integer reason, Integer goreason, List<Product> products) {
		// TODO Auto-generated method stub
			OutDetailDAO idao=new OutDetailDAO();
			InStockDAO id=new InStockDAO();
			Product p = new Product();
			// 填加主表
			OutStock outStock = new OutStock();
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			String num = id.getMoveOrderNo(1);
			outStock.setOrdernum(num);
			outStock.setDate(d);
			outStock.setStore_id(store_id);
			outStock.setNote("出库");
			outStock.setAdd_user(u);
			outStock.setLm_user(u);
			outStock.setAdd_timer(new Date());
			outStock.setLm_timer(new Date());
			outStock.setReason(reason);
			outStock.setGoldUuid(uuid);
			outStock.setBorrowStore_id(borrow_id);
			outStock.setGoreason(goreason);
			add(outStock);
			// 填加子表
			Double totle=0.00;
			if (products.size() > 0) {
				for (int i = 0; i < products.size(); i++) {
					p = products.get(i);
					OutDetail outDetail = new OutDetail();
					outDetail.setLading_id(outStock.getUuid());
					outDetail.setProduct_id(p.getUuid());
					outDetail.setNum(p.getNum());
					outDetail.setPrice(p.getDprice());
					outDetail.setTotel(p.getDtotle());
					totle=outDetail.getTotel();
					idao.add(outDetail);
				}
			}
			// 修改主表的总价
			outStock.setTotal_price(outStock.getTotal_price() +totle);
			saveTotal(outStock);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}
