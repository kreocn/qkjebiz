package com.qkj.outStock.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.inDetail.dao.InDetailDAO;
import com.qkj.inStock.domain.InStock;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.outDetail.dao.OutDetailDAO;
import com.qkj.outDetail.domain.OutDetail;
import com.qkj.outStock.domain.OutStock;
import com.qkj.outStock.dao.OutStockDAO;
import com.qkj.stock.dao.StockDAO;
import com.qkj.stock.domain.Stock;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class OutStockAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OutStockAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OutStockDAO dao = new OutStockDAO();

	private OutStock outStock;
	private List<Stock> stocks;
	private List<OutStock> outStocks;
	private List<OutDetail> outDetails;
	private OutDetail outDetail;
	private List<Ware> wares;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public OutStock getOutStock() {
		return outStock;
	}

	public void setOutStock(OutStock outStock) {
		this.outStock = outStock;
	}

	public List<OutStock> getOutStocks() {
		return outStocks;
	}

	public void setOutStocks(List<OutStock> outStocks) {
		this.outStocks = outStocks;
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
	

	public List<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(List<Stock> stocks) {
		this.stocks = stocks;
	}
	

	public List<OutDetail> getOutDetails() {
		return outDetails;
	}

	public void setOutDetails(List<OutDetail> outDetails) {
		this.outDetails = outDetails;
	}

	public OutDetail getOutDetail() {
		return outDetail;
	}

	public void setOutDetail(OutDetail outDetail) {
		this.outDetail = outDetail;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_STOCK_OUTSTOCK");
		try {
			map.clear();
			if (outStock != null)
				map.putAll(ToolsUtil.getMapByBean(outStock));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setOutStocks(dao.list(map));
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
				this.setOutStock(null);
				setMessage("你没有选择任何操作!");
			}else if("new".equals(viewFlag)){
				//出库仓库
				WareDAO wd=new WareDAO();
				this.setWares(wd.list(null));
				this.setOutStock(null);
			}else if ("add".equals(viewFlag)) {
				WareDAO wd=new WareDAO();
				this.setWares(wd.list(null));
				this.setOutStock(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("ordernum", outStock.getOrdernum());
				if (null == map.get("ordernum"))
					this.setOutStock(null);
				else {
					if ("view".equals(viewFlag)) {
						map.put("status", 2);
					}
					this.setOutStock((OutStock)dao.list(map).get(0));
					WareDAO wd=new WareDAO();
					this.setWares(wd.list(null));
					
					StockDAO sdao=new StockDAO();
					this.setStocks(sdao.listBig(null));
					/*InDetailDAO idao=new InDetailDAO();
					map.clear();
					map.put("lading_id", inStock.getUuid());
					this.setInDetails(idao.list(map));*/
				}
			} else {
				this.setOutStock(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		if(null == viewFlag){
			return "success";
		}else if("add".equals(viewFlag)){
			return "add";
		}else if("mdy".equals(viewFlag)){
			return "add";
		}
		else{
			return "success";
		}
		
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_OUTSTOCK_OUTSTOCK_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			if(outStock.getReason().equals(0)){
				outStock.setOrdernum(ToolsUtil.getCommonUUID("XC"));
			}else if(outStock.getReason().equals(1)){
				outStock.setOrdernum(ToolsUtil.getCommonUUID("DC"));
				outStock.setStore_id(6);
			}else if(outStock.getReason().equals(2)){
				outStock.setOrdernum(ToolsUtil.getCommonUUID("JC"));
				outStock.setStore_id(6);
			}else{
				outStock.setOrdernum(ToolsUtil.getCommonUUID("SC"));
			}
			outStock.setSend(2);
			outStock.setAdd_user(u);
			outStock.setAdd_timer(d);
			outStock.setLm_user(u);
			outStock.setLm_timer(new Date());
			dao.add(outStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_OUTSTOCK_OUTSTOCK_MDY");
		try {
			//outStock.setLm_user(ContextHelper.getUserLoginUuid());
			//outStock.setLm_time(new Date());
			dao.save(outStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_OUTSTOCK_OUTSTOCK_DEL");
		try {
			dao.delete(outStock);
			setMessage("删除成功!ID=" + outStock.getUuid());
			OutDetailDAO odao=new OutDetailDAO();
			//修改库存
			StockDAO stockdao=new StockDAO();
			map.clear();
			map.put("lading_id",outStock.getOrdernum());
			this.setOutDetails(odao.list(map));
			if(outDetails.size()>0){
				for(int i=0;i<=outDetails.size();i++){
					this.setOutDetail(outDetails.get(i));
					map.clear();
					map.put("uuid", outDetail.getProduct_id());
					map.put("lading_id", outStock.getOrdernum());
					stockdao.updateTotle(map);
				}
			}
			
			//删除详表
			map.clear();
			map.put("lading_id",outStock.getOrdernum());
			odao.deleteByLading(map);
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
