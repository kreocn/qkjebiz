package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.dao.StockDAO;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class StockAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(StockAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private StockDAO dao = new StockDAO();

	private Stock stock;
	private List<Stock> stocks;
	private List<Ware> wares;
	private List<Product> products;
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

	public List<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(List<Stock> stocks) {
		this.stocks = stocks;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_STOCK_STOCK");
		try {
			map.clear();
			if (stock != null)
				map.putAll(ToolsUtil.getMapByBean(stock));
				map.putAll(ContextHelper.getDefaultRequestMap4Page());
				this.setPageSize(ContextHelper.getPageSize(map));
				this.setCurrPage(ContextHelper.getCurrPage(map));		
				this.setStocks(dao.list(map));
				WareDAO wd=new WareDAO();
				ProductDAO pdao = new ProductDAO();
				this.setWares(wd.list(null));
				this.setProducts(pdao.list(null));
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
				this.setStock(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setStock(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(stock == null || stock.getUuid() == null)) {
					this.setStock((Stock) dao.get(stock.getUuid()));
				} else {
					this.setStock(null);
				}
			} else {
				this.setStock(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_STOCK_STOCK_ADD");
		try {
			//stock.setLm_user(ContextHelper.getUserLoginUuid());
			//stock.setLm_time(new Date());
			dao.add(stock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_STOCK_STOCK_MDY");
		try {
			//stock.setLm_user(ContextHelper.getUserLoginUuid());
			//stock.setLm_time(new Date());
			dao.save(stock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_STOCK_STOCK_DEL");
		try {
			dao.delete(stock);
			setMessage("删除成功!ID=" + stock.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
