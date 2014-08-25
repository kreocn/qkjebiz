package com.qkj.ware.action;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.domain.AllotDetailH;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.domain.Allot;
import com.qkj.ware.domain.AllotDetail;
import com.qkj.ware.dao.AllotDetailDAO;
import com.qkj.ware.dao.AllotDetailHDAO;
import com.qkj.ware.dao.AllotHDAO;

public class AllotDetailAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(AllotDetailAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private AllotDetailDAO dao = new AllotDetailDAO();

	private AllotDetail allotDetail;
	private AllotDetailH allotDh;
	private Allot allot;
	private List<AllotDetail> allotDetails;
	private List<Stock> stocks;
	private String message;
	private Stock stock;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	
	public AllotDetailH getAllotDh() {
		return allotDh;
	}

	public void setAllotDh(AllotDetailH allotDh) {
		this.allotDh = allotDh;
	}

	public AllotDetail getAllotDetail() {
		return allotDetail;
	}

	public void setAllotDetail(AllotDetail allotDetail) {
		this.allotDetail = allotDetail;
	}

	public List<AllotDetail> getAllotDetails() {
		return allotDetails;
	}

	public void setAllotDetails(List<AllotDetail> allotDetails) {
		this.allotDetails = allotDetails;
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
	

	public List<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(List<Stock> stocks) {
		this.stocks = stocks;
	}
	
	public Allot getAllot() {
		return allot;
	}

	public void setAllot(Allot allot) {
		this.allot = allot;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_LIST");
		try {
			map.clear();
			if (allotDetail != null)
				map.putAll(ToolsUtil.getMapByBean(allotDetail));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setAllotDetails(dao.list(map));
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
				this.setAllotDetail(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setAllotDetail(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(allotDetail == null || allotDetail.getUuid() == null)) {
					this.setAllotDetail((AllotDetail) dao.get(allotDetail.getUuid()));
				} else {
					this.setAllotDetail(null);
				}
			} else {
				this.setAllotDetail(null);
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
			dao.add(allotDetail);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_MDY");
		try {
			dao.save(allotDetail);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_ALLOT_ALLOT_DEL");
		try {
			
			this.setAllotDetail((AllotDetail)dao.get(allotDetail.getUuid()));
			AllotDetailHDAO hd=new AllotDetailHDAO();
			this.setAllotDh(allotDetail);
			hd.add(allotDh);//填加历史
			//删除祥表
			dao.delete(allotDetail);
			setMessage("删除成功!ID=" + allotDetail.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	private void setAllotDh(AllotDetail allotDetail2) {
		// TODO Auto-generated method stub
		allotDh.setLading_id(allotDetail2.getLading_id());
		allotDh.setNum(allotDetail2.getNum());
		allotDh.setStock_id(allotDetail2.getStock_id());
	}
}
