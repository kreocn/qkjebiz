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
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.ware.dao.InDetailDAO;
import com.qkj.ware.dao.InStockDAO;
import com.qkj.ware.dao.InStockHDAO;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InDetailH;
import com.qkj.ware.domain.InStock;
import com.qkj.ware.domain.InStockH;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.domain.Warepowers;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class InStockAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(InStockAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InStockDAO dao = new InStockDAO();

	private InStock inStock;
	private Warepowers warep;
	private InStockH inStockh;
	private InDetailH inDetailh;
	private InDetail inDetail;
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
	private Stock newStock;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;入库管理";
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Stock getNewStock() {
		return newStock;
	}

	public void setNewStock(Stock newStock) {
		this.newStock = newStock;
	}

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

	public Warepowers getWarep() {
		return warep;
	}

	public void setWarep(Warepowers warep) {
		this.warep = warep;
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
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_LIST");
		String u = ContextHelper.getUserLoginUuid();
		String code = ContextHelper.getUserLoginDept();
		WareDAO wd = new WareDAO();
		try {
			map.clear();
			if (inStock != null) {
				if (inStock != null && inStock.getReason() == -1) {
					inStock.setReason(null);
				}
				if (inStock != null && inStock.getSend() == -1) {
					inStock.setSend(null);
				}
				map.putAll(ToolsUtil.getMapByBean(inStock));
			}
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));

			if (ContextHelper.isAdmin()) {// 管理员
				map.put("type", "0");//非藏酒库
				this.setInStocks(dao.list(map));
				this.setWares(wd.list(map));
			} else {
				map.put("username", u);
				map.put("dept_code", code);
				this.setInStocks(dao.listbypo(map));
				map.clear();
				map.put("username", u);
				map.put("dept_code", code);
				map.put("sel", 1);
				this.setWares(wd.listByPower(map));
			}

			this.setInStock(null);

			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;入库列表";
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
		String code = ContextHelper.getUserLoginDept();
		try {
			if (null == viewFlag) {
				this.setInStock(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInStock(null);
				wareByPower(u, code);
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/inStock/inStock_list'>入库列表</a>&nbsp;&gt;&nbsp;增加入库";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag)
					|| "print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", inStock.getUuid());
				if (null == map.get("uuid"))
					this.setInStock(null);
				else {
					if ("view".equals(viewFlag)) {
						map.put("status", 2);
					}
					this.setInStock((InStock) dao.list(map).get(0));
					wareByPower(u, code);
					ProductDAO pdao = new ProductDAO();
					this.setProducts(pdao.list(null));
					InDetailDAO idao = new InDetailDAO();
					map.clear();
					map.put("lading_id", inStock.getUuid());
					this.setInDetails(idao.list(map));
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/inStock/inStock_list'>入库列表</a>&nbsp;&gt;&nbsp;入库详情";
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

	private void wareByPower(String u, String code) {
		WareDAO wd = new WareDAO();
		if (ContextHelper.isAdmin()) {// 管理员
			map.clear();
			map.put("type", "0");//非藏酒库
			this.setWares(wd.list(map));
		} else {
			map.clear();
			map.put("username", u);
			map.put("dept_code", code);
			map.put("add", 1);
			this.setWares(wd.listByPower(map));
		}
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			if (inStock.getReason().equals(1)) {
			} else if (inStock.getReason().equals(2)) {
				inStock.setStore_id(6);
			} else {
			}
			inStock.setTake_id(u);
			inStock.setOperator_id(u);
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
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_MDY");
		try {
			// inStock.setLm_user(ContextHelper.getUserLoginUuid());
			// inStock.setLm_time(new Date());
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

	public String cencle() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_CENCLE");
		try {
			inStock.setSend(1);
			dao.send(inStock);
			// 删除详表
			InDetailDAO idao = new InDetailDAO();
			map.clear();
			map.put("lading_id", inStock.getUuid());
			this.setInDetails(idao.list(map));
			if (inDetails != null) {
				for (int i = 0; i < inDetails.size(); i++) {
					this.setInDetail(inDetails.get(i));
					map.clear();
					map.put("product_id", inDetail.getProduct_id());
					map.put("store_id", inStock.getStore_id());
					StockDAO stockd = new StockDAO();
					this.setStock((Stock) stockd.list(map).get(0));

					stock.setQuantity(stock.getQuantity() - inDetail.getNum());
					stockd.save(stock);// 改变库存

				}
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_DEL");
		try {
			InStockHDAO hdao = new InStockHDAO();
			// 删除详表
			InDetailDAO idao = new InDetailDAO();

			map.clear();
			map.put("lading_id", inStock.getUuid());
			idao.delLading(map);
			dao.delete(inStock);
			setMessage("删除成功!ID=" + inStock.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	private void setInDetailh(InDetail inDetail2) {
		// TODO Auto-generated method stub
		inDetailh = new InDetailH();
		inDetailh.setLading_id(inDetail2.getLading_id());
		inDetailh.setNum(inDetail2.getNum());
		inDetailh.setPrice(inDetail2.getPrice());
		inDetailh.setProduct_id(inDetail2.getProduct_id());
		inDetailh.setTotal(inDetail2.getTotal());

	}

	private void setInStockh(InStock inStock2) {
		// TODO Auto-generated method stub
		inStockh = new InStockH();
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
		inStockh.setOrdernum(inStock2.getOrdernum());
	}

	// 确认
	public String sure() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_ADD");
		String u = ContextHelper.getUserLoginUuid();
		try {
			// 修改库存
			this.setInStock((InStock) dao.get(inStock.getUuid()));

			InDetailDAO idao = new InDetailDAO();
			map.clear();
			map.put("lading_id", inStock.getUuid());
			this.setInDetails(idao.list(map));

			if (inDetails != null && inDetails.size() > 0) {
				for (int i = 0; i < inDetails.size(); i++) {
					inDetail = new InDetail();
					this.setInDetail(inDetails.get(i));
					// 查询库存同一仓库中是否有此商品
					StockDAO stockdao = new StockDAO();
					map.clear();
					map.put("product_id", inDetail.getProduct_id());
					map.put("store_id", inStock.getStore_id());
					this.setStock((Stock) stockdao.fingByPro(map));

					// 填加库存信息(己有修改库存，没有填加)
					newStock = new Stock();
					if (stock != null) {
						stock.setQuantity(stock.getQuantity()
								+ inDetail.getNum());
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
			dao.sure(inStock);

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
