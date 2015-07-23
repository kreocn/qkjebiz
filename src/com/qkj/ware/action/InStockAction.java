package com.qkj.ware.action;

import java.util.ArrayList;
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
import com.qkj.ware.dao.OutStockDAO;
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
	private InDetailDAO idao = new InDetailDAO();

	private InStock inStock;
	private Warepowers warep;
	private InStockH inStockh;
	private InDetailH inDetailh;
	private InDetail inDetail;
	private List<InStock> inStocks;
	private List<Ware> wares;
	private List<Product> products;
	private List<InDetail> inDetails;
	private List<Warepowers> wps;
	private Stock stock;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private Stock newStock;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;入库管理";

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
		WareDAO wd = new WareDAO();
		Map<String, Object> mapware = new HashMap<String, Object>();
		try {
			map.clear();
			if (inStock != null) {
				map.putAll(ToolsUtil.getMapByBean(inStock));
			}
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));

			this.setWps(warepower.checkWarePower());
			mapware.clear();
			if (wps != null && wps.size() > 0) {
				List<Integer> ud_list = new ArrayList<>();
				for (int i = 0; i < wps.size(); i++) {
					if (wps.get(i).getPrvg().contains("1")) {// 有入库权限则有入库单查询权限
						ud_list.add(wps.get(i).getWare_id());
					}
				}
				map.put("storeids", ud_list);
				mapware.put("uuids", ud_list);
			}
			this.setInStocks(dao.list(map));
			this.setWares(wd.list(mapware));

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
		try {
			if (null == viewFlag) {
				this.setInStock(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInStock(null);
				getWare();
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/inStock/inStock_list'>入库列表</a>&nbsp;&gt;&nbsp;增加入库";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag) || "print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", inStock.getUuid());
				if (null == map.get("uuid")) this.setInStock(null);
				else {
					this.setInStock((InStock) dao.list(map).get(0));
					getWare();
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

	private void getWare() {
		WareDAO wd = new WareDAO();
		Map<String, Object> mapware = new HashMap<String, Object>();
		this.setWps(warepower.checkWarePower());
		mapware.clear();
		if (wps != null && wps.size() > 0) {
			List<Integer> ud_list = new ArrayList<>();
			for (int i = 0; i < wps.size(); i++) {
				if (wps.get(i).getPrvg().contains("1")) {// 有入库权限则有入库单查询权限
					ud_list.add(wps.get(i).getWare_id());
				}
			}
			mapware.put("uuids", ud_list);
		}
		this.setWares(wd.list(mapware));
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
			inStock.setSplit(0);
			inStock.setGoflag(0);
			inStock.setGoreason(0);
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

	public String addOut() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_ADD");
		try {
			// 如何是调入仓库自动生成对方的调出仓库单
			dao.startTransaction();
			ProductDAO pd = new ProductDAO();
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
					pros = pd.list(map);
					if (pros.size() > 0) {
						pdi = pros.get(0);
						pdi.setNum(inDetail.getNum());
						pdi.setDprice(inDetail.getPrice());
						pdi.setDtotle(inDetail.getTotal());
						produs.add(pdi);
					}
				}
			}
			if (inStock.getReason() == 4) {
				OutStockDAO isa = new OutStockDAO();
				isa.addStock(inStock.getUuid(), inStock.getGoldId(), inStock.getStore_id(), 6, 1, produs,null);
			}
			//修改goflag2出库单生成成功
			inStock.setGoflag(2);
			dao.mdyGodFlog(inStock);
			dao.commitTransaction();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		} finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_MDY");
		try {
			// inStock.setLm_user(ContextHelper.getUserLoginUuid());
			// inStock.setLm_time(new Date());
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

	/**
	 * 确认订单20150603sun
	 * 
	 * @return
	 * @throws Exception
	 */
	public String sure() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_ADD");
		this.setInStock((InStock) dao.get(inStock.getUuid()));
		dao.sure(inStock);
		return SUCCESS;
	}

	/**
	 * 取消订单20150603sun
	 * 
	 * @return
	 * @throws Exception
	 */
	public String cencle() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_CENCLE");
		this.setInStock((InStock) dao.get(inStock.getUuid()));
		dao.cencle(inStock);
		return SUCCESS;
	}
	
	/**
	 * 拆分20150715
	 * @return
	 * @throws Exception
	 */
	public String inSpilt() throws Exception{
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_SPILT");
		InStock ins=new InStock();
		ins=(InStock)dao.get(inStock.getUuid());
		this.setInDetail((InDetail) idao.get(inDetail.getUuid()));
		dao.addStock(ins,1,inStock.getUuid(),inDetail,inStock.getStore_id(),inStock.getSplitNum());
		return SUCCESS;
	}
	
	public String mdyRemark() throws Exception{
		inStock.setRemark("仓库编号"+inStock.getStore_id()+"转入"+inStock.getStore_idR());
		inStock.setStore_id(inStock.getStore_idR());
		dao.mdyRemark(inStock);
		return SUCCESS;
	}

}
