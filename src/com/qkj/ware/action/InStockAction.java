package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.InDetailDAO;
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InStock;
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
	private List<InStock> inStocks;
	private List<Ware> wares;
	private List<Product> products;
	private List<InDetail> inDetails;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

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
		try {
			if (null == viewFlag) {
				this.setInStock(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInStock(null);
				WareDAO wd=new WareDAO();
				this.setWares(wd.list(null));
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
					this.setWares(wd.list(null));
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
			dao.delete(inStock);
			//删除详表
			InDetailDAO idao=new InDetailDAO();
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
}
