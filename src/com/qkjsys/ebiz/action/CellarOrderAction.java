package com.qkjsys.ebiz.action;

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
import com.qkjsys.ebiz.dao.CellarOrderDAO;
import com.qkjsys.ebiz.dao.MemberCellarDAO;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.CellarOrder;
import com.qkjsys.ebiz.domain.MemberCellar;
import com.qkjsys.ebiz.domain.Order;
import com.qkjsys.ebiz.domain.Ware;

public class CellarOrderAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CellarOrderAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CellarOrderDAO dao = new CellarOrderDAO();

	private Integer memberCellarID;
	private Order order;
	private List<Ware> wares;
	// private OrderCellar orderCellar;
	private MemberCellar memberCellar;
	private CellarOrder cellarOrder;
	private List<CellarOrder> cellarOrders;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;取酒订单";

	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}

	public MemberCellar getMemberCellar() {
		return memberCellar;
	}

	public void setMemberCellar(MemberCellar memberCellar) {
		this.memberCellar = memberCellar;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public CellarOrder getCellarOrder() {
		return cellarOrder;
	}

	public void setCellarOrder(CellarOrder cellarOrder) {
		this.cellarOrder = cellarOrder;
	}

	public List<CellarOrder> getCellarOrders() {
		return cellarOrders;
	}

	public void setCellarOrders(List<CellarOrder> cellarOrders) {
		this.cellarOrders = cellarOrders;
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

	public Integer getMemberCellarID() {
		return memberCellarID;
	}

	public void setMemberCellarID(Integer memberCellarID) {
		this.memberCellarID = memberCellarID;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_LIST");
		try {
			WareDAO wdao = new WareDAO();
			this.setWares(wdao.list(null));

			map.clear();
			if (cellarOrder != null)
				map.putAll(ToolsUtil.getMapByBean(cellarOrder));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCellarOrders(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;取酒订单列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setCellarOrder(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				if (this.getMemberCellarID() == null) {
					setMessage("参数异常!");
					return SUCCESS;
				}
				this.setCellarOrder(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/cellarOrder_list'>取酒订单列表</a>&nbsp;&gt;&nbsp;增加取酒订单";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", cellarOrder.getUuid());
				if (null == map.get("uuid"))
					this.setCellarOrder(null);
				else
					this.setCellarOrder((CellarOrder) dao.list(map).get(0));

				this.setMemberCellarID(cellarOrder.getMember_cellar_id());
			} else {
				this.setCellarOrder(null);
				setMessage("无操作类型!");
			}

			this.setOrder((Order) dao.getOrderByMemberCellarID(this.getMemberCellarID()));

			MemberCellarDAO mdao = new MemberCellarDAO();
			this.setMemberCellar((MemberCellar) mdao.get(this.getMemberCellarID()));
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/cellarOrder_list'>取酒订单列表</a>&nbsp;&gt;&nbsp;修改取酒订单";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_ADD");
		try {
			String uuid = ToolsUtil.getUUIDByDateRandom();
			cellarOrder.setUuid(uuid);
			cellarOrder.setMember_cellar_id(this.getMemberCellarID());
			cellarOrder.setStatus(10);
			cellarOrder.setOrder_source(1);
			cellarOrder.setAdd_user(ContextHelper.getUserLoginUuid());
			cellarOrder.setAdd_time(new Date());
			cellarOrder.setLm_user(ContextHelper.getUserLoginUuid());
			cellarOrder.setLm_time(new Date());
			dao.add(cellarOrder);
			log.info("取酒订单下单成功!" + uuid);
			dao.outCellarStockByCellarOrderID(uuid);
			log.info("库存调整成功!" + uuid);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_MDY");
		try {
			// 每次保存,要重新调整库存,先回库在出库
			dao.inCellarStockByCellarOrderID(cellarOrder.getUuid());

			cellarOrder.setLm_user(ContextHelper.getUserLoginUuid());
			cellarOrder.setLm_time(new Date());
			dao.save(cellarOrder);

			dao.outCellarStockByCellarOrderID(cellarOrder.getUuid());
			log.info("库存调整成功!" + cellarOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 订单作废
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-20 上午9:41:52
	 */
	public String order_check0() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_CHECK0");
		try {
			setCellarOrderStatus(0);
			log.info("库存调整成功!" + cellarOrder.getUuid());
			dao.inCellarStockByCellarOrderID(cellarOrder.getUuid());
			log.info("库存调整成功!" + cellarOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 灌装完成
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-20 上午9:41:52
	 */
	public String order_check10() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_CHECK10");
		try {
			setCellarOrderStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 重新灌装
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-20 上午9:41:52
	 */
	public String order_check15() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_CHECK15");
		try {
			setCellarOrderStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 发货完成
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-20 上午9:41:52
	 */
	public String order_check20() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_CHECK20");
		try {
			setCellarOrderStatus(30);

			// 判断是否需要把藏酒标记置为"删除"
			MemberCellarDAO mdao = new MemberCellarDAO();
			mdao.delCellarByCellarOrderID(cellarOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check20 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check20 数据更新失败:", e);
		}
		return SUCCESS;
	}

	private void setCellarOrderStatus(Integer status) {
		cellarOrder.setStatus(status);
		cellarOrder.setLm_user(ContextHelper.getUserLoginUuid());
		cellarOrder.setLm_time(new Date());
		dao.mdyCellarOrderStatus(cellarOrder);
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_CELLARORDER_DEL");
		try {
			dao.delete(cellarOrder);
			setMessage("删除成功!ID=" + cellarOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
