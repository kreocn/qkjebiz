package com.qkj.ware.dao;

import java.text.SimpleDateFormat;
import java.util.*;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;

import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InStock;
import com.qkj.ware.domain.OutStock;
import com.qkj.ware.domain.Stock;

public class InStockDAO extends AbstractDAO {
	private Map<String, Object> map = new HashMap<String, Object>();
	private InDetail inDetail;
	private List<InDetail> inDetails;
	private Stock newStock;
	private Stock stock;

	public List list(Map<String, Object> map) {
		setCountMapid("inStock_getInStocksCounts");
		return super.list("inStock_getInStocks", map);
	}
	
	public List listSplit(Map<String, Object> map) {
		return super.list("inStock_getInStocksSpilt", map);
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

	public int mdySure(Object parameters) {
		return super.save("inStock_mdySure", parameters);
	}

	public int send(Object parameters) {
		return super.save("inStock_mdySend", parameters);
	}

	public int saveFlogbyGodUid(Object parameters) {
		return super.save("inStock_mdyGodUid", parameters);
	}

	public int mdyGodFlog(Object parameters) {
		return super.save("inStock_mdyGodFlog", parameters);
	}

	public int mdyGodUuid(Object parameters) {
		return super.save("inStock_mdyGodUuid", parameters);
	}
	
	public int mdyRemark(Object parameters) {
		return super.save("inStock_mdyRemark", parameters);
	}

	public int sure(InStock inStock) {
		String u = ContextHelper.getUserLoginUuid();
		try {
			// 修改库存
			super.startTransaction();
			ProductDAO pd = new ProductDAO();
			InDetailDAO idao = new InDetailDAO();
			Product pdi = new Product();
			List<Product> produs = new ArrayList<>();
			map.clear();
			map.put("lading_id", inStock.getUuid());
			inDetails = idao.list(map);

			if (inDetails != null && inDetails.size() > 0) {
				for (int i = 0; i < inDetails.size(); i++) {
					inDetail = new InDetail();
					inDetail = inDetails.get(i);
					List<Product> pros = new ArrayList<>();
					map.clear();
					map.put("uuid", inDetail.getProduct_id());
					/*
					 * pros = pd.list(map);
					 * if (pros.size() > 0) {
					 * pdi = pros.get(0);
					 * pdi.setNum(inDetail.getNum());
					 * pdi.setDprice(inDetail.getPrice());
					 * pdi.setDtotle(inDetail.getTotal());
					 * produs.add(pdi);
					 * }
					 */

					// 查询库存同一仓库中是否有此商品
					StockDAO stockdao = new StockDAO();
					map.clear();
					map.put("product_id", inDetail.getProduct_id());
					map.put("store_id", inStock.getStore_id());
					stock = (Stock) stockdao.fingByPro(map);
					// 填加库存信息(己有修改库存，没有填加)
					newStock = new Stock();
					if (stock != null) {
						stock.setQuantity(stock.getQuantity() + inDetail.getNum());
						stockdao.save(stock);
					} else {
						int pro = inDetail.getProduct_id();
						int num = inDetail.getNum();
						int stor = inStock.getStore_id();
						newStock.setProduct_id(pro);
						newStock.setQuantity(num);
						newStock.setStore_id(stor);
						stockdao.add(newStock);
					}
				}
			}

			inStock.setConfirm(1);
			inStock.setConname(u);
			inStock.setContime(new Date());
			mdySure(inStock);
			
			
			List<InStock> spilts=new ArrayList<>();
			map.clear();
			if(inStock.getSplit()==1){
				map.put("uuid", inStock.getSplitUuid());
			}else{
				map.put("uuid", inStock.getUuid());
			}
			spilts=this.listSplit(map);
			boolean falg=true;
			if(spilts.size()>1){//说明拆分过
				for(int i=0;i<spilts.size();i++){
					InStock s=new InStock();
					s=spilts.get(i);
					if(s.getConfirm()!=null&&s.getSend()!=1){//说明已确认入库
					}else{
						falg=false;
					}
				}
			}
			if(falg==false){//部分确认入库
				if(inStock.getGoreason()==1){//非手动填加来自出库单
					OutStockDAO od = new OutStockDAO();
					OutStock os = new OutStock();
					if(inStock.getSplit()==1){
						os.setGoldUuid(inStock.getSplitUuid());
					}else{
						os.setGoldUuid(inStock.getUuid());
					}
					if(inStock.getReason()==6){//还货
						os.setBackStock(1);
						os.setGoldUuid(inStock.getGoldUuid());
					}else{
						os.setBackStock(0);
					}
					os.setBoflag(6);
					od.updateboflag(os);
				}
			}else{//全部确认
				if(inStock.getGoreason()==1){//非手动填加
					OutStockDAO od = new OutStockDAO();
					OutStock os = new OutStock();
					if(inStock.getSplit()==1){
						os.setGoldUuid(inStock.getSplitUuid());
					}else{
						os.setGoldUuid(inStock.getUuid());
					}
					if(inStock.getReason()==6){//还货
						os.setBackStock(2);
						os.setGoldUuid(inStock.getGoldUuid());
					}else{
						os.setBackStock(0);
					}
					os.setBoflag(5);
					od.updateboflag(os);
				}
			}
			super.commitTransaction();
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			super.endTransaction();
		}
		return 1;
	}

	public int cencle(InStock inStock) {
		InDetailDAO idao = new InDetailDAO();
		try {
			super.startTransaction();
			inStock.setSend(1);
			send(inStock);

			map.clear();
			map.put("lading_id", inStock.getUuid());
			inDetails = idao.list(map);
			if (inDetails != null) {
				for (int i = 0; i < inDetails.size(); i++) {
					inDetail = inDetails.get(i);
					map.clear();
					map.put("product_id", inDetail.getProduct_id());
					map.put("store_id", inStock.getStore_id());
					StockDAO stockd = new StockDAO();
					stock = (Stock) stockd.list(map).get(0);

					stock.setQuantity(stock.getQuantity() - inDetail.getNum());
					stockd.save(stock);// 改变库存

				}
			}
			if (inStock.getReason() == 4 && inStock.getGoreason()!=1) {//手动添加的调入单取消时修改出库状态
				OutStockDAO od = new OutStockDAO();
				OutStock os = new OutStock();
				os.setGoldUuid(inStock.getUuid());
				os.setBoflag(3);
				od.updateboflag(os);
			}
			
			List<InStock> spilts=new ArrayList<>();
			map.clear();
			map.put("uuid", inStock.getUuid());
			if(inStock.getSplit()==1){
				map.put("uuid", inStock.getSplitUuid());
			}else{
				map.put("uuid", inStock.getUuid());
			}
			spilts=this.listSplit(map);
			boolean falg=true;
			if(spilts.size()>1){//说明拆分过
				for(int i=0;i<spilts.size();i++){
					InStock s=new InStock();
					s=spilts.get(i);
					if(s.getSend()==1){//说明已取消入库
					}else{
						falg=false;
					}
				}
			}
			if(falg==false){//部分取消入库
				if(inStock.getGoreason()==1){//非手动填加来自出库单
					OutStockDAO od = new OutStockDAO();
					OutStock os = new OutStock();
					if(inStock.getSplit()==1){
						os.setGoldUuid(inStock.getSplitUuid());
					}else{
						os.setGoldUuid(inStock.getUuid());
					}
					os.setBoflag(4);
					od.updateboflag(os);
				}
			}else{//全部取消
				if(inStock.getGoreason()==1){//非手动填加
					OutStockDAO od = new OutStockDAO();
					OutStock os = new OutStock();
					if(inStock.getSplit()==1){
						os.setGoldUuid(inStock.getSplitUuid());
					}else{
						os.setGoldUuid(inStock.getUuid());
					}
					os.setBoflag(3);
					od.updateboflag(os);
				}
			}
			super.commitTransaction();
		} catch (Exception e) {
		} finally {
			super.endTransaction();
		}
		return 1;
	}

	public void addStock(Integer uuid, Integer store_id, Integer goldId, Integer reason, Integer goreason, List<Product> products) {
		// TODO Auto-generated method stub
		InDetailDAO idao = new InDetailDAO();
		Product p = new Product();
		// 填加主表
		InStock inStock = new InStock();
		Date d = new Date();
		String u = ContextHelper.getUserLoginUuid();
		String num = getMoveOrderNo(0);
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
		inStock.setGoldId(goldId);
		inStock.setGoflag(3);
		inStock.setSplit(0);
		add(inStock);

		// 修改出库表goldUid
		OutStockDAO od = new OutStockDAO();
		OutStock outs = new OutStock();
		outs.setUuid(uuid);
		outs.setGoldUuid(inStock.getUuid());
		od.mdygolduid(outs);

		// 填加子表s
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

	public void addStock(InStock ins, Integer spilt, Integer splitUuid, InDetail inDe,List<InDetail> inDes,Integer store_id, Integer num) {
		// TODO Auto-generated method stub
		try {
			InDetailDAO idao = new InDetailDAO();
			Product p = new Product();

			// 填加主表
			InStock inStock = new InStock();
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			String numb = getMoveOrderNo(0);
			inStock = ins;
			inStock.setUuid(null);
			inStock.setOrdernum(numb);
			if (spilt != null && spilt == 2) {
				inStock.setStore_id(inStock.getGoldId());
				inStock.setGoldId(store_id);
				inStock.setReason(6);
				inStock.setGoreason(1);
			}else{
				inStock.setStore_id(store_id);
			}
			inStock.setAdd_user(u);
			inStock.setAdd_timer(d);
			inStock.setLm_timer(d);
			inStock.setLm_user(u);
			if (spilt != null && spilt == 1) {
				inStock.setSplit(1);
				inStock.setSplitUuid(splitUuid);
			} else {
				inStock.setSplit(0);
			}
			add(inStock);

			// 填加子表s
			if(inDe!=null){
				// 修改被拆表商品数量及价格
				Double price = 0.00;
				InDetail ind = new InDetail();
				ind=inDe;
				ind.setNum(ind.getNum() - num);
				ind.setTotal(ind.getNum() * ind.getPrice());
				price = ind.getPrice();
				idao.save(ind);
				
				InDetail inDetail = new InDetail();
				inDetail.setLading_id(inStock.getUuid());
				inDetail.setProduct_id(inDe.getProduct_id());
				inDetail.setNum(num);
				inDetail.setPrice(price);
				inDetail.setTotal(num * price);
				idao.add(inDetail);
			}else{
				for(int i=0;i<inDes.size();i++){
					InDetail inDetail = new InDetail();
					inDetail=inDes.get(i);
					inDetail.setLading_id(inStock.getUuid());
					idao.add(inDetail);
				}
			}
			
			if (spilt != null && spilt == 1) {
			// 修改拆分主表的总价
			InStockDAO ldao = new InStockDAO();
			ldao.mdyTotalPrice(inStock.getUuid());
			// 修改被拆主表的总价
			ldao.mdyTotalPrice(ins.getUuid());
			}
		} catch (Exception e) {
			
		}

	}
	/**
	 * 还货
	 */
	public void bakeStock(InStock inStock,List<Product> produs,List<InDetail>inDetails){
		try {
			super.startTransaction();
			OutStockDAO isa = new OutStockDAO();
			//填加已确认的出库单
			isa.addStock(inStock.getUuid(),inStock.getStore_id(), inStock.getGoldId(),  8, 1, produs,null,true,ContextHelper.getUserLoginUuid(),ContextHelper.getUserLoginUuid());
			//填加待确认的入库单
			InStock insa=new InStock();
			insa=inStock;
			addStock(insa,2,inStock.getUuid(),null,inDetails,inStock.getStore_id(),0);
			super.commitTransaction();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			super.endTransaction();
		}
	}
	/**
	 * 产生流水号
	 */
	public String getMoveOrderNo(int num) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowdate = sdf.format(new Date());
		char[] a = nowdate.toCharArray();
		String m = "";
		for (int i = 0; i < a.length; i++) {
			if (Character.isDigit(a[i])) {
				m += a[i];
			}
		}
		m = m.substring(0, m.length() - 4);
		if (num == 1) {
			m = "C" + m;
		} else {
			m = "R" + m;
		}
		m = m + "000" + m.substring(m.length() - 1, m.length());
		System.out.println(m);
		return m;
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
