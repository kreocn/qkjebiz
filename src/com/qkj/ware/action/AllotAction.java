package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.domain.Allot;
import com.qkj.ware.dao.AllotDAO;
import com.qkj.ware.dao.AllotDetailDAO;
import com.qkj.ware.domain.AllotDetail;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class AllotAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AllotAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AllotDAO dao = new AllotDAO();

	private Allot allot;
	private Stock stock;//
	private AllotDetail allotDetail;
	private List<Allot> allots;
	private List<Allot> allotss;
	private List<AllotDetail> allotDetails;
	private List<Ware> wares;
	private List<Stock> stocks;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public Allot getAllot() {
		return allot;
	}

	public void setAllot(Allot allot) {
		this.allot = allot;
	}

	public List<Allot> getAllots() {
		return allots;
	}

	public void setAllots(List<Allot> allots) {
		this.allots = allots;
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
	

	public List<AllotDetail> getAllotDetails() {
		return allotDetails;
	}

	public void setAllotDetails(List<AllotDetail> allotDetails) {
		this.allotDetails = allotDetails;
	}
	
	public AllotDetail getAllotDetail() {
		return allotDetail;
	}

	public void setAllotDetail(AllotDetail allotDetail) {
		this.allotDetail = allotDetail;
	}
	
	public Stock getStock() {
		return stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_LIST");
		try {
			map.clear();
			if (allot != null)
				map.putAll(ToolsUtil.getMapByBean(allot));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setAllots(dao.list(map));
			this.setRecCount(dao.getResultCount());
			//仓库
			WareDAO wd=new WareDAO();
			this.setWares(wd.list(null));
			this.setAllot(null);
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
				this.setAllot(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAllot(null);
				WareDAO wd=new WareDAO();
				this.setWares(wd.list(null));
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("ordernum", allot.getOrdernum());
				if (!(allot == null || allot.getUuid() == null)||null!=map.get("ordernum")) {
					if(allot.getUuid()!=null){
						this.setAllot((Allot) dao.get(allot.getUuid()));
					}else{
						this.setAllot((Allot)dao.list(map).get(0));
					}
					//仓库
					WareDAO wd=new WareDAO();
					this.setWares(wd.list(null));
					//库存
					StockDAO sdao=new StockDAO();
					map.clear();
					map.put("store_id", allot.getSourceid());
					this.setStocks(sdao.listBig(map));
					//祥表
					AllotDetailDAO adao=new AllotDetailDAO();
					map.clear();
					map.put("lading_id", allot.getOrdernum());
					this.setAllotDetails(adao.list(map));
					
				} else {
					this.setAllot(null);
				}
			} else {
				this.setAllot(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			allot.setOrdernum(ToolsUtil.getCommonUUID("A"));
			allot.setLm_user(u);
			allot.setAdd_user(u);
			allot.setLm_timer(new Date());
			allot.setAdd_timer(d);
			dao.add(allot);
			map.clear();
			map.put("ordernum", allot.getOrdernum());
			this.setAllot((Allot)dao.list(map).get(0));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_MDY");
		try {
			allot.setLm_user(ContextHelper.getUserLoginUuid());
			allot.setLm_timer(new Date());
			dao.save(allot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String freeze() throws Exception{
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_MDY");
		try {
			//检查库存是否足够
			AllotDetailDAO addao=new AllotDetailDAO();
			map.clear();
			map.put("lading_id", allot.getOrdernum());
			this.setAllotDetails(addao.list(map));
			if(allotDetails.size()>0){
				for(int i=0;i<allotDetails.size();i++){
					this.setAllotDetail(allotDetails.get(i));
					StockDAO sdao=new StockDAO();
					this.setStock((Stock)sdao.get(allotDetail.getStock_id()));
					if(stock.getQuantity()<allotDetail.getNum()){
						//不足，反回
						setMessage("库存不足!不能发货!ID=" + allotDetail.getUuid());
						return SUCCESS;
					}else{
						//足够，冻结库存
						map.clear();
						map.put("uuid", stock.getUuid());
						map.put("freezeNum", allotDetail.getNum());
						sdao.updateFreezeNumById(map);
					}
				}
				
				//状态为已发货
				allot.setUuid(allot.getUuid());
				allot.setState(1);
				dao.updateState(allot);
			}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
		
	}
	
	//收货
	public String delivery() throws Exception{
		AllotDetailDAO addao=new AllotDetailDAO();
		int sourceId=0;
		map.clear();
		map.put("lading_id", allot.getOrdernum());
		this.setAllotDetails(addao.list(map));
		if(allotDetails.size()>0){
			for(int i=0;i<allotDetails.size();i++){
				this.setAllotDetail(allotDetails.get(i));
				StockDAO sdao=new StockDAO();
				this.setStock((Stock)sdao.get(allotDetail.getStock_id()));
				int totle=stock.getQuantity();
				//调出仓库－库存
				sourceId=stock.getUuid();
				stock.setQuantity(totle-allotDetail.getNum());
				map.clear();
				map.put("quantity", stock.getQuantity());
				map.put("uuid", stock.getUuid());
				sdao.updateTotleById(map);
				//调入仓库+库存(如果调入仓库没有此商品则填加记录，如果有修改库存)
				map.clear();
				map.put("product_id", stock.getProduct_id());
				map.put("store_id", allot.getGoldid());
				this.setStocks(sdao.list(map));
				if(stocks.size()>0){
					this.setStock(stocks.get(0));
					stock.setQuantity(stock.getQuantity()+allotDetail.getNum());
					map.clear();
					map.put("quantity", stock.getQuantity());
					map.put("uuid", stock.getUuid());
					sdao.updateTotleById(map);
				}else{
					stock.setProduct_id(stock.getProduct_id());
					stock.setStore_id(allotDetail.getGoldId());
					stock.setQuantity(allotDetail.getNum());
					sdao.add(stock);
					
				}
			}
			//取消冻结库存
			StockDAO sdao=new StockDAO();
			map.clear();
			map.put("uuid", sourceId);
			map.put("freezeNum", 0);
			sdao.updateFreezeNumById(map);
			
			//状态为已收货
			allot.setUuid(allot.getUuid());
			allot.setState(3);
			dao.updateState(allot);
		}
		return SUCCESS;
	}
	
	//取消发货
	public String cancel() throws Exception{
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_MDY");
		try {
			//检查库存是否足够
			AllotDetailDAO addao=new AllotDetailDAO();
			map.clear();
			map.put("lading_id", allot.getOrdernum());
			this.setAllotDetails(addao.list(map));
			if(allotDetails.size()>0){
				for(int i=0;i<allotDetails.size();i++){
					this.setAllotDetail(allotDetails.get(i));
					StockDAO sdao=new StockDAO();
					this.setStock((Stock)sdao.get(allotDetail.getStock_id()));
						//取消冻结库存
						map.clear();
						map.put("uuid", stock.getUuid());
						map.put("freezeNum", 0);
						sdao.updateFreezeNumById(map);
				}
				//状态取消发货
				allot.setUuid(allot.getUuid());
				allot.setState(2);
				dao.updateState(allot);
			}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_DEL");
		try {
			this.setAllot((Allot)dao.get(allot.getUuid()));
			AllotDetailDAO adDao=new AllotDetailDAO();
			map.clear();
			map.put("lading_id", allot.getOrdernum());
			this.setAllotDetails(adDao.list(map));
			//删除详表
			if(allotDetails.size()>0){
				for(int i=0;i<allotDetails.size();i++){
					this.setAllotDetail(allotDetails.get(i));
					//删除祥表
					adDao.delete(allotDetail);
					setMessage("删除成功!ID=" + allotDetail.getUuid());
				}
				
			}
			
			//删除主表
			dao.delete(allot);
			setMessage("删除成功!ID=" + allot.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
