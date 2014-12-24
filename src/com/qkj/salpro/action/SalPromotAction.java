package com.qkj.salpro.action;
import java.util.*;
import org.apache.commons.logging.*;
import org.iweb.sys.*;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.salpro.domain.SalPromot;
import com.qkj.salpro.dao.SalPromotDAO;

public class SalPromotAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(SalPromotAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private SalPromotDAO dao = new SalPromotDAO();

	private SalPromot salPromot;
	private List<SalPromot> salPromots;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;促销活动";
	public String getPath() {
		return path;
	}

	public SalPromot getSalPromot() {
		return salPromot;
	}

	public void setSalPromot(SalPromot salPromot) {
		this.salPromot = salPromot;
	}

	public List<SalPromot> getSalPromots() {
		return salPromots;
	}

	public void setSalPromots(List<SalPromot> salPromots) {
		this.salPromots = salPromots;
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
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_LIST");
		try {
			map.clear();
			if (salPromot != null)
				map.putAll(ToolsUtil.getMapByBean(salPromot));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));		
			this.setSalPromots(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;促销活动列表";
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
				this.setSalPromot(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setSalPromot(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;增加促销活动";
			} else if ("mdy".equals(viewFlag)) {
				if (!(salPromot == null || salPromot.getUuid() == null)) {
					this.setSalPromot((SalPromot) dao.get(salPromot.getUuid()));
				} else {
					this.setSalPromot(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;增加促销活动";
			} else {
				this.setSalPromot(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_ADD");
		try {
			salPromot.setAdd_user(ContextHelper.getUserLoginUuid());
			salPromot.setAdd_time(new Date());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.add(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_MDY");
		try {
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.save(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_DEL");
		try {
			dao.delete(salPromot);
			setMessage("删除成功!ID=" + salPromot.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	public String status1() throws Exception{
		try {
			salPromot.setStatus(1);
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.saveStatus1(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	//销管经理
	public String smdstatus20() throws Exception{
		try {
			salPromot.setStatus(1);
			salPromot.setSmd_status(20);
			salPromot.setSmd_time(new Date());
			salPromot.setSmd_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.saveSmdsta(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	
	public String smdstatus5() throws Exception{
		try {
			salPromot.setStatus(0);
			salPromot.setSmd_status(5);
			salPromot.setSmd_time(new Date());
			salPromot.setSmd_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.saveSmdsta(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	
	//总监
		public String sdstatus30() throws Exception{
			try {
				salPromot.setStatus(2);
				salPromot.setSd_status(30);
				salPromot.setSd_time(new Date());
				salPromot.setSd_user(ContextHelper.getUserLoginUuid());
				salPromot.setLm_user(ContextHelper.getUserLoginUuid());
				salPromot.setLm_time(new Date());
				dao.saveSmdsta(salPromot);
			} catch (Exception e) {
				log.error(this.getClass().getName() + "!status1 修改成功:", e);
				throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
			}
			return SUCCESS;
		}
		
		public String sdstatus5() throws Exception{
			try {
				salPromot.setStatus(0);
				salPromot.setSd_status(5);
				salPromot.setSd_time(new Date());
				salPromot.setSd_user(ContextHelper.getUserLoginUuid());
				salPromot.setLm_user(ContextHelper.getUserLoginUuid());
				salPromot.setLm_time(new Date());
				dao.saveSdsta(salPromot);
			} catch (Exception e) {
				log.error(this.getClass().getName() + "!status1 修改成功:", e);
				throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
			}
			return SUCCESS;
		}
	
	
}
