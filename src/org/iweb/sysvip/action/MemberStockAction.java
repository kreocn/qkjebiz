package org.iweb.sysvip.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import org.iweb.sysvip.domain.MemberStock;
import org.iweb.sysvip.dao.MemberStockDAO;

public class MemberStockAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberStockAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberStockDAO dao = new MemberStockDAO();

	private MemberStock memberStock;
	private List<MemberStock> memberStocks;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;会员库存";
	public String getPath() {
		return path;
	}

	public MemberStock getMemberStock() {
		return memberStock;
	}

	public void setMemberStock(MemberStock memberStock) {
		this.memberStock = memberStock;
	}

	public List<MemberStock> getMemberStocks() {
		return memberStocks;
	}

	public void setMemberStocks(List<MemberStock> memberStocks) {
		this.memberStocks = memberStocks;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJM_SYSVIP_MEMBERSTOCK_LIST");
		try {
			map.clear();
			if (memberStock != null){
				if(memberStock.getDealer().equals("")){
					memberStock.setDealer(null);
				}
				map.putAll(ToolsUtil.getMapByBean(memberStock));
			}
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setMemberStocks(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;会员库存列表";
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
				this.setMemberStock(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setMemberStock(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysvip/memberStock_relist'>会员库存列表</a>&nbsp;&gt;&nbsp;增加会员库存";
			} else if ("mdy".equals(viewFlag)) {
				if (!(memberStock == null || memberStock.getUuid() == null)) {
					this.setMemberStock((MemberStock) dao.get(memberStock.getUuid()));
				} else {
					this.setMemberStock(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysvip/memberStock_relist'>会员库存列表</a>&nbsp;&gt;&nbsp;增加会员库存";
			} else {
				this.setMemberStock(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJM_SYSVIP_MEMBERSTOCK_ADD");
		try {
			memberStock.setAdd_user(ContextHelper.getUserLoginUuid());
			memberStock.setAdd_time(new Date());
			memberStock.setLm_user(ContextHelper.getUserLoginUuid());
			memberStock.setLm_time(new Date());
			dao.add(memberStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJM_SYSVIP_MEMBERSTOCK_MDY");
		try {
			memberStock.setLm_user(ContextHelper.getUserLoginUuid());
			memberStock.setLm_time(new Date());
			dao.save(memberStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJM_SYSVIP_MEMBERSTOCK_DEL");
		try {
			dao.delete(memberStock);
			setMessage("删除成功!ID=" + memberStock.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	public String leading() throws Exception {
		ContextHelper.isPermit("QKJM_SYSVIP_MEMBERSTOCK_ADD");
		try {
			memberStock.setAdd_user(ContextHelper.getUserLoginUuid());
			memberStock.setAdd_time(new Date());
			memberStock.setLm_user(ContextHelper.getUserLoginUuid());
			memberStock.setLm_time(new Date());
			dao.add(memberStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
