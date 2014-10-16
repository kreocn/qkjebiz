package com.qkj.ware.action;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.OutDetailDAO;
import com.qkj.ware.dao.OutDetailHDAO;
import com.qkj.ware.dao.OutStockDAO;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.OutDetail;
import com.qkj.ware.domain.OutDetailH;
import com.qkj.ware.domain.OutStock;
import com.qkj.ware.domain.Stock;

public class OutDetailAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OutDetailAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OutDetailDAO dao=new OutDetailDAO();

	private OutDetail outDetail;
	private OutDetailH outDetailh;
	private OutStock outStock;
	private Stock stock;
	private List<OutDetail> outDetails;
	private OutStock newoutdStock;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	
	


	public OutDetailH getOutDetailh() {
		return outDetailh;
	}

	public void setOutDetailh(OutDetailH outDetailh) {
		this.outDetailh = outDetailh;
	}

	public OutDetail getOutDetail() {
		return outDetail;
	}

	public void setOutDetail(OutDetail outDetail) {
		this.outDetail = outDetail;
	}

	public List<OutDetail> getOutDetails() {
		return outDetails;
	}

	public void setOutDetails(List<OutDetail> outDetails) {
		this.outDetails = outDetails;
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
	

	public OutStock getNewoutdStock() {
		return newoutdStock;
	}

	public void setNewoutdStock(OutStock newoutdStock) {
		this.newoutdStock = newoutdStock;
	}

	public OutStock getOutStock() {
		return outStock;
	}

	public void setOutStock(OutStock outStock) {
		this.outStock = outStock;
	}
	
	

	public Stock getStock() {
		return stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_LIST");
		try {
			map.clear();
			if (outDetail != null)
				map.putAll(ToolsUtil.getMapByBean(outDetail));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setOutDetails(dao.list(map));
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
				this.setOutDetail(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setOutDetail(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(outDetail == null || outDetail.getUuid() == null)) {
					this.setOutDetail((OutDetail) dao.get(outDetail.getUuid()));
				} else {
					this.setOutDetail(null);
				}
			} else {
				this.setOutDetail(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_ADD");
		try {
			//判断库存是否足够
			StockDAO stockdao=new StockDAO();
			map.clear();
			map.put("uuid", outDetail.getProduct_id());//出库祥表的product_id是库存id
			this.setStock((Stock)stockdao.fingByPro(map));
			int quan=(stock.getQuantity()-stock.getFreezeNum())-outDetail.getNum();
			stock.setQuantity(quan);
			if(quan>=0){
				//stockdao.save(stock);
				
				//修改出库主表
				OutStockDAO sdao=new OutStockDAO();
				this.setNewoutdStock((OutStock)sdao.get(outDetail.getLading_id()));
				if(newoutdStock.getReason()!=3){//不是报损
					double num=0;
					if(newoutdStock.getTotal_price()==null){
						num=0;
					}else{
						num=newoutdStock.getTotal_price();
					}
					double num2=outDetail.getTotel();
					outStock=new OutStock();
					outStock.setTotal_price(num+num2);//总价
					outStock.setUuid(newoutdStock.getUuid());
					sdao.saveTotal(outStock);
				}
				//填加祥表
				dao.add(outDetail);
				
			}else{
				setMessage("1");
			}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_MDY");
		try {
			//outDetail.setLm_user(ContextHelper.getUserLoginUuid());
			//outDetail.setLm_time(new Date());
			dao.save(outDetail);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_DEL");
		try {
			this.setOutDetail((OutDetail)dao.get(outDetail.getUuid()));
			OutDetailHDAO hd=new OutDetailHDAO();
			this.setOutDetailh(outDetail);
			hd.add(outDetailh);//填加历史
			setMessage("删除成功!ID=" + outDetail.getUuid());
			//修改库存
			StockDAO stockdao=new StockDAO();
			stock=(Stock)stockdao.get(outDetail.getProduct_id());
			stock.setQuantity(stock.getQuantity()+outDetail.getNum());
			stockdao.save(stock);
			//修改出库主表的总价格
			OutStockDAO insdao=new OutStockDAO();
			map.clear();
			map.put("uuid", outDetail.getLading_id());
			outStock=(OutStock)insdao.list(map).get(0);
			outStock.setTotal_price(outStock.getTotal_price()-outDetail.getTotel());
			if(outStock.getReason()!=3){
				insdao.save(outStock);
			}
			//删除祥表
			
			dao.delete(outDetail);
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	private void setOutDetailh(OutDetail outDetail2) {
		// TODO Auto-generated method stub
		outDetailh=new OutDetailH();
		outDetailh.setLading_id(outDetail2.getLading_id());
		outDetailh.setNum(outDetail2.getNum());
		outDetailh.setPrice(outDetail2.getPrice());
		outDetailh.setProduct_id(outDetail2.getProduct_id());
		outDetailh.setTotel(outDetail2.getTotel());
		
	}

	
}
