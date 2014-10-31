package com.qkj.ware.action;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.Stock;
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
	private List<Stock> inproducts;
	private String t=null;
	
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;库存管理";
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getT() {
		return t;
	}

	public void setT(String t) {
		this.t = t;
	}

	public List<Stock> getInproducts() {
		return inproducts;
	}

	public void setInproducts(List<Stock> inproducts) {
		this.inproducts = inproducts;
	}

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
		ContextHelper.isPermit("QKJ_WARE_STOCK_LIST");
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (stock != null)
				map.putAll(ToolsUtil.getMapByBean(stock));
				map.putAll(ContextHelper.getDefaultRequestMap4Page());
				this.setPageSize(ContextHelper.getPageSize(map));
				this.setCurrPage(ContextHelper.getCurrPage(map));		
				if(ContextHelper.isAdmin()){//管理员
					if(stock!=null&&stock.getGroupQ()!=0){//统计商品在所有仓库的数量
						map.put("product_id", stock.getGroupQ());
						this.setStocks(dao.listByGroup(map));
						t="1";
					}else{
						this.setStocks(dao.list(map));
					}
					
				}else{
					if(stock!=null&&stock.getGroupQ()!=0){//统计商品在所有仓库的数量
						map.put("product_id", stock.getGroupQ());
						map.put("username",u);
						map.put("dept_code", code);
						this.setStocks(dao.listPowerByGroup(map));
						t="1";
					}else{
						map.put("username",u);
						map.put("dept_code", code);
						this.setStocks(dao.listByPower(map));
					}
				}
				this.setInproducts(stocks);
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));
				
				wareByPower(u, code);
				
				this.setRecCount(dao.getResultCount());
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;库存列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	private void wareByPower(String u, String code) {
		WareDAO wd=new WareDAO();
		if(ContextHelper.isAdmin()){//管理员
			map.clear();
			map.put("type", "0");//非藏酒库
			this.setWares(wd.list(map));
		}else{
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			map.put("sel", 1);
			this.setWares(wd.listByPower(map));
		}
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
		ContextHelper.isPermit("QKJ_WARE_STOCK_ADD");
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
		ContextHelper.isPermit("QKJ_WARE_STOCK_MDY");
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
		ContextHelper.isPermit("QKJ_WARE_STOCK_DEL");
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
