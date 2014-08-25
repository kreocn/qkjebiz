package com.qkj.ware.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.oracle.jrockit.jfr.Producer;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.ware.dao.CheckDAO;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.Check;
import com.qkj.ware.domain.Stock;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class CheckAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CheckAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CheckDAO dao = new CheckDAO();

	private Check check;
	private List<Check> checks;
	private List<Stock> stocks;
	private List<Stock> pageStocks;
	private List<Ware> wares;
	private List<Product> products;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	
	public List<Stock> getPageStocks() {
		return pageStocks;
	}

	public void setPageStocks(List<Stock> pageStocks) {
		this.pageStocks = pageStocks;
	}

	public Check getCheck() {
		return check;
	}

	public void setCheck(Check check) {
		this.check = check;
	}

	public List<Check> getChecks() {
		return checks;
	}

	public void setChecks(List<Check> checks) {
		this.checks = checks;
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

	public List<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(List<Stock> stocks) {
		this.stocks = stocks;
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
		ContextHelper.isPermit("QKJ_WARE_CHECK_LIST");
		try {
			map.clear();
			if (check != null)
				map.putAll(ToolsUtil.getMapByBean(check));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setChecks(dao.list(map));
			WareDAO wd=new WareDAO();
			this.setWares(wd.list(null));
			ProductDAO pd=new ProductDAO();
			this.setProducts(pd.list(null));
			this.setRecCount(dao.getResultCount());
			this.setCheck(null);
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
				this.setCheck(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				StockDAO sdao = new StockDAO();
				this.setStocks(sdao.list(null));
				this.setCheck(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(check == null || check.getUuid() == null)) {
					this.setCheck((Check) dao.get(check.getUuid()));
				} else {
					this.setCheck(null);
				}
			} else {
				this.setCheck(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_CHECK_ADD");
		try {
			if (!(pageStocks == null || pageStocks.size() == 0)) {
				for (int i = 0, n = pageStocks.size(); i < n; i++) {
					Stock s = pageStocks.get(i);
					check=new Check();
					check.setStock_id(s.getUuid());
					check.setProduct_id(s.getProduct_id());
					check.setStore_id(s.getStore_id());
					check.setDate(new Date());
					check.setQuantity(s.getQuantity());
					check.setNum(s.getCnum());
					dao.add(check);
				}
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_CHECK_MDY");
		try {
			// check.setLm_user(ContextHelper.getUserLoginUuid());
			// check.setLm_time(new Date());
			dao.save(check);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_CHECK_DEL");
		try {
			dao.delete(check);
			setMessage("删除成功!ID=" + check.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
