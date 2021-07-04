package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.SendMessage;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.UserLoginInfo;
import org.iweb.sysvip.domain.Member;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActivePosmDAO;
import com.qkj.manage.dao.ActiveProductDAO;
import com.qkj.manage.dao.ApplyDAO;
import com.qkj.manage.dao.ApplyPosmDAO;
import com.qkj.manage.dao.ApplyProductDAO;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.CloseOrderProDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.ActiveMemcost;
import com.qkj.manage.domain.ActivePosm;
import com.qkj.manage.domain.ActiveProduct;
import com.qkj.manage.domain.Apply;
import com.qkj.manage.domain.ApplyPosm;
import com.qkj.manage.domain.ApplyProduct;
import com.qkj.manage.domain.Approve;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.domain.CloseOrderPro;
import com.qkj.manage.domain.LadingItem;
import com.qkj.manage.domain.Product;
import com.qkj.ware.dao.OutStockDAO;
import com.qkj.ware.domain.InStock;
import com.qkj.ware.domain.OutStock;

public class ApplyAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ApplyAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ApplyDAO dao = new ApplyDAO();
	private ApproveDAO adao = new ApproveDAO();
	private Apply apply;
	private CloseOrder closeOrder;
	private List<Apply> applys;
	private List<Apply> applyUserSign;
	private Approve approve;
	private List<Approve> approves;
	private String isApprover;
	private String message;
	private String viewFlag;
	private OutStock outsstock;


	private String is_total_price="0";
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;至事由管理";
	// 个人工作标识
	private String perWorkF;
	private static String perWorkFlag;
	public String per = "per";

	public CloseOrder getCloseOrder() {
		return closeOrder;
	}

	public void setCloseOrder(CloseOrder closeOrder) {
		this.closeOrder = closeOrder;
	}

	public OutStock getOutsstock() {
		return outsstock;
	}

	public void setOutsstock(OutStock outsstock) {
		this.outsstock = outsstock;
	}

	public String getPer() {
		return per;
	}

	public void setPer(String per) {
		this.per = per;
	}

	private List<Active> getapply_depts;
	private String userappid;
	private String userdepta;

	private CloseOrder sign;
	private List<ApplyProduct> applyproduct;
	private double indprice;
	private List<ApplyProduct> indApplyProducts;
	private List<ApplyProduct> otherApplyProducts;
	private List<ActivePosm> activePosms;
	private List<ActiveMemcost> activeMemcosts;
	private List<ApplyPosm> applyPosms;
	public String getIs_total_price() {
		return is_total_price;
	}

	public void setIs_total_price(String is_total_price) {
		this.is_total_price = is_total_price;
	}
	public List<ApplyPosm> getApplyPosms() {
		return applyPosms;
	}

	public void setApplyPosms(List<ApplyPosm> applyPosms) {
		this.applyPosms = applyPosms;
	}

	public List<ApplyProduct> getIndApplyProducts() {
		return indApplyProducts;
	}

	public void setIndApplyProducts(List<ApplyProduct> indApplyProducts) {
		this.indApplyProducts = indApplyProducts;
	}

	public List<ApplyProduct> getOtherApplyProducts() {
		return otherApplyProducts;
	}

	public void setOtherApplyProducts(List<ApplyProduct> otherApplyProducts) {
		this.otherApplyProducts = otherApplyProducts;
	}

	public double getIndprice() {
		return indprice;
	}

	public void setIndprice(double indprice) {
		this.indprice = indprice;
	}

	public List<ApplyProduct> getApplyproduct() {
		return applyproduct;
	}

	public void setApplyproduct(List<ApplyProduct> applyproduct) {
		this.applyproduct = applyproduct;
	}

	public CloseOrder getSign() {
		return sign;
	}

	public void setSign(CloseOrder sign) {
		this.sign = sign;
	}

	public List<Active> getGetapply_depts() {
		return getapply_depts;
	}

	public void setGetapply_depts(List<Active> getapply_depts) {
		this.getapply_depts = getapply_depts;
	}

	public String getUserappid() {
		return userappid;
	}

	public void setUserappid(String userappid) {
		this.userappid = userappid;
	}

	public String getUserdepta() {
		return userdepta;
	}

	public void setUserdepta(String userdepta) {
		this.userdepta = userdepta;
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
		ApplyAction.perWorkFlag = perWorkFlag;
	}

	public List<Apply> getApplyUserSign() {
		return applyUserSign;
	}

	public void setApplyUserSign(List<Apply> applyUserSign) {
		this.applyUserSign = applyUserSign;
	}

	public String getPath() {
		return path;
	}

	public String getIsApprover() {
		return isApprover;
	}

	public void setIsApprover(String isApprover) {
		this.isApprover = isApprover;
	}

	public List<Approve> getApproves() {
		return approves;
	}

	public void setApproves(List<Approve> approves) {
		this.approves = approves;
	}

	public Approve getApprove() {
		return approve;
	}

	public void setApprove(Approve approve) {
		this.approve = approve;
	}

	public Apply getApply() {
		return apply;
	}

	public void setApply(Apply apply) {
		this.apply = apply;
	}

	public List<Apply> getApplys() {
		return applys;
	}

	public void setApplys(List<Apply> applys) {
		this.applys = applys;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_LIST");
		try {
			map.clear();
			if (apply == null) {
				apply = new Apply();
			}

			// 特殊审核权限
			if (apply.getStatus_sp() != null) {
				if (apply.getStatus_sp() == 25) {
					apply.setSp_check_status(10);
					apply.setStatus(20);
				} else if (apply.getStatus_sp() == 20) {
					apply.setSp_check_status(0);
					apply.setStatus(apply.getStatus_sp());
				} else if (apply.getStatus_sp() == 35) {
					apply.setSp_check_status(0);
					apply.setStatus(null);
				} else {
					apply.setStatus(apply.getStatus_sp());
					apply.setSp_check_status(null);
				}
			}
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_APPLY_LIST", map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_APPLY_LIST", map, apply, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str)).toString()));
			this.setApplys(dao.list(map));
			this.setRecCount(dao.getResultCount());
			System.out.println(applys.size());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;至事由列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		if (perWorkFlag == null || perWorkFlag.equals("null") ||perWorkFlag.equals("") || per==null ||per.equals("null")) {
			return "success";
		} else {
			perWorkFlag = null;
			return "perSuccess";
		}
	}
	
	
	public String listt() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_LIST");
		try {
			map.clear();
			if (apply == null) {
				apply = new Apply();
			}

			// 特殊审核权限
			if (apply.getStatus_sp() != null) {
				if (apply.getStatus_sp() == 25) {
					apply.setSp_check_status(10);
					apply.setStatus(20);
				} else if (apply.getStatus_sp() == 20) {
					apply.setSp_check_status(0);
					apply.setStatus(apply.getStatus_sp());
				} else {
					apply.setStatus(apply.getStatus_sp());
					apply.setSp_check_status(null);
				}
			}
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_APPLY_LIST", map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_APPLY_LIST", map, apply, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCurrPage(Integer.parseInt((ToolsUtil.isEmpty(map.get(Parameters.Current_Page_Str)) ? "1" : map.get(Parameters.Current_Page_Str)).toString()));
			map.put("appstatus", 30);
			this.setApplys(dao.list(map));
			this.setRecCount(dao.getResultCount());
			System.out.println(applys.size());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;至事由列表";
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_VIEW");
		if ((perWorkF == null || perWorkF.equals("null")  ||perWorkF.equals("")) && (perWorkFlag == null || perWorkFlag.equals(""))) {
			perWorkFlag = null;
		} else {
			perWorkFlag = "perWork";
		}
		try {
			if (null == viewFlag) {
				this.setApply(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setApply(null);
				get_apply_depts();
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/apply_list?viewFlag=relist'>至事由列表</a>&nbsp;&gt;&nbsp;增加至事由";
			} else if ("mdy".equals(viewFlag)) {
				if (!(apply == null || apply.getUuid() == null)) {
					this.setApply((Apply) dao.get(apply.getUuid()));
				} else {
					this.setApply(null);
				}
				map.clear();
				map.put("int_id", apply.getUuid());
				map.put("approve_type", 0);
				this.setApproves(adao.list(map));
				/* 检查当前用户是否已经审阅 */
				if (adao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
				get_apply_depts();
				this.setApplyUserSign(dao.listUserSign(apply.getUuid()));

				map.clear();
				map.put("apply_id", apply.getUuid());
				map.put("status", 1);
				ApplyProductDAO adao = new ApplyProductDAO();
				this.setApplyproduct(adao.list(map));
				// this.setIndApplyProducts(independence(map, "海拔", 1));
				this.setOtherApplyProducts(independence(map, "海拔", 2));
				ApplyPosmDAO apdao = new ApplyPosmDAO();
				this.setApplyPosms(apdao.list(map));
				if(!is_total_price.equals("1")){
				for (int i = 0; i < applyproduct.size(); i++) {
					if(i==0){
						this.apply.setTotal_price(0);
					}
					double total_price=this.apply.getTotal_price()+applyproduct.get(i).getTotal_price();
					this.apply.setTotal_price(total_price);
				}
				for (int i = 0; i < applyPosms.size(); i++) {
					double total_price=this.apply.getTotal_price()+applyPosms.get(i).getTotal_price();
					this.apply.setTotal_price(total_price);
				}
				map.clear();
				map.put("uuid", apply.getUuid());
				map.put("total_price", this.apply.getTotal_price());
				dao.saveTotalPrice(map);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/apply_list?viewFlag=relist'>至事由列表</a>&nbsp;&gt;&nbsp;至事由详情";
			} else {
				this.setApply(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String view() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_VIEW");
		try {
			if (apply == null || apply.getUuid() == null) {
				this.setApply(null);
				setMessage("无显示数据.");
			} else {
				this.setApply((Apply) dao.get(apply.getUuid()));
				this.setApplyUserSign(dao.listUserSign(apply.getUuid()));
				// this.setSign((CloseOrder) dao.sign(apply.getUuid()));
			}
			map.clear();
			map.put("apply_id", apply.getUuid());
			map.put("status", 1);
			ApplyProductDAO adao = new ApplyProductDAO();
			this.setApplyproduct(adao.list(map));
			// this.setIndApplyProducts(independence(map, "海拔", 1));
			this.setOtherApplyProducts(independence(map, "海拔", 2));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!view 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!view 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_ADD");
		try {
			apply.setStatus(0);
			// apply.setApply_dept(ContextHelper.getUserLoginDept());
			apply.setApply_user(ContextHelper.getUserLoginUuid());
			apply.setApply_time(new Date());
			apply.setLm_user(ContextHelper.getUserLoginUuid());
			apply.setUuid((Integer) dao.add(apply));

			addProcess("APPLY_ADD", "至事由-新增");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_MDY");
		try {
			apply.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(apply);

			addProcess("APPLY_MDY", "至事由-修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/* 审核流程 */
	// 状态 -1:已作废 0:新事由 5:已退回 10:待审核 20:大区经理已审 30:运营总监已审
	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK0");
		try {
			check(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 作废
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check_1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK_1");
		try {
			check(-1);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check_1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check_1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核不通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK5");
		try {
			apply.setIs_push(0);
			check(5);
			spcheck(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}
	/**
	 * 退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String spt() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_SPT");
		try {
			apply.setIs_push(0);
			check(5);
			spcheck(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 办事处审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check9() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK9");
		try {
			check(9);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check10 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 区域经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check26() throws Exception {
		try {
			check(26);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK10");
		try {
			check(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 运营总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK20");
		try {
			dao.startTransaction();
			check(30);
			this.setApply((Apply) dao.get(apply.getUuid()));
			dao.commitTransaction();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check20 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check20 数据更新失败:", e);
		} finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}

	public String outStock() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_OUTSTOCK");
		try {
			// 生成出库单
			// this.setApply((Apply) dao.get(apply.getUuid()));
			map.clear();
			map.put("apply_id", apply.getUuid());
			map.put("status", 1);
			ApplyProductDAO adao = new ApplyProductDAO();
			ProductDAO pd = new ProductDAO();
			this.setApplyproduct(adao.list(map));
			Product pdi = new Product();
			List<Product> produs = new ArrayList<>();
			if (applyproduct.size() > 0) {
				for (int i = 0; i < applyproduct.size(); i++) {
					ApplyProduct ladingItem = new ApplyProduct();
					ladingItem = applyproduct.get(i);
					List<Product> pros = new ArrayList<>();
					map.clear();
					map.put("uuid", ladingItem.getProduct_id());
					pros = pd.list(map);
					if (pros.size() > 0) {
						pdi = pros.get(0);
						pdi.setNum(ladingItem.getNum());
						pdi.setDprice(ladingItem.getPer_price());
						pdi.setDtotle(ladingItem.getTotal_price());
						produs.add(pdi);
					}
				}
				addOutStock(apply, produs);
			}
			if(produs.size()<=0){
				this.setMessage("没有物料信息,不能生成出库单");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!outStock 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!outStock 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK30");
		try {
			check(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK40");
		try {
			check(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 董事审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK50");
		try {
			check(60);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check50 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	/**
	 * 总经理推送副总
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK40");
		try {
			check(70);
			SendMessage.sms_api1("15056617999","","商务系统有新的至事由审批单等待您的审批！","1");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check50 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	/**
	 * 集团副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check70() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_CHECK70");
		try {
			check(80);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!check50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!check50 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 特殊审核权限,通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String spcheck10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_SPCHECK10");
		try {
			spcheck(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!spcheck10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!spcheck10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 特殊审核权限,退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String spcheck5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_SPCHECK5");
		try {
			spcheck(5);
			// 退回时,单子同时被退回
			check(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!spcheck5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!spcheck5 数据更新失败:", e);
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_APPROVE");
		try {
			adao.add(approve, 0, apply.getUuid());
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_APPROVEDELLAST");
		try {
			adao.deleteLast(approve, 0, apply.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 修改发货信息
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyShipInfo() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDYAPPLYSHIPINFO");
		try {
			dao.mdyShipInfo(apply);
			addProcess("APPLY_CHANGE_STATUS", "至事由-出货状态更改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 状态更改通用函数
	 * 
	 * @param p_status
	 */
	public void check(int p_status) {
		apply.setStatus(p_status);
		apply.setCheck_user(ContextHelper.getUserLoginUuid());
		apply.setCheck_time(new Date());
		apply.setLm_user(ContextHelper.getUserLoginUuid());
		dao.check(apply);
		addProcess("APPLY_CHANGE_STATUS", "至事由-状态更改");
	}

	/**
	 * 状态更改通用函数
	 * 
	 * @param p_status
	 */
	public void spcheck(int p_sp_check_status) {
		apply.setSp_check_status(p_sp_check_status);
		apply.setSp_check_user(ContextHelper.getUserLoginUuid());
		apply.setSp_check_time(new Date());
		if (p_sp_check_status == 10) {
			apply.setStatus(20);
			apply.setCheck_user(ContextHelper.getUserLoginUuid());
			apply.setCheck_time(new Date());
			apply.setLm_user(ContextHelper.getUserLoginUuid());
		}
		dao.spcheck(apply);
		addProcess("APPLY_CHANGE_SPSTATUS", "至事由-特别状态更改");
	}

	private void addProcess(String p_sign, String p_note) {
		ProcessDAO pdao = new ProcessDAO();
		if (apply != null) {
			pdao.addProcess(2, apply.getUuid(), p_sign, p_note, apply.getStatus(), apply.getSp_check_status(), apply.getShip_status());
		}
	}

	public void get_apply_depts() {
		Map<String, String> newMap = new HashMap<String, String>();
		newMap = ContextHelper.getUserLoginInfo().getPermit_depts2();
		Set<String> set = newMap.keySet();
		List<Active> acs = new ArrayList<>();
		for (String s : set) {
			Active ac = new Active();
			ac.setApply_dept(s);
			String value = newMap.get(s);
			ac.setApply_dept_name(value.substring(0, value.indexOf("#")));
			acs.add(ac);
		}
		this.setGetapply_depts(acs);
		this.setUserappid(ContextHelper.getUserLoginUuid());
		this.setUserdepta(ContextHelper.getUserLoginDept());
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_DEL");
		try {
			dao.delete(apply);
			addProcess("APPLY_DEL", "至事由-删除");
			setMessage("删除成功!ID=" + apply.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 生成出库单20150722sun
	 * 
	 * @return
	 * @throws Exception
	 */
	public void addOutStock(Apply apply, List<Product> produs) throws Exception {
		try {
			dao.startTransaction();
			OutStockDAO isa = new OutStockDAO();
			LadingAction l = new LadingAction();
			Integer goid = null;
			if(outsstock!=null && outsstock.getStore_id()!=null){
				goid=outsstock.getStore_id();
			}
			isa.addStock(apply.getUuid(), goid, null, 2, 3, produs, null, false, null, null);// 生成销售用酒出库
			
			//修改状态
			apply.setGoflag(4);
			dao.mdyApplyGoflag(apply);
			dao.commitTransaction();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			dao.endTransaction();
		}
		
	}

	private List<ApplyProduct> independence(Map<String, Object> map, String title, int flag) {
		ApplyProductDAO adao = new ApplyProductDAO();
		List<ApplyProduct> products = new ArrayList<>();
		ApplyProduct pri = new ApplyProduct();
		/*
		 * if (flag == 1) {// 是需要独立显示的商品
		 * map.put("title", title);
		 * map.remove("othertitle");
		 * products = adao.list(map);
		 * if (products.size() > 0) {
		 * for (int i = 0; i < products.size(); i++) {
		 * pri = products.get(i);
		 * indprice = indprice + pri.getTotal_price();
		 * }
		 * }
		 * } else {
		 */
		map.remove("title");
		// map.put("othertitle", title);
		products = adao.list(map);
		/* } */
		return products;
	}
	
	
	public String push() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_APPLY_DEL");
		try {
			dao.push(apply);
			apply.setIs_push(1);
			check20();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	
	public String yijiao() throws Exception {
		map.clear();
		map.put("code", apply.getUuid());
	
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		map.put("name", ulf.getDept_cname());
		dao.adds(map);
		return SUCCESS;
	}
	
}
