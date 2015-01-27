package com.qkj.manage.action;

import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;
import org.iweb.sysvip.domain.Member;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.domain.CloseOrderPro;
import com.qkj.manage.domain.SalPromot;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.CloseOrderProDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.dao.SalPromotDAO;
import com.qkj.manage.dao.SalPromotPower;

public class CloseOrderAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CloseOrderAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CloseOrderDAO dao = new CloseOrderDAO();
	private SalPromotDAO saldao=new SalPromotDAO();
	private SalPromotPower sal=new SalPromotPower();

	private CloseOrder closeOrder;
	private List<CloseOrder> closeOrders;
	private List<SalPromot> salPromots;
	private List<CloseOrderPro> closeOrderPros;
	private CloseOrderPro closeOrderPro;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String pro_id[];
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单";

	public String getPath() {
		return path;
	}

	public CloseOrder getCloseOrder() {
		return closeOrder;
	}

	public void setCloseOrder(CloseOrder closeOrder) {
		this.closeOrder = closeOrder;
	}

	public List<CloseOrder> getCloseOrders() {
		return closeOrders;
	}

	public void setCloseOrders(List<CloseOrder> closeOrders) {
		this.closeOrders = closeOrders;
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

	public List<SalPromot> getSalPromots() {
		return salPromots;
	}

	public void setSalPromots(List<SalPromot> salPromots) {
		this.salPromots = salPromots;
	}

	public List<CloseOrderPro> getCloseOrderPros() {
		return closeOrderPros;
	}

	public void setCloseOrderPros(List<CloseOrderPro> closeOrderPros) {
		this.closeOrderPros = closeOrderPros;
	}

	public CloseOrderPro getCloseOrderPro() {
		return closeOrderPro;
	}

	public void setCloseOrderPro(CloseOrderPro closeOrderPro) {
		this.closeOrderPro = closeOrderPro;
	}

	public String[] getPro_id() {
		return pro_id;
	}

	public void setPro_id(String[] pro_id) {
		this.pro_id = pro_id;
	}

	public String list() throws Exception {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_LIST");
		try {
			map.clear();
			if (closeOrder == null) closeOrder = new CloseOrder();
			ContextHelper.setSearchDeptPermit4Search(map, "apply_depts", "add_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_CLOSEORDER_LIST", map, closeOrder, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCloseOrders(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单列表";
			
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
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try {
			if (null == viewFlag) {
				this.setCloseOrder(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setCloseOrder(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrder_relist'>结案提货单列表</a>&nbsp;&gt;&nbsp;增加结案提货单";
			} else if ("mdy".equals(viewFlag)) {
				if (!(closeOrder == null || closeOrder.getUuid() == null)) {
					this.setCloseOrder((CloseOrder) dao.get(closeOrder.getUuid()));
				} else {
					this.setCloseOrder(null);
				}
				this.setSalPromots(sal.salProPower(closeOrder.getMember_id()));
				System.out.println(salPromots.size());
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrder_relist'>结案提货单列表</a>&nbsp;&gt;&nbsp;增加结案提货单";
			} else {
				this.setCloseOrder(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String view() throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try {
				if (!(closeOrder == null || closeOrder.getUuid() == null)) {
					this.setCloseOrder((CloseOrder) dao.get(closeOrder.getUuid()));
				} else {
					this.setCloseOrder(null);
				}
				map.clear();
				map.put("status", 2);
				map.put("proendtime", sdf.format(new Date()));
				this.setSalPromots(saldao.list(map));
				CloseOrderProDAO cdao=new CloseOrderProDAO();
				map.clear();
				map.put("order_id", closeOrder.getUuid());
				this.setCloseOrderPros(cdao.list(map));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrder_relist'>结案提货单列表</a>&nbsp;&gt;&nbsp;结案提货单详情";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!view 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!view 读取数据错误:", e);
		}
		return SUCCESS;
	}
	

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_ADD");
		try {
			closeOrder.setApply_dept(ContextHelper.getUserLoginDept());
			closeOrder.setAdd_user(ContextHelper.getUserLoginUuid());
			closeOrder.setAdd_time(new Date());
			closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			closeOrder.setLm_time(new Date());
			dao.add(closeOrder);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_MDY");
		try {
			if (closeOrder != null && !ToolsUtil.isEmpty(closeOrder.getSalPro_id())) {
				closeOrder.setSalPro_id(closeOrder.getSalPro_id().replaceAll(" ", ""));
			}
			closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			closeOrder.setLm_time(new Date());
			dao.save(closeOrder);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_DEL");
		try {
			dao.delete(closeOrder);
			setMessage("删除成功!ID=" + closeOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	/* 审核状态0：新单1：待审核，5：退回10：招商主管通过20：招商经理30大区40财务50总监60副总70总经理 */
	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK0");
		try {
			check(1);//待审核
			checknd(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check0 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 退回
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK5");
		try {
			check(5);
			checknd(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 主管通过
	 * @return
	 * @throws Exception
	 */
	public String check1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK1");
		try {
			check(10);//待审核
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 招商经理通过
	 * @return
	 * @throws Exception
	 */
	public String check10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK10");
		try {
			check(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 大区经理通过
	 * @return
	 * @throws Exception
	 */
	public String check20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK20");
		try {
			check(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 财务通过
	 * @return
	 * @throws Exception
	 */
	public String check30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK30");
		try {
			check(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 总监通过
	 * @return
	 * @throws Exception
	 */
	public String check40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK40");
		try {
			check(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 副总通过
	 * @return
	 * @throws Exception
	 */
	public String check50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK50");
		try {
			check(60);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 总经理通过
	 * @return
	 * @throws Exception
	 */
	public String check60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK60");
		try {
			check(70);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 数据中心通过数据中心审核状态0：未审核5：退回10：通过
	 * @param p_check
	 * @return
	 */
	public String checknd0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_NDSTATUS0");
		try {
			checknd(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 数据中心退回
	 * @param p_check
	 * @return
	 */
	public String checknd5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_NDSTATUS5");
		try {
			checknd(5);
			check(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public int check(int p_check) {
		closeOrder.setCheck_state(p_check);
		closeOrder.setCheck_user(ContextHelper.getUserLoginUuid());
		closeOrder.setCheck_time(new Date());
		closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
		closeOrder.setLm_time(new Date());
		addProcess("CLOSEORDER_STATUS_CHANGE", "结案提货单-业务审核状态变更");
		return dao.check(closeOrder);
	}
	
	public int checknd(int p_check) {
		closeOrder.setNd_check_state(p_check);
		closeOrder.setNd_check_user(ContextHelper.getUserLoginUuid());
		closeOrder.setNd_check_time(new Date());
		closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
		closeOrder.setLm_time(new Date());
		addProcess("CLOSEORDER_NDSTATUS_CHANGE", "结案提货单-数据中心审核状态变更");
		return dao.checknd(closeOrder);
	}
	
	private void addProcess(String p_sign, String p_note) {
		ProcessDAO pdao = new ProcessDAO();
		if (closeOrder != null) {
			pdao.addProcess(4, closeOrder.getUuid(), p_sign, p_note, closeOrder.getCheck_state(), closeOrder.getNd_check_state());
		}
	}
}
