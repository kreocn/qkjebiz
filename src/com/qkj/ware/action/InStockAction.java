package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.InDetailDAO;
import com.qkj.ware.dao.InDetailHDAO;
import com.qkj.ware.dao.InStockHDAO;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InDetailH;
import com.qkj.ware.domain.InStock;
import com.qkj.ware.domain.InStockH;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.dao.InStockDAO;
import com.qkj.manage.dao.LadingItemDAO;
import com.qkj.manage.dao.LadingPayDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Lading;
import com.qkj.manage.domain.Product;
import com.qkjsys.ebiz.action.WareAction;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class InStockAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(InStockAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InStockDAO dao = new InStockDAO();
	
	private InStock inStock;
	private InStockH inStockh;
	private InDetailH inDetailh;
	private InDetail inDetail;
	private InStock inStock;
	private List<InStock> inStocks;
	private List<Ware> wares;
	private List<Product> products;
	private List<InDetail> inDetails;
	private Stock stock;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	
	public Stock getStock() {
		return stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}

	public InStock getInStock() {
		return inStock;
	}

	public void setInStock(InStock inStock) {
		this.inStock = inStock;
	}

	public List<InStock> getInStocks() {
		return inStocks;
	}

	public void setInStocks(List<InStock> inStocks) {
		this.inStocks = inStocks;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	

	

	public InDetail getInDetail() {
		return inDetail;
	}

	public void setInDetail(InDetail inDetail) {
		this.inDetail = inDetail;
	}

	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}
	

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
	

	public List<InDetail> getInDetails() {
		return inDetails;
	}

	public void setInDetails(List<InDetail> inDetails) {
		this.inDetails = inDetails;
	}
	
	
	public InStockH getInStockh() {
		return inStockh;
	}

	public void setInStockh(InStockH inStockh) {
		this.inStockh = inStockh;
	}

	public InDetailH getInDetailh() {
		return inDetailh;
	}

	public void setInDetailh(InDetailH inDetailh) {
		this.inDetailh = inDetailh;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_STOCK_INSTOCK");
		try {
			map.clear();
			if (inStock != null)
				map.putAll(ToolsUtil.getMapByBean(inStock));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setInStocks(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		String u = ContextHelper.getUserLoginUuid();
		try {
			if (null == viewFlag) {
				this.setInStock(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInStock(null);
				WareDAO wd=new WareDAO();
				if(ContextHelper.isAdmin()){//管理员
					map.clear();
					map.put("bug","bug");
					this.setWares(wd.list(map));
				}else{
					map.clear();
					map.put("useruuid",u);
					this.setWares(wd.listByPower(map));
				}
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag) || "print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", inStock.getUuid());
				if (null == map.get("uuid"))
					this.setInStock(null);
				else {
					if ("view".equals(viewFlag)) {
						map.put("status", 2);
					}
					this.setInStock((InStock)dao.list(map).get(0));
					WareDAO wd=new WareDAO();
					if(ContextHelper.isAdmin()){//管理员
						map.clear();
						map.put("bug","bug");
						this.setWares(wd.list(map));
					}else{
						map.clear();
						map.put("useruuid",u);
						this.setWares(wd.listByPower(map));
					}
					ProductDAO pdao = new ProductDAO();
					this.setProducts(pdao.list(null));
					InDetailDAO idao=new InDetailDAO();
					map.clear();
					map.put("lading_id", inStock.getUuid());
					this.setInDetails(idao.list(map));
				}
				
			} else {
				this.setInStock(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_INSTOCK_INSTOCK_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			if(inStock.getReason().equals(1)){
				inStock.setUuid(ToolsUtil.getCommonUUID("TR"));
			}else if(inStock.getReason().equals(2)){
				inStock.setUuid(ToolsUtil.getCommonUUID("TH"));
				inStock.setStore_id(6);
			}else{
				inStock.setUuid(ToolsUtil.getCommonUUID("R"));
			}
			inStock.setLm_user(u);
			inStock.setAdd_user(u);
			inStock.setLm_timer(new Date());
			inStock.setAdd_timer(d);
			dao.add(inStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_INSTOCK_INSTOCK_MDY");
		try {
			//inStock.setLm_user(ContextHelper.getUserLoginUuid());
			//inStock.setLm_time(new Date());
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			inStock.setLm_timer(new Date());
			inStock.setLm_user(u);
			dao.save(inStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_INSTOCK_INSTOCK_DEL");
		try {
			InStockHDAO hdao=new InStockHDAO();
			this.setInStock((InStock)dao.get(inStock.getUuid()));
			this.setInStockh(inStock);
			hdao.add(inStockh);//填加到历史
			dao.delete(inStock);
			//删除详表 
			
			
			InDetailDAO idao=new InDetailDAO();
			map.clear();
			map.put("lading_id", inStock.getUuid());
			this.setInDetails(idao.list(map));
			if(inDetails!=null){
				for(int i=0;i<inDetails.size();i++){
					this.setInDetail((InDetail)dao.get(inDetail.getUuid()));
					this.setInDetailh(inDetail);
					hdao.add(inDetailh);
					
					map.clear();
					map.put("product_id", inDetail.getProduct_id());
					map.put("store_id", inStock.getStore_id());
					StockDAO stockd=new StockDAO();
					this.setStock((Stock)stockd.list(map).get(0));
					
					stock.setQuantity(stock.getQuantity()-inDetail.getNum());
					stockd.save(stock);//改变库存
		
					
					
				}
			}
			
			map.clear();
			map.put("lading_id", inStock.getUuid());
			idao.delLading(map);
			setMessage("删除成功!ID=" + inStock.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	private void setInDetailh(InDetail inDetail2) {
		// TODO Auto-generated method stub
		inDetailh=new InDetailH();
		inDetailh.setLading_id(inDetail2.getLading_id());
		inDetailh.setNum(inDetail2.getNum());
		inDetailh.setPrice(inDetail2.getPrice());
		inDetailh.setProduct_id(inDetail2.getProduct_id());
		inDetailh.setTotal(inDetail2.getTotal());
		
	}

	private void setInStockh(InStock inStock2) {
		// TODO Auto-generated method stub
		inStockh=new InStockH();
		inStockh.setAdd_timer(inStock2.getAdd_timer());
		inStockh.setAdd_user(inStock2.getAdd_user());
		inStockh.setConfirm(inStock2.getConfirm());
		inStockh.setConname(inStock2.getConname());
		inStockh.setContime(inStock2.getContime());
		inStockh.setDate(inStock2.getDate());
		inStockh.setLm_timer(inStock2.getLm_timer());
		inStockh.setLm_user(inStock2.getLm_user());
		inStockh.setNote(inStock2.getNote());
		inStockh.setOperator_id(inStock2.getOperator_id());
		inStockh.setReason(inStock2.getReason());
		inStockh.setStore_id(inStock2.getStore_id());
		inStockh.setTake_id(inStock2.getTake_id());
		inStockh.setTotal_price(inStock2.getTotal_price());
		inStockh.setUuid(inStock2.getUuid());
	}
	
	//确认
		public String sure() throws Exception {
				ContextHelper.isPermit("QKJ_INSTOCK_INSTOCK_ADD");
				String u = ContextHelper.getUserLoginUuid();
				try {
					inStock.setConfirm(1);
					inStock.setConname(u);
					inStock.setContime(new Date());
					dao.sure(inStock);
				} catch (Exception e) {
					log.error(this.getClass().getName() + "!save 数据更新失败:", e);
					throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
				}
				return SUCCESS;
			}
}
