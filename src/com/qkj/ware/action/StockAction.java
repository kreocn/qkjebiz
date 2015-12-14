package com.qkj.ware.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.Product;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.domain.Warepowers;
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
	private List<Warepowers> wps;
	private List<Product> products;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private List<Stock> inproducts;
	
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;库存管理";
	
	public List<Warepowers> getWps() {
		return wps;
	}

	public void setWps(List<Warepowers> wps) {
		this.wps = wps;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
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
		WareDAO wd = new WareDAO();
		Map<String, Object> mapware = new HashMap<String, Object>();
		try {
			map.clear();
			if (stock != null)
				map.putAll(ToolsUtil.getMapByBean(stock));
				map.putAll(ContextHelper.getDefaultRequestMap4Page());
				this.setPageSize(ContextHelper.getPageSize(map));
				this.setCurrPage(ContextHelper.getCurrPage(map));		
				this.setWps(warepower.checkWarePower());
				if(!ContextHelper.isAdmin()||wps!=null && wps.size()>0){
					List<Integer> ud_list = new ArrayList<>();
					for(int i=0;i<wps.size();i++){
						if(wps.get(i).getPrvg().contains("4")){//有查询权限
							ud_list.add(wps.get(i).getWare_id());
						}
					}
					if(ud_list.size()>0){
					}else{
						ud_list.add(0);
					}
					map.put("storeids", ud_list);
					mapware.put("uuids", ud_list);
				}
				this.setStocks(dao.list(map));
				this.setWares(wd.list(mapware));
				
				this.setInproducts(stocks);
				
				//ProductDAO pdao = new ProductDAO();
				//this.setProducts(pdao.list(null));
				
				
				this.setRecCount(dao.getResultCount());
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;库存列表";
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
	
	//根据仓库及产品查询库存：出库详情中使用
	public void getStorPro() throws Exception{
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			HttpServletRequest request = ServletActionContext.getRequest();
			String store_id = request.getParameter("store_id");
			String pro_id=request.getParameter("pro_id");
			map.clear();
			map.put("store_id", store_id);
			map.put("product_id", pro_id);
			List<Stock> s=new ArrayList<>();
			s=dao.list(map);
			Stock st=new Stock();
			if(s.size()>0){
				st=s.get(0);
			}
			ServletActionContext.getResponse().getWriter().print(st.getQuantity());
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
}
