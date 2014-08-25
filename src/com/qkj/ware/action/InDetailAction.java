package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.InDetail;
import com.qkj.ware.domain.InDetailH;
import com.qkj.ware.dao.InDetailDAO;
import com.qkj.ware.dao.InDetailHDAO;
import com.qkj.ware.dao.InStockDAO;
import com.qkj.ware.domain.InStock;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.Stock;

public class InDetailAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(InDetailAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InDetailDAO dao = new InDetailDAO();

	private InDetail inDetail;
	private InDetailH inDetailh;
	private List<InDetail> inDetails;
	private Stock stock;
	private Stock newStock;
	private InStock inStock;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public InDetail getInDetail() {
		return inDetail;
	}

	public void setInDetail(InDetail inDetail) {
		this.inDetail = inDetail;
	}

	public List<InDetail> getInDetails() {
		return inDetails;
	}

	public void setInDetails(List<InDetail> inDetails) {
		this.inDetails = inDetails;
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
	
	
	public Stock getNewStock() {
		return newStock;
	}

	public void setNewStock(Stock newStock) {
		this.newStock = newStock;
	}
	
	
	public InDetailH getInDetailh() {
		return inDetailh;
	}

	public void setInDetailh(InDetailH inDetailh) {
		this.inDetailh = inDetailh;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_LIST");
		try {
			map.clear();
			if (inDetail != null)
				map.putAll(ToolsUtil.getMapByBean(inDetail));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setInDetails(dao.list(map));
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
				this.setInDetail(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setInDetail(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(inDetail == null || inDetail.getUuid() == null)) {
					this.setInDetail((InDetail) dao.get(inDetail.getUuid()));
				} else {
					this.setInDetail(null);
				}
			} else {
				this.setInDetail(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_ADD");
		try {
			//inDetail.setLm_user(ContextHelper.getUserLoginUuid());
			//inDetail.setLm_time(new Date());
			dao.add(inDetail);
			InStockDAO ldao=new InStockDAO();
			ldao.mdyTotalPrice(inDetail.getLading_id());
			
			//查询库存同一仓库中是否有此商品
			StockDAO stockdao=new StockDAO();
			map.clear();
			map.put("product_id", inDetail.getProduct_id());
			InStockDAO insdao=new InStockDAO();
			inStock=(InStock)insdao.get(inDetail.getLading_id());
			map.put("store_id", inStock.getStore_id());
			this.setStock((Stock)stockdao.fingByPro(map));
			//填加库存信息(己有修改库存，没有填加)
			newStock=new Stock();
			if(stock!=null){
				stock.setQuantity(stock.getQuantity()+inDetail.getNum());
				stockdao.save(stock);
			}else{
				int pro=inDetail.getProduct_id();
				int num=inDetail.getNum();
				int stor=inStock.getStore_id();
				newStock.setProduct_id(pro);
				newStock.setQuantity(num);
				newStock.setStore_id(stor);
				stockdao.add(newStock);
			}
			
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_MDY");
		try {
			//inDetail.setLm_user(ContextHelper.getUserLoginUuid());
			//inDetail.setLm_time(new Date());
			dao.save(inDetail);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_INSTOCK_DEL");
		try {
			InDetailHDAO hdao=new InDetailHDAO();
			this.setInDetail((InDetail)dao.get(inDetail.getUuid()));
			this.setInDetailh(inDetail);
			hdao.add(inDetailh);
			dao.delete(inDetail);
			//修改库存
			StockDAO stockdao=new StockDAO();
			stock.setQuantity(stock.getQuantity()-inDetail.getNum());
			stockdao.save(stock);
			//修改入库主表的总数量
			InStockDAO insdao=new InStockDAO();
			inStock=(InStock)insdao.get(inDetail.getLading_id());
			map.put("store_id", inStock.getStore_id());
			stock.setQuantity(stock.getQuantity()-inDetail.getNum());
			insdao.save(stock);
			setMessage("删除成功!ID=" + inDetail.getUuid());
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
}
