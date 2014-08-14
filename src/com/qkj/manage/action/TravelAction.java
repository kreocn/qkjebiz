package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.TravelCustomerDAO;
import com.qkj.manage.dao.TravelDAO;
import com.qkj.manage.domain.Travel;
import com.qkj.manage.domain.TravelCustomer;

public class TravelAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(TravelAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private TravelDAO dao = new TravelDAO();
	private TravelCustomerDAO cdao = new TravelCustomerDAO();

	private Travel travel;
	private List<Travel> travels;

	private List<TravelCustomer> travelCustomers;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public List<TravelCustomer> getTravelCustomers() {
		return travelCustomers;
	}

	public Travel getTravel() {
		return travel;
	}

	public void setTravel(Travel travel) {
		this.travel = travel;
	}

	public List<Travel> getTravels() {
		return travels;
	}

	public void setTravels(List<Travel> travels) {
		this.travels = travels;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_LIST");
		try {
			map.clear();
			if (travel != null) map.putAll(ToolsUtil.getMapByBean(travel));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setTravels(dao.list(map));
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
				this.setTravel(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				// this.setTravel(null);
				if (travel == null) {
					travel = new Travel();
				}
				travel.setApply_dept(ContextHelper.getUserLoginDept());
				travel.setApply_dept_name(ContextHelper.getUserLoginDeptName());
				travel.setApply_user(ContextHelper.getUserLoginUuid());
				travel.setApply_user_name(ContextHelper.getUserLoginInfo().getUser_name());
			} else if ("mdy".equals(viewFlag) || "print".equals(viewFlag)) {
				if (!(travel == null || travel.getUuid() == null)) {
					this.setTravel((Travel) dao.get(travel.getUuid()));
				} else {
					this.setViewFlag("add");
					load();
					// this.setTravel(null);
				}

				// checkbox专用转换
				if (!ToolsUtil.isEmpty(travel.getApply_item())) {
					travel.setApply_items(travel.getApply_item().split(","));
				}
				if (!ToolsUtil.isEmpty(travel.getCar())) {
					travel.setCars(travel.getCar().split(","));
				}

				map.clear();
				map.put("travel_id", travel.getUuid());
				travelCustomers = cdao.list(map);

			} else {
				this.setTravel(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ADD");
		try {
			travel.setCheck_status(0);
			travel.setAcheck_status(0);
			travel.setAdd_user(ContextHelper.getUserLoginUuid());
			travel.setAdd_time(new Date());
			travel.setLm_user(ContextHelper.getUserLoginUuid());
			travel.setLm_time(new Date());

			// checkbox 专用转换
			travel.setApply_item(ToolsUtil.Array2String(travel.getApply_items() == null ? new String[] {} : travel.getApply_items(), ","));
			travel.setCar(ToolsUtil.Array2String(travel.getCars() == null ? new String[] {} : travel.getCars(), ","));

			travel.setUuid((Integer) dao.add(travel));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_MDY");
		try {
			// checkbox 专用转换
			travel.setApply_item(ToolsUtil.Array2String(travel.getApply_items() == null ? new String[] {} : travel.getApply_items(), ","));
			travel.setCar(ToolsUtil.Array2String(travel.getCars() == null ? new String[] {} : travel.getCars(), ","));

			travel.setLm_user(ContextHelper.getUserLoginUuid());
			travel.setLm_time(new Date());
			dao.save(travel);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_DEL");
		try {
			dao.delete(travel);
			setMessage("删除成功!ID=" + travel.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK");
		try {
			mdyCheckStatus(10);
			mdyACheckStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheck 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheck 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务审核退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK5");
		try {
			mdyCheckStatus(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus5 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus5 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK10");
		try {
			mdyCheckStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus10 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus10 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK20");
		try {
			mdyCheckStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus20 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus20 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK30");
		try {
			mdyCheckStatus(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus30 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus30 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政审核退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK5");
		try {
			mdyACheckStatus(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus5 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus5 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK10");
		try {
			mdyACheckStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus10 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus10 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK20");
		try {
			mdyACheckStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus20 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus20 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK30");
		try {
			mdyACheckStatus(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus30 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus30 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改变业务审核状态通用函数
	 * 
	 * @param checkStatus
	 *            0:新单 5:已退回 10:待审核 20:大区经理已审 30:运营总监已审 40:业务副总已审
	 */
	public void mdyCheckStatus(Integer checkStatus) {
		travel.setCheck_status(checkStatus);
		travel.setCheck_user(ContextHelper.getUserLoginUuid());
		travel.setCheck_time(new Date());
		travel.setLm_user(ContextHelper.getUserLoginUuid());
		travel.setLm_time(new Date());
		dao.mdyCheckStatus(travel);
	}

	/**
	 * 改变行政审核状态通用函数
	 * 
	 * @param checkStatus
	 *            0:新单 5:已退回 10:待审核 20:行政经理已审 30:行政副总已审 40:总经理已审
	 */
	public void mdyACheckStatus(Integer checkStatus) {
		travel.setAcheck_status(checkStatus);
		travel.setAcheck_user(ContextHelper.getUserLoginUuid());
		travel.setAcheck_time(new Date());
		travel.setLm_user(ContextHelper.getUserLoginUuid());
		travel.setLm_time(new Date());
		dao.mdyACheckStatus(travel);
	}
}
