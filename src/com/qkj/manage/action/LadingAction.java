package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.User;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.LadingDAO;
import com.qkj.manage.dao.LadingItemDAO;
import com.qkj.manage.dao.LadingPayDAO;
import com.qkj.manage.dao.LadingProductgDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Lading;
import com.qkj.manage.domain.LadingItem;
import com.qkj.manage.domain.LadingPay;
import com.qkj.manage.domain.LadingProductg;
import com.qkj.manage.domain.Product;

public class LadingAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(LadingAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private LadingDAO dao = new LadingDAO();

	private Lading lading;
	private List<Lading> ladings;
	private List<User> users;
	private List<Product> products;
	private List<LadingItem> ladingItems;
	private List<LadingProductg> ladingProductgs;
	private List<LadingPay> ladingPays;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public List<LadingProductg> getLadingProductgs() {
		return ladingProductgs;
	}

	public void setLadingProductgs(List<LadingProductg> ladingProductgs) {
		this.ladingProductgs = ladingProductgs;
	}

	public List<LadingPay> getLadingPays() {
		return ladingPays;
	}

	public void setLadingPays(List<LadingPay> ladingPays) {
		this.ladingPays = ladingPays;
	}

	public List<LadingItem> getLadingItems() {
		return ladingItems;
	}

	public void setLadingItems(List<LadingItem> ladingItems) {
		this.ladingItems = ladingItems;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Lading getLading() {
		return lading;
	}

	public void setLading(Lading lading) {
		this.lading = lading;
	}

	public List<Lading> getLadings() {
		return ladings;
	}

	public void setLadings(List<Lading> ladings) {
		this.ladings = ladings;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_LIST");
		try {
			map.clear();
			if (lading == null) {
				lading = new Lading();
			}
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_LADING_LIST", map, lading, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setLadings(dao.list(map));
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
				this.setLading(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setLading(null);
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag) || "print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", lading.getUuid());
				if (null == map.get("uuid")) this.setLading(null);
				else {
					if ("view".equals(viewFlag)) {
						map.put("status", 2);
					}
					this.setLading((Lading) dao.list(map).get(0));
					if (!ToolsUtil.isEmpty(lading.getFd_type())) {
						lading.setFd_types(lading.getFd_type().split(","));
					}

					ProductDAO pdao = new ProductDAO();
					this.setProducts(pdao.list(null));

					LadingItemDAO idao = new LadingItemDAO();
					map.clear();
					map.put("lading_id", lading.getUuid());
					this.setLadingItems(idao.list(map));

					LadingProductgDAO gdao = new LadingProductgDAO();
					map.clear();
					map.put("lading_id", lading.getUuid());
					this.setLadingProductgs(gdao.list(map));

					// LadingPayDAO lpdao = new LadingPayDAO();
					// map.clear();
					// map.put("lading_id", lading.getUuid());
					// this.setLadingPays(lpdao.list(map));
				}
			} else {
				this.setLading(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			// lading.setUuid(ToolsUtil.getCommonUUID("T"));
			lading.setApplicant(u);
			lading.setApply_time(d);
			lading.setManager_check(0);
			lading.setSd_check(0);
			lading.setMd_check(0);
			lading.setFd_check(0);
			lading.setCoo_check(0);
			lading.setStatus(0);
			lading.setAdd_time(d);
			lading.setAdd_user(u);
			lading.setLm_user(u);
			lading.setUuid((Integer) dao.add(lading));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String addProd() throws Exception {
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_MDY");
		try {
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_DEL");
		try {
			dao.delete(lading);
			setMessage("删除成功!ID=" + lading.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 进入报批流程
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-27 下午1:51:52
	 */
	public String saveLadingStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_STATUS0");
		try {
			lading.setStatus(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingStatus(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveLadingStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveLadingStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 进入结案状态
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-27 下午1:53:24
	 */
	public String saveLadingStatus1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_STATUS1");
		try {
			lading.setClose_time(new Date());
			lading.setStatus(2);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingStatus(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveLadingStatus1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveLadingStatus1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// mdyLadingManagerCheck
	public String mdyLadingManagerCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_MANAGERCHECK");
		try {
			lading.setManager_check_user(ContextHelper.getUserLoginUuid());
			lading.setManager_check(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingManagerCheck(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingManagerCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingManagerCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// mdyLadingSDCheck
	public String mdyLadingSDCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_SDCHECK");
		try {
			lading.setSd_check_user(ContextHelper.getUserLoginUuid());
			lading.setSd_check(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingSDCheck(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingSDCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingSDCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// mdyLadingMDCheck
	public String mdyLadingMDCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_MDCHECK");
		try {
			lading.setMd_check_user(ContextHelper.getUserLoginUuid());
			lading.setMd_check(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingMDCheck(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingMDCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingMDCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// mdyLadingFDCheck
	public String mdyLadingFDCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_FDCHECK");
		try {
			lading.setFd_check_user(ContextHelper.getUserLoginUuid());
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			lading.setFd_type(ToolsUtil.Array2String(lading.getFd_types() == null ? new String[] {} : lading.getFd_types(), ","));
			dao.mdyLadingFDCheck(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingFDCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingFDCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// mdyLadingCOOCheck
	public String mdyLadingCOOCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_COOCHECK");
		try {
			lading.setCoo_check_user(ContextHelper.getUserLoginUuid());
			lading.setCoo_check(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingCOOCheck(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingCOOCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingCOOCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String mdyLadingOutFlag1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_OUTFLAG1");
		try {
			lading.setOut_flag(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingOutFlag(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingOutFlag1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingOutFlag1 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
