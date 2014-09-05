package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.AllotDetailH;
import com.qkj.ware.domain.AllotH;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.domain.Allot;
import com.qkj.ware.dao.AllotDAO;
import com.qkj.ware.dao.AllotDetailDAO;
import com.qkj.ware.dao.AllotDetailHDAO;
import com.qkj.ware.dao.AllotHDAO;
import com.qkj.ware.domain.AllotDetail;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class AllotAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AllotAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AllotDAO dao = new AllotDAO();

	private Allot allot;
	private AllotH alloth;
	private AllotDetailH allotDh;
	private Ware ware;
	private Stock stock;//
	private AllotDetail allotDetail;
	private List<Allot> allots;
	private List<Ware> warepowers;
	private List<AllotDetail> allotDetails;
	private List<Ware> wares;
	private List<Stock> stocks;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	
	private int flag=0;

	
	
	
	public AllotH getAlloth() {
		return alloth;
	}

	public void setAlloth(AllotH alloth) {
		this.alloth = alloth;
	}

	public AllotDetailH getAllotDh() {
		return allotDh;
	}

	public void setAllotDh(AllotDetailH allotDh) {
		this.allotDh = allotDh;
	}

	public Ware getWare() {
		return ware;
	}

	public void setWare(Ware ware) {
		this.ware = ware;
	}

	public List<Ware> getWarepowers() {
		return warepowers;
	}

	public void setWarepowers(List<Ware> warepowers) {
		this.warepowers = warepowers;
	}

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
	
	
	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOT_LIST");
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (allot != null)
				map.putAll(ToolsUtil.getMapByBean(allot));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			if(ContextHelper.isAdmin()){//管理员
				this.setAllots(dao.list(map));
			}else{
				map.put("username",u);
				map.put("dept_code", code);
				this.setAllots(dao.listPower(map));
			}
			
			this.setRecCount(dao.getResultCount());
			
			wareByPower(u, code);
			
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
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		try {
			if (null == viewFlag) {
				this.setAllot(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAllot(null);
				wareByPower(u, code);
				
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("ordernum", allot.getOrdernum());
				if (!(allot == null || allot.getUuid() == null)||null!=map.get("ordernum")) {
					if(allot.getUuid()!=null){
						this.setAllot((Allot) dao.get(allot.getUuid()));
					}else{
						this.setAllot((Allot)dao.list(map).get(0));
					}
					//入仓库
					WareDAO wd=new WareDAO();
					map.clear();
					map.put("bug","bug");
					this.setWares(wd.list(map));
					//出仓库
					if(u.equals("1")){//管理员
						this.setWarepowers(wares);
					}else{
						map.clear();
						map.put("useruuid",u);
						this.setWarepowers(wd.listByPower(map));
					}
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
					
					//判断是否有确认收货权限
					int id=allot.getGoldid();
					map.clear();
					map.put("useruuid",u);
					if(ContextHelper.isAdmin()){//管理员
						this.setFlag(1);
					}else{
						this.setWarepowers(wd.listByPower(map));
						for(int i=0;i<warepowers.size();i++){
							this.setWare(warepowers.get(i));
							if(id==ware.getUuid()){//有权限
								this.setFlag(1);
								break;
							}else{
								this.setFlag(0);
							}
							
						}
						
					}
					
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

	private void wareByPower(String u, String code) {
		//入仓库
		WareDAO wd=new WareDAO();
		if(ContextHelper.isAdmin()){//管理员
			this.setWares(wd.list(null));
		}else{
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			map.put("add", 1);
			map.put("bug","bug");
			this.setWares(wd.listByPower(map));
		}
		this.setAllot(null);
		//出仓库
		if(ContextHelper.isAdmin()){//管理员
			this.setWarepowers(wares);
		}else{
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			map.put("add", 1);
			this.setWares(wd.listByPower(map));
		}
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_ALLOT_ADD");
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
		ContextHelper.isPermit("QKJ_WARE_ALLOT_MDY");
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
		ContextHelper.isPermit("QKJ_WARE_ALLOT_MDY");
		String u = ContextHelper.getUserLoginUuid();
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
		this.setAllot((Allot)dao.list(map).get(0));
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
					stock.setStore_id(allot.getGoldid());
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
		ContextHelper.isPermit("QKJ_WARE_ALLOT_MDY");
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
		ContextHelper.isPermit("QKJ_WARE_ALLOT_DEL");
		try {
			this.setAllot((Allot)dao.get(allot.getUuid()));
			AllotHDAO mhd=new AllotHDAO();
			this.setAlloth(allot);
			mhd.add(alloth);//填加历史
			
			AllotDetailDAO adDao=new AllotDetailDAO();
			map.clear();
			map.put("lading_id", allot.getOrdernum());
			this.setAllotDetails(adDao.list(map));
			//删除详表
			if(allotDetails.size()>0){
				for(int i=0;i<allotDetails.size();i++){
					this.setAllotDetail(allotDetails.get(i));
					
					AllotDetailHDAO hd=new AllotDetailHDAO();
					this.setAllotDh(allotDetail);
					hd.add(allotDh);//填加历史
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

	private void setAllotDh(AllotDetail allotDetail2) {
		// TODO Auto-generated method stub
		allotDh=new AllotDetailH();
		allotDh.setLading_id(allotDetail2.getLading_id());
		allotDh.setNum(allotDetail2.getNum());
		allotDh.setStock_id(allotDetail2.getStock_id());
		
	}

	private void setAlloth(Allot allot2) {
		// TODO Auto-generated method stub
		alloth=new AllotH();
		alloth.setAdd_timer(allot2.getAdd_timer());
		alloth.setAdd_user(allot2.getAdd_user());
		alloth.setDate(allot2.getDate());
		alloth.setGoldid(allot2.getGoldid());
		alloth.setLm_timer(allot2.getLm_timer());
		alloth.setLm_user(allot2.getLm_user());
		alloth.setNote(allot2.getNote());
		alloth.setOrdernum(allot2.getOrdernum());
		alloth.setSourceid(allot2.getSourceid());
		alloth.setState(allot2.getState());
		
	}
}
