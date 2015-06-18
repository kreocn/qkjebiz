package com.qkj.manage.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.check.CheckSkip;
import com.qkj.manage.check.CloseOrderCheckSkip;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.CloseOrderPosmDAO;
import com.qkj.manage.dao.CloseOrderProDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.dao.SalPromotDAO;
import com.qkj.manage.dao.SalPromotPower;
import com.qkj.manage.domain.Approve;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.domain.CloseOrderPosm;
import com.qkj.manage.domain.CloseOrderPro;
import com.qkj.manage.domain.SalPromot;

public class CloseOrderAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CloseOrderAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CloseOrderDAO dao = new CloseOrderDAO();
	private SalPromotDAO saldao = new SalPromotDAO();
	private ApproveDAO apdao = new ApproveDAO();
	private SalPromotPower sal = new SalPromotPower();
	private CloseOrderCheckSkip cocs = new CloseOrderCheckSkip();

	private CloseOrder closeOrder;
	private List<CloseOrder> closeOrders;
	private List<CloseOrder> allsigns;
	private CloseOrder sign;
	private List<SalPromot> salPromots;
	private List<SalPromot> salPromotsed;
	private List<CloseOrderPro> closeOrderPros;
	private List<CloseOrderPosm> closePosms;
	private CloseOrderPro closeOrderPro;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String pro_id[];

	private Approve approve;
	private List<Approve> approves;
	private String isApprover;
	private String noteflag = null;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单";
	// 个人工作标识
	private String perWorkF;
	private static String perWorkFlag = null;

	public List<CloseOrderPosm> getClosePosms() {
		return closePosms;
	}

	public void setClosePosms(List<CloseOrderPosm> closePosms) {
		this.closePosms = closePosms;
	}

	public String getPerWorkF() {
		return perWorkF;
	}

	public void setPerWorkF(String perWorkF) {
		this.perWorkF = perWorkF;
	}

	public static String getPerWorkFlag() {
		return perWorkFlag;
	}

	public static void setPerWorkFlag(String perWorkFlag) {
		CloseOrderAction.perWorkFlag = perWorkFlag;
	}

	public List<CloseOrder> getAllsigns() {
		return allsigns;
	}

	public void setAllsigns(List<CloseOrder> allsigns) {
		this.allsigns = allsigns;
	}

	public CloseOrder getSign() {
		return sign;
	}

	public void setSign(CloseOrder sign) {
		this.sign = sign;
	}

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

	public Approve getApprove() {
		return approve;
	}

	public void setApprove(Approve approve) {
		this.approve = approve;
	}

	public List<Approve> getApproves() {
		return approves;
	}

	public void setApproves(List<Approve> approves) {
		this.approves = approves;
	}

	public String getIsApprover() {
		return isApprover;
	}

	public void setIsApprover(String isApprover) {
		this.isApprover = isApprover;
	}

	public List<SalPromot> getSalPromotsed() {
		return salPromotsed;
	}

	public void setSalPromotsed(List<SalPromot> salPromotsed) {
		this.salPromotsed = salPromotsed;
	}

	public String list() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_LIST");
		try {
			map.clear();
			if (closeOrder == null) closeOrder = new CloseOrder();
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_CLOSEORDER_LIST", map, "apply_depts", "add_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_CLOSEORDER_LIST", map, closeOrder, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCloseOrders(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;结案提货单列表";

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		if (perWorkFlag == null || perWorkFlag.equals("null")) {
			return "success";
		} else {
			perWorkFlag = null;
			return "perSuccess";
		}
	}

	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if ((perWorkF == null || perWorkF.equals("null")) && perWorkFlag == null) {
			perWorkFlag = null;
		} else {
			perWorkFlag = "perWork";
		}
		try {
			if (null == viewFlag) {
				this.setCloseOrder(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setCloseOrder(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/closeOrder_relist'>结案提货单列表</a>&nbsp;&gt;&nbsp;增加结案提货单";
			} else if ("mdy".equals(viewFlag)) {
				String salid = null;
				if (!(closeOrder == null || closeOrder.getUuid() == null)) {
					this.setCloseOrder((CloseOrder) dao.get(closeOrder.getUuid()));
					salid = closeOrder.getSalPro_id();
				} else {
					this.setCloseOrder(null);
				}

				List<SalPromot> salps = new ArrayList<>();
				if (salid != null) {
					String stringarray[] = salid.split(",");
					for (int i = 0; i < stringarray.length; i++) {
						SalPromot sp = new SalPromot();
						sp.setUuid(Integer.parseInt(stringarray[i]));
						sp = (SalPromot) saldao.get(sp.getUuid());
						salps.add(sp);
					}
					this.setSalPromotsed(salps);// 已经选择的促销活动
				}
				this.setSalPromots(sal.salProPower(closeOrder.getMember_id()));// 可选的促销活动

				CloseOrderProDAO cdao = new CloseOrderProDAO();
				map.clear();
				map.put("order_id", closeOrder.getUuid());
				this.setCloseOrderPros(cdao.list(map));
				
				CloseOrderPosmDAO closedao=new CloseOrderPosmDAO();
				map.clear();
				map.put("closeOrder_id", closeOrder.getUuid());
				this.setClosePosms(closedao.list(map));

				map.clear();
				map.put("int_id", closeOrder.getUuid());
				map.put("approve_type", 3);
				this.setApproves(apdao.list(map));

				/* 检查当前用户是否已经审阅 */
				if (apdao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
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

	public String view() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String salid = null;
		List<SalPromot> salps = new ArrayList<>();
		try {
			if (!(closeOrder == null || closeOrder.getUuid() == null)) {
				this.setCloseOrder((CloseOrder) dao.get(closeOrder.getUuid()));
				if (closeOrder.getSalPro_id() != null) {
					salid = closeOrder.getSalPro_id();
				}
			} else {
				this.setCloseOrder(null);
			}

			if (salid != null) {
				String stringarray[] = salid.split(",");
				for (int i = 0; i < stringarray.length; i++) {
					SalPromot sp = new SalPromot();
					System.out.println(stringarray[i]);
					sp.setUuid(Integer.parseInt(stringarray[i]));
					sp = (SalPromot) saldao.get(sp.getUuid());
					salps.add(sp);
				}

			}
			this.setSalPromots(salps);
			map.clear();
			map.put("allsign", 1);
			map.put("biz_id", closeOrder.getUuid());
			this.setAllsigns(dao.allsign(map));

			this.setSign((CloseOrder) dao.sign(closeOrder.getUuid()));
			
			CloseOrderProDAO cdao = new CloseOrderProDAO();
			map.clear();
			map.put("order_id", closeOrder.getUuid());
			this.setCloseOrderPros(cdao.list(map));
			
			CloseOrderPosmDAO closedao=new CloseOrderPosmDAO();
			map.clear();
			map.put("closeOrder_id", closeOrder.getUuid());
			this.setClosePosms(closedao.list(map));
			
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
			closeOrder.setClose_num(number());// 单据编号
			closeOrder.setApply_dept(ContextHelper.getUserLoginDept());
			closeOrder.setAdd_user(ContextHelper.getUserLoginUuid());
			closeOrder.setAdd_time(new Date());
			closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			closeOrder.setLm_time(new Date());
			closeOrder.setState(0);
			closeOrder.setType(0);
			dao.add(closeOrder);
			addProcess("CLOSEORDER_ADD", "新增结案提货单", ContextHelper.getUserLoginUuid());
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
			addProcess("CLOSEORDER_MDY", "修改结案提货单", ContextHelper.getUserLoginUuid());
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
			addProcess("CLOSEORDER_ADD", "删除结案提货单", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/* 申请单状态 0:新申请 1:申请审批中 2:申请通过 */
	/* 销售部-审核状态 0:初始状态 5:审核退回 10:待审核 30:大区经理审核通过 40:运营总监审核通过 50:业务副总审核通过 */
	/* 销售管理部-审核状态 0:未签收 5:审核退回 10:已签收 30:销管经理已审 40:销管部经理已审 50:销管副总已审 60:总经理审核通过 */
	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK0");
		try {
			/*
			 * mdyStatus(1);//待审核
			 * // 同时进入销售部审核流程
			 * mdyCloseOrderSDStatus(10,ContextHelper.getUserLoginUuid());
			 * // 销售管理部默认为已签收
			 * mdyCloseOrderSMDStatus(10,ContextHelper.getUserLoginUuid());
			 * mdyCloseOrderFDStatus(1,0);
			 * mdyCloseOrderFDStatus(2,0);
			 */
			cocs.checkSkip(closeOrder, "check0");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK5");
		try {
			mdyStatus(0);
			mdyCloseOrderSDStatus(5, ContextHelper.getUserLoginUuid());
			mdyCloseOrderFDStatus(1, 0);
			mdyCloseOrderFDStatus(2, 0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区经理通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK20");
		try {
			// mdyCloseOrderSDStatus(30,userid);
			cocs.checkSkip(closeOrder, "check20");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总监通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK30");
		try {
			// mdyCloseOrderSDStatus(40,userid);
			cocs.checkSkip(closeOrder, "check30");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK50");
		try {
			// mdyCloseOrderSDStatus(50,userid);
			cocs.checkSkip(closeOrder, "check40");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 签收
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS0");
		try {
			mdyCloseOrderSMDStatus(10, ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS");
		try {
			mdyCloseOrderSMDStatus(5, ContextHelper.getUserLoginUuid());
			mdyStatus(0);
			mdyCloseOrderFDStatus(1, 0);
			mdyCloseOrderFDStatus(2, 0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售管理经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS10");
		try {
			// mdyCloseOrderSMDStatus(30,userid);
			cocs.checkSkip(closeOrder, "mdyCloseOrderSMDStatus10");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS40");
		try {
			// mdyCloseOrderSMDStatus(40,userid);
			cocs.checkSkip(closeOrder, "mdyCloseOrderSMDStatus40");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管副总已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseOrderSMDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS50");
		try {
			// mdyCloseOrderSMDStatus(50,userid);
			cocs.checkSkip(closeOrder, "mdyCloseOrderSMDStatus50");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseOrderSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCloseOrderSMDStatus60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK60");
		try {
			mdyCloseOrderSMDStatus(60, ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String checkfd10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK40");
		try {
			mdyCloseOrderFDStatus(1, 10);
			closeOrder.setState(2);
			dao.mdyPassStatus(closeOrder);
			addProcess("CLOSEORDER_APPLY_PASS", "提货结案申请通过", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String checkfd5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_CHECK40");
		try {
			mdyCloseOrderFDStatus(1, 5);
			mdyCloseOrderFDStatus(2, 0);
			mdyStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 数据中心通过数据中心审核状态0：未审核5：退回10：通过
	 * 
	 * @param p_check
	 * @return
	 */
	public String checknd0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_NDSTATUS0");
		try {
			mdyCloseOrderFDStatus(2, 10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 数据中心退回
	 * 
	 * @param p_check
	 * @return
	 */
	public String checknd5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_NDSTATUS0");
		try {
			mdyCloseOrderFDStatus(2, 5);
			mdyCloseOrderFDStatus(1, 0);
			mdyStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审阅
	 * 
	 * @return
	 * @throws Exception
	 */
	public String approve() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_APPROVE");
		try {
			apdao.add(approve, 3, closeOrder.getUuid());
			addProcess("CLOSE_APPROVE", "结案提货单-增加一条审阅信息", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approve 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approve 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 删除审阅
	 * 
	 * @return
	 * @throws Exception
	 */
	public String approveDel() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_CLOSEORDER_APPROVEDELLAST");
		try {
			apdao.deleteLast(approve, 3, closeOrder.getUuid());
			addProcess("CLOSE_APPROVEDEL", "结案提货-删除一条审阅信息", ContextHelper.getUserLoginUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售部审批状态通用函数
	 * 
	 * @param sd_status
	 * @return
	 * @date 2014-4-26 上午10:20:39
	 */
	public int mdyCloseOrderSDStatus(int sd_status, String userid) {
		if (sd_status == 5) {
			noteflag = "退回";
		}
		if (sd_status == 10) {
			noteflag = "待审核";
		}
		if (sd_status == 30) {
			noteflag = "大区审核通过";
		}
		if (sd_status == 40) {
			noteflag = "总监审核通过";
		}
		if (sd_status == 50) {
			noteflag = "副总审核通过";
		}
		if (sd_status == 50) {
			noteflag = "总经理审核通过";
		}
		closeOrder.setSd_state(sd_status);
		closeOrder.setSd_time(new Date());
		closeOrder.setSd_user(userid);
		closeOrder.setLm_user(userid);
		closeOrder.setLm_time(new Date());
		String note = "提货结案单-销售审核状态变更-" + noteflag;
		addProcess("CLOSEORDER_MDY_SDSTATUS", note, userid);
		return dao.mdyCloseOrderSDStatus(closeOrder);
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseOrderSMDStatus(int smd_status, String userid) {
		CheckSkip s = new CheckSkip();
		if (smd_status == 5) {
			noteflag = "退回";
		}
		if (smd_status == 10) {
			noteflag = "已签收";
		}
		if (smd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (smd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (smd_status == 50) {
			noteflag = "销管副总审核通过";
		}
		closeOrder.setSmd_status(smd_status);
		closeOrder.setSmd_time(new Date());
		closeOrder.setSmd_user(userid);
		closeOrder.setLm_user(userid);
		closeOrder.setLm_time(new Date());
		String note = "提货结案单-销管审核状态变更-" + noteflag;
		addProcess("CLOSEORDER_MDY_SMDSTATUS", note, userid);
		return dao.mdyCloseOrderSMDStatus(closeOrder);
	}

	private int mdyStatus(int status) {
		CheckSkip s = new CheckSkip();
		if (status == -1) {
			noteflag = "作废";
		}
		if (status == 0) {
			noteflag = "新申请";
		}
		if (status == 1) {
			noteflag = "申请审批中";
		}
		if (status == 2) {
			noteflag = "申请通过-可以执行";
		}
		if (status == 3) {
			noteflag = "开始结案";
		}
		if (status == 4) {
			noteflag = "结案审批中";
		}
		if (status == 5) {
			noteflag = "结案通过";
		}
		closeOrder.setState(status);
		closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
		closeOrder.setLm_time(new Date());
		String note = "提货结案单状态变更-" + noteflag;
		addProcess("CLOSEORDER_MDY_STATUS", note, ContextHelper.getUserLoginUuid());
		return dao.mdyCloseOrderStatus(closeOrder);
	}

	/**
	 * 改财务审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseOrderFDStatus(int flag, int smd_status) {
		if (flag == 1) {// 申请
			if (smd_status == 5) {
				noteflag = "退回";
			}
			if (smd_status == 10) {
				noteflag = "通过";
			}
			closeOrder.setFd_check_state(smd_status);
			closeOrder.setFd_check_user(ContextHelper.getUserLoginUuid());
			closeOrder.setFd_check_time(new Date());
			closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			closeOrder.setLm_time(new Date());
			String note = "提货结案单--财务状态变更-" + noteflag;
			addProcess("CLOSEORDER_MDY_FDSTATUS", note, ContextHelper.getUserLoginUuid());
			return dao.mdyCloseOrderFDStatus(closeOrder);
		} else {// 数据中心
			if (smd_status == 5) {
				noteflag = "退回";
			}
			if (smd_status == 10) {
				noteflag = "通过";
			}
			closeOrder.setNd_check_state(smd_status);
			closeOrder.setNd_check_time(new Date());
			closeOrder.setNd_check_user(ContextHelper.getUserLoginUuid());
			closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
			closeOrder.setLm_time(new Date());
			String note = "提货结案单--数据中心状态变更-" + noteflag;
			addProcess("CLOSEORDER_MDY_NDCSTATUS", note, ContextHelper.getUserLoginUuid());
			return dao.mdyCloseOrderNDStatus(closeOrder);
		}

	}

	/*
	 * public int check(int p_check) {
	 * closeOrder.setCheck_state(p_check);
	 * closeOrder.setCheck_user(ContextHelper.getUserLoginUuid());
	 * closeOrder.setCheck_time(new Date());
	 * closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
	 * closeOrder.setLm_time(new Date());
	 * addProcess("CLOSEORDER_STATUS_CHANGE", "结案提货单-业务审核状态变更");
	 * return dao.check(closeOrder);
	 * }
	 * 
	 * public int checknd(int p_check) {
	 * closeOrder.setNd_check_state(p_check);
	 * closeOrder.setNd_check_user(ContextHelper.getUserLoginUuid());
	 * closeOrder.setNd_check_time(new Date());
	 * closeOrder.setLm_user(ContextHelper.getUserLoginUuid());
	 * closeOrder.setLm_time(new Date());
	 * addProcess("CLOSEORDER_NDSTATUS_CHANGE", "结案提货单-数据中心审核状态变更");
	 * return dao.checknd(closeOrder);
	 * }
	 * 
	 * private void addProcess(String p_sign, String p_note) {
	 * ProcessDAO pdao = new ProcessDAO();
	 * if (closeOrder != null) {
	 * pdao.addProcess(4, closeOrder.getUuid(), p_sign, p_note, closeOrder.getCheck_state(), closeOrder.getNd_check_state());
	 * }
	 * }
	 */
	/**
	 * sunshanshan20150608历史表
	 * 
	 * @param p_sign
	 * @param p_note
	 * @param userLogin
	 */
	private void addProcess(String p_sign, String p_note, String userLogin) {
		ProcessDAO pdao = new ProcessDAO();
		if (closeOrder != null) {/* 单据状态，销售状态，销管状态，财务，数据中心 */
			pdao.addProcess(4, closeOrder.getUuid(), p_sign, p_note, closeOrder.getState(), closeOrder.getSd_state(), closeOrder.getSmd_status(), closeOrder.getFd_check_state(),
					closeOrder.getNd_check_state(), userLogin);
		}
	}

	public String number() {
		String num = null;
		String dept = ContextHelper.getUserLoginDept();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowdate = sdf.format(new Date());
		map.clear();
		map.put("apply_dept", dept);
		map.put("add_time", nowdate);
		int n = dao.list(map).size();

		String m = "";
		char[] a = nowdate.toCharArray();
		for (int i = 0; i < a.length; i++) {
			if (Character.isDigit(a[i])) {
				m += a[i];
			}
		}
		num = ContextHelper.getUserLoginDeptName() + m + "--00" + (n + 1);
		return num;
	}

}
