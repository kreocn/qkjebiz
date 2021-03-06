package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.MemberCapital;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActiveMemcostDAO;
import com.qkj.manage.dao.ActivePosmDAO;
import com.qkj.manage.dao.ActiveProductDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.ActiveMemcost;
import com.qkj.manage.domain.ActivePosm;
import com.qkj.manage.domain.ActiveProduct;
import com.qkj.manage.domain.Product;

public class ActiveAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ActiveAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ActiveDAO dao = new ActiveDAO();

	private Active active;
	private List<Active> actives;

	private List<Product> products;
	private List<ActiveProduct> activeProducts;
	private List<ActivePosm> activePosms;
	private List<ActiveMemcost> activeMemcosts;

	private List<ActiveProduct> activeProductsClose;
	private List<ActivePosm> activePosmsClose;
	private List<ActiveMemcost> activeMemcostsClose;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public List<ActiveProduct> getActiveProductsClose() {
		return activeProductsClose;
	}

	public void setActiveProductsClose(List<ActiveProduct> activeProductsClose) {
		this.activeProductsClose = activeProductsClose;
	}

	public List<ActivePosm> getActivePosmsClose() {
		return activePosmsClose;
	}

	public void setActivePosmsClose(List<ActivePosm> activePosmsClose) {
		this.activePosmsClose = activePosmsClose;
	}

	public List<ActiveMemcost> getActiveMemcostsClose() {
		return activeMemcostsClose;
	}

	public void setActiveMemcostsClose(List<ActiveMemcost> activeMemcostsClose) {
		this.activeMemcostsClose = activeMemcostsClose;
	}

	public List<ActiveMemcost> getActiveMemcosts() {
		return activeMemcosts;
	}

	public void setActiveMemcosts(List<ActiveMemcost> activeMemcosts) {
		this.activeMemcosts = activeMemcosts;
	}

	public List<ActivePosm> getActivePosms() {
		return activePosms;
	}

	public void setActivePosms(List<ActivePosm> activePosms) {
		this.activePosms = activePosms;
	}

	public List<ActiveProduct> getActiveProducts() {
		return activeProducts;
	}

	public void setActiveProducts(List<ActiveProduct> activeProducts) {
		this.activeProducts = activeProducts;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Active getActive() {
		return active;
	}

	public void setActive(Active active) {
		this.active = active;
	}

	public List<Active> getActives() {
		return actives;
	}

	public void setActives(List<Active> actives) {
		this.actives = actives;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_LIST");
		try {
			map.clear();
			if (active == null) active = new Active();
			ContextHelper.setSearchDeptPermit4Search(map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_ACTIVE_LIST", map, active, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setActives(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setActive(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setActive(null);
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag)) {
				if (!(active == null || active.getUuid() == null)) {
					this.setActive((Active) dao.get(active.getUuid()));
				} else {
					this.setActive(null);
				}

				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				ActiveProductDAO adao = new ActiveProductDAO();
				this.setActiveProducts(adao.list(map));
				ActivePosmDAO podao = new ActivePosmDAO();
				this.setActivePosms(podao.list(map));
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();
				this.setActiveMemcosts(amdao.list(map));
			} else {
				this.setActive(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	// TODO
	public String loadView() throws Exception {
		try {
			if (!(active == null || active.getUuid() == null)) {
				this.setActive((Active) dao.get(active.getUuid()));

				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				ActiveProductDAO adao = new ActiveProductDAO();
				this.setActiveProducts(adao.list(map));
				ActivePosmDAO podao = new ActivePosmDAO();
				this.setActivePosms(podao.list(map));
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();
				this.setActiveMemcosts(amdao.list(map));
			} else {
				this.setActive(null);
				this.setMessage("数据读取错误,请按照正确的方式进入页面!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_ADD");
		try {
			active.setUuid(ToolsUtil.getCommonUUID("S"));
			active.setAdd_user(ContextHelper.getUserLoginUuid());
			active.setApply_dept(ContextHelper.getUserLoginDept());
			active.setApply_user(ContextHelper.getUserLoginUuid());
			dao.add(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDY");
		try {
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_DEL");
		try {
			dao.delete(active);
			setMessage("删除成功!ID=" + active.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	// 审核流程

	// 0:新申请 1:申请审批中 2:申请通过 3:开始结案 4:结案审批中 5:结案通过
	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS0");
		try {
			mdyStatus(1);
			// 同时进入销售部审核流程
			mdyActiveSDStatus(10);
			// 销售管理部默认为已签收
			mdyActiveSMDStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审批通过,可以执行
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS1");
		try {
			// mdyStatus(2);
			ContextHelper.getUserLoginUuid();
			dao.mdyActivePass(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 通用改状态函数
	 * 
	 * @param status
	 * @return
	 * @date 2014-4-26 上午10:15:02
	 */
	private int mdyStatus(int status) {
		active.setStatus(status);
		active.setLm_user(ContextHelper.getUserLoginUuid());
		return dao.mdyActiveStatus(active);
	}

	/**
	 * 审核退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS");
		try {
			mdyActiveSDStatus(5);
			mdyStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS10");
		try {
			mdyActiveSDStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 运营总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS30");
		try {
			mdyActiveSDStatus(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS40");
		try {
			mdyActiveSDStatus(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS50");
		try {
			mdyActiveSDStatus(60);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus50 数据更新失败:", e);
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
	public int mdyActiveSDStatus(int sd_status) {
		active.setSd_status(sd_status);
		active.setSd_time(new Date());
		active.setSd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		return dao.mdyActiveSDStatus(active);
	}

	/**
	 * 签收
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS0");
		try {
			mdyActiveSMDStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus0 数据更新失败:", e);
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
	public String mdyActiveSMDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS");
		try {
			mdyActiveSMDStatus(5);
			mdyStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus5 数据更新失败:", e);
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
	public String mdyActiveSMDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS10");
		try {
			mdyActiveSMDStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus10 数据更新失败:", e);
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
	public String mdyActiveSMDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS40");
		try {
			mdyActiveSMDStatus(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyActiveSMDStatus(int smd_status) {
		active.setSmd_status(smd_status);
		active.setSmd_time(new Date());
		active.setSmd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		return dao.mdyActiveSMDStatus(active);
	}

	/*********************************************************************/
	/* 开始结案流程 */
	/*********************************************************************/
	public String closeLoad() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE");
		try {
			if (!(active == null || active.getUuid() == null)) {
				this.setActive((Active) dao.get(active.getUuid()));

				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				ActiveProductDAO adao = new ActiveProductDAO();
				ActivePosmDAO podao = new ActivePosmDAO();
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();

				this.setActiveProducts(adao.list(map));
				this.setActivePosms(podao.list(map));
				this.setActiveMemcosts(amdao.list(map));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 2);
				this.setActiveProductsClose(adao.list(map));
				this.setActivePosmsClose(podao.list(map));
				this.setActiveMemcostsClose(amdao.list(map));

			} else {
				this.setActive(null);
				this.setMessage("数据读取错误,请按照正确的方式进入页面!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	// TODO
	public String closeViewLoad() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE");
		try {
			if (!(active == null || active.getUuid() == null)) {
				this.setActive((Active) dao.get(active.getUuid()));

				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));

				ActiveProductDAO adao = new ActiveProductDAO();
				ActivePosmDAO podao = new ActivePosmDAO();
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				this.setActiveProducts(adao.list(map));
				this.setActivePosms(podao.list(map));
				this.setActiveMemcosts(amdao.list(map));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 2);
				this.setActiveProductsClose(adao.list(map));
				this.setActivePosmsClose(podao.list(map));
				this.setActiveMemcostsClose(amdao.list(map));
			} else {
				this.setActive(null);
				this.setMessage("数据读取错误,请按照正确的方式进入页面!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	/**
	 * 修改结案单(只能修改结案详情和备注)
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCloseActive() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_MDY");
		try {
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyCloseActive(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActive 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActive 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 开始结案
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus2() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS2");
		try {
			dao.startActiveCloseFlow(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus2 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus2 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案报审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus3() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS3");
		try {
			mdyStatus(4);
			// 同时销售部的流程变成待审核
			mdyCloseActiveSDStatus(10);
			// 同时销管部的流程变成已签收
			mdyCloseActiveSMDStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus4() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS4");
		try {
			// mdyStatus(5);
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyCloseActivePass(active);
			// 调整随量积分
			mdyMemberCapital();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// 办事处经理审核流程去除
	// 销售部-审核状态 0:初始状态 5:审核退回 10:待审核 20:办事处经理审核通过
	// 30:大区经理审核通过 40:运营总监审核通过 50:业务副总审核通过 60:总经理审核通过

	/**
	 * 销售部-结案退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS5");
		try {
			mdyCloseActiveSDStatus(5);
			mdyStatus(3);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10");
		try {
			mdyCloseActiveSDStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 运营总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS30");
		try {
			mdyCloseActiveSDStatus(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 销售副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS40");
		try {
			mdyCloseActiveSDStatus(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50");
		try {
			mdyCloseActiveSDStatus(60);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus50 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseActiveSDStatus(int close_sd_status) {
		active.setClose_sd_status(close_sd_status);
		active.setClose_sd_time(new Date());
		active.setClose_sd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		return dao.mdyCloseActiveSDStatus(active);
	}

	// 去除销管部经理已审,没有这个流程
	// 销售管理部-审核状态 0:未签收 5:审核退回 10:已签收 20:主管已审 30:销管经理已审 40:销管部经理已审 50:副总已审

	/**
	 * 销管部-结案退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS5");
		try {
			mdyCloseActiveSMDStatus(5);
			mdyStatus(3);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部-销管经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS10");
		try {
			mdyCloseActiveSMDStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部-销管副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS30");
		try {
			mdyCloseActiveSMDStatus(50);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseActiveSMDStatus(int close_sd_status) {
		active.setClose_smd_status(close_sd_status);
		active.setClose_smd_time(new Date());
		active.setClose_smd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		return dao.mdyCloseActiveSMDStatus(active);
	}

	/**
	 * 扣除随量积分动作(结案审核完成之后)
	 * 
	 * @date 2014-4-26 下午10:19:28
	 */
	public void mdyMemberCapital() {
		ActiveMemcostDAO amdao = new ActiveMemcostDAO();
		map.clear();
		map.put("active_id", active.getUuid());
		map.put("status", 2);
		this.setActiveMemcostsClose(amdao.list(map));
		if (!(activeMemcostsClose == null || activeMemcostsClose.size() == 0)) {
			MemberCapitalDAO mdao = new MemberCapitalDAO();
			MemberCapital memberCapital;
			for (ActiveMemcost am : activeMemcostsClose) {
				memberCapital = new MemberCapital();
				memberCapital.setMember_id(am.getMember_id());
				memberCapital.setWith_score(am.getWith_score());
				mdao.mdyCapital(memberCapital, 8, 0, "积分调整,调整编号:[" + active.getUuid() + "-" + am.getUuid() + "]");
			}
		}
	}

	/**
	 * 修改发货信息
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyShipInfo() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO");
		try {
			dao.mdyShipInfo(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
