package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.LadingItemDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.RebatesDAO;
import com.qkj.manage.dao.RebatesProductDAO;
import com.qkj.manage.domain.LadingItem;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.Rebates;
import com.qkj.manage.domain.RebatesLading;
import com.qkj.manage.domain.RebatesProduct;

public class RebatesAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(RebatesAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private RebatesDAO dao = new RebatesDAO();

	private Rebates rebates;
	private List<Rebates> rebatess;

	private List<RebatesLading> rebatesLadings;
	private List<LadingItem> ladingItems;
	private List<Product> products;
	private List<RebatesProduct> rebatesProducts;

	private String[] ladingsNeedsRebates;
	private List<String> re_scales;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;返利申请单列表";
	
	public String getPath() {
		return path;
	}

	public List<String> getRe_scales() {
		return re_scales;
	}

	public void setRe_scales(List<String> re_scales) {
		this.re_scales = re_scales;
	}

	public List<RebatesProduct> getRebatesProducts() {
		return rebatesProducts;
	}

	public void setRebatesProducts(List<RebatesProduct> rebatesProducts) {
		this.rebatesProducts = rebatesProducts;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<RebatesLading> getRebatesLadings() {
		return rebatesLadings;
	}

	public void setRebatesLadings(List<RebatesLading> rebatesLadings) {
		this.rebatesLadings = rebatesLadings;
	}

	public List<LadingItem> getLadingItems() {
		return ladingItems;
	}

	public void setLadingItems(List<LadingItem> ladingItems) {
		this.ladingItems = ladingItems;
	}

	public String[] getLadingsNeedsRebates() {
		return ladingsNeedsRebates;
	}

	public void setLadingsNeedsRebates(String[] ladingsNeedsRebates) {
		this.ladingsNeedsRebates = ladingsNeedsRebates;
	}

	public Rebates getRebates() {
		return rebates;
	}

	public void setRebates(Rebates rebates) {
		this.rebates = rebates;
	}

	public List<Rebates> getRebatess() {
		return rebatess;
	}

	public void setRebatess(List<Rebates> rebatess) {
		this.rebatess = rebatess;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_LIST");
		try {
			map.clear();
			if (rebates == null)
				rebates = new Rebates();
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_REBATES_LIST", map, rebates, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setRebatess(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;返利申请单列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setRebates(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setRebates(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/rebates_list?viewFlag=relist'>返利申请单列表</a>&nbsp;&gt;&nbsp;增加返利申请单";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag) || "print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", rebates.getUuid());
				if (null != map.get("uuid")) {
					this.setRebates((Rebates) dao.list(map).get(0));

					// 得到出货单列表
					map.clear();
					map.put("rebates_id", rebates.getUuid());
					this.setRebatesLadings(dao.listRebatesLadings(map));

					// 根据出货单统计出所有返利信息
					LadingItemDAO ldao = new LadingItemDAO();
					this.setLadingItems(ldao.listSumByRebatesID(rebates.getUuid()));

					// 所有产品列表
					ProductDAO pdao = new ProductDAO();
					this.setProducts(pdao.list(null));

					// 返利实体列表
					RebatesProductDAO rdao = new RebatesProductDAO();
					map.clear();
					map.put("rebates_id", rebates.getUuid());
					this.setRebatesProducts(rdao.list(map));

					// 取得返利系数%
					if (ToolsUtil.isEmpty(rebates.getRe_scale())) {
						if (ladingItems != null && ladingItems.size() > 0) {
							String[] tmp = new String[ladingItems.size()];
							for (int i = 0; i < tmp.length; i++) {
								tmp[i] = ladingItems.get(i).getGroup_rebates() == null ? "0" : ladingItems.get(i)
										.getGroup_rebates().toString();
							}
							setRe_scales(Arrays.asList(tmp));
						} else {
							setRe_scales(new ArrayList<String>());
						}
					} else {
						setRe_scales(Arrays.asList(rebates.getRe_scale().split("#")));
					}
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/rebates_list?viewFlag=relist'>返利申请单列表</a>&nbsp;&gt;&nbsp;修改返利申请单";
			} else {
				this.setRebates(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_ADD");
		try {
			rebates.setApplicant(ContextHelper.getUserLoginUuid());
			rebates.setApply_time(new Date());
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			rebates.setUuid((int) dao.add(rebates));
			dao.addRebatesLadingBatch(rebates.getUuid(), ladingsNeedsRebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_MDY");
		try {
			rebates.setRe_scale(ToolsUtil.List2String(getRe_scales(), "#"));
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_DEL");
		try {
			dao.delete(rebates);
			setMessage("删除成功!ID=" + rebates.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报主管审批
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:06
	 */
	public String mdyRebatesStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_STATUS0");
		try {
			rebates.setStatus(10);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报经理审批
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyRebatesStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_STATUS10");
		try {
			rebates.setStatus(20);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报财务审批
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyRebatesStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_STATUS20");
		try {
			rebates.setStatus(30);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报运营总监审批
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyRebatesStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_STATUS30");
		try {
			rebates.setStatus(40);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报总经理审批
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyRebatesStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_STATUS40");
		try {
			rebates.setStatus(50);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyRebatesStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_STATUS50");
		try {
			rebates.setStatus(60);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 出货确认标记
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyOutFlag() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_OUTFLAG");
		try {
			rebates.setOut_flag(1);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyOutFlag(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyOutFlag 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyOutFlag 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务确认标记
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-17 下午3:29:20
	 */
	public String mdyFDCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_REBATES_FDCHECK");
		try {
			rebates.setFd_check(1);
			rebates.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyFDCheck(rebates);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyFDCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyFDCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}
}