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
import com.qkjsys.ebiz.dao.GoodsDAO;
import com.qkjsys.ebiz.dao.MemberCellarDAO;
import com.qkjsys.ebiz.dao.OrderActnDAO;
import com.qkjsys.ebiz.dao.OrderCellarDAO;
import com.qkjsys.ebiz.dao.OrderDAO;
import com.qkjsys.ebiz.dao.OrderGoodsDAO;
import com.qkjsys.ebiz.domain.Goods;
import com.qkjsys.ebiz.domain.MemberCellar;
import com.qkjsys.ebiz.domain.Order;
import com.qkjsys.ebiz.domain.OrderActn;
import com.qkjsys.ebiz.domain.OrderGoods;

public class OrderAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OrderAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OrderDAO dao = new OrderDAO();

	private Order order;
	private List<Order> orders;

	private List<Goods> goodss;

	private OrderGoods orderGoods;
	private List<OrderGoods> orderGoodss;

	private List<OrderActn> orderActns;

	// 打印专用
	private List<MemberCellar> memberCellars;

	private String op_message;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;客户藏酒";
	
	public String getPath() {
		return path;
	}

	public List<MemberCellar> getMemberCellars() {
		return memberCellars;
	}

	public List<OrderActn> getOrderActns() {
		return orderActns;
	}

	public void setOrderActns(List<OrderActn> orderActns) {
		this.orderActns = orderActns;
	}

	public String getOp_message() {
		return op_message;
	}

	public void setOp_message(String op_message) {
		this.op_message = op_message;
	}

	public OrderGoods getOrderGoods() {
		return orderGoods;
	}

	public void setOrderGoods(OrderGoods orderGoods) {
		this.orderGoods = orderGoods;
	}

	public List<Goods> getGoodss() {
		return goodss;
	}

	public void setGoodss(List<Goods> goodss) {
		this.goodss = goodss;
	}

	public List<OrderGoods> getOrderGoodss() {
		return orderGoodss;
	}

	public void setOrderGoodss(List<OrderGoods> orderGoodss) {
		this.orderGoodss = orderGoodss;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
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

	public void setPath(String path) {
		this.path = path;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_LIST");
		try {
			map.clear();
			if (order == null) {
				order = new Order();
			}
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("QKJCJ_SYSEBIZ_ORDER_LIST", map, order, viewFlag);

			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setOrders(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;订单列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setOrder(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setOrder(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/order_list?viewFlag=relist'>订单列表</a>&nbsp;&gt;&nbsp;添加订单";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", order.getUuid());
				if (null == map.get("uuid"))
					this.setOrder(null);
				else
					this.setOrder((Order) dao.list(map).get(0));

				map.clear();
				map.put("order_id", order.getUuid());
				OrderGoodsDAO odao = new OrderGoodsDAO();
				this.setOrderGoodss(odao.list(map));

				map.clear();
				map.put("order_id", order.getUuid());
				OrderActnDAO oad = new OrderActnDAO();
				this.setOrderActns(oad.list(map));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/order_list?viewFlag=relist'>订单列表</a>&nbsp;&gt;&nbsp;修改订单";
			} else if ("print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", order.getUuid());
				if (null == map.get("uuid"))
					this.setOrder(null);
				else
					this.setOrder((Order) dao.list(map).get(0));

				map.clear();
				map.put("order_id", order.getUuid());
				OrderGoodsDAO odao = new OrderGoodsDAO();
				this.setOrderGoodss(odao.list(map));

				MemberCellarDAO mdao = new MemberCellarDAO();
				map.clear();
				map.put("order_id", order.getUuid());
				memberCellars = mdao.list(map);
			} else {
				this.setOrder(null);
				setMessage("无操作类型!");
			}

			GoodsDAO gdao = new GoodsDAO();
			map.clear();
			map.put("goods_sales", "0");
			this.setGoodss(gdao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_ADD");
		try {
			addOrder(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String add_check() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_ADDCHECK");
		try {
			addOrder(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	private void addOrder(Integer init_status) {
		String order_id = ToolsUtil.getUUIDByDateRandom();
		order.setUuid(order_id);
		order.setOrder_type(0);
		order.setPay_status(0);
		order.setOrder_source(1);
		order.setTotal_price(orderGoods.getTotal_price());
		order.setStatus(init_status);
		order.setAdd_user(ContextHelper.getUserLoginUuid());
		order.setAdd_time(new Date());
		order.setLm_user(ContextHelper.getUserLoginUuid());
		order.setLm_time(new Date());
		dao.add(order);

		addActn(OrderActn.ADD_ORDER, null, order_id);
		log.info("成功添加了订单:" + order_id);

		OrderGoodsDAO odao = new OrderGoodsDAO();
		orderGoods.setOrder_id(order_id);
		odao.add(orderGoods);

		addActn(OrderActn.ADD_ORDERGOODS, null, null);
		log.info("成功添加了订单商品:" + orderGoods.getGoods_id());

		GoodsDAO gdao = new GoodsDAO();
		gdao.saveFrozeStock(orderGoods.getGoods_id());
		log.info("成功冻结了商品库存:" + orderGoods.getGoods_id());
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_MDY");
		try {
			order.setLm_user(ContextHelper.getUserLoginUuid());
			order.setLm_time(new Date());
			dao.save(order);

			addActn(OrderActn.MDY_ORDER, null, null);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 作废订单
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:21:22
	 */
	public String order_check0() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK0");
		try {
			// 得到Order的原始状态
			OrderDAO rdao = new OrderDAO();
			map.put("uuid", order.getUuid());
			Order order = (Order) rdao.list(map).get(0);
			Integer order_status = order.getStatus();

			setOrderStatus(0);

			// 根据订单,删除订单所有的藏酒信息
			MemberCellarDAO mdao = new MemberCellarDAO();
			MemberCellar memberCellar = new MemberCellar();
			memberCellar.setLm_user(ContextHelper.getUserLoginUuid());
			memberCellar.setOrder_id(order.getUuid());
			mdao.deleteByOrder(memberCellar);

			// 订单作废时,将重新计算库存的作废情况
			GoodsDAO gdao = new GoodsDAO();
			gdao.mdyStockByOrderID(order.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 送交审核
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:21:36
	 */
	public String order_check10() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK10");
		try {
			setOrderStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 重新送审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:23:57
	 */
	public String order_check15() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK15");
		try {
			setOrderStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check15 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check15 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:24:05
	 */

	public String order_check19() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK19");
		try {
			setOrderStatus(15);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check19 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check19 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:24:19
	 */
	public String order_check20() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK20");
		try {
			setOrderStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check20 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check20 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 配货完成
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:24:25
	 */
	public String order_check30() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK30");
		try {
			// 需要检查配货数量是否对应
			OrderCellarDAO odao = new OrderCellarDAO();
			int xnum = odao.checkOrderCellarsIsComplete(order.getUuid());
			if (xnum > 0) {
				this.setMessage("配货数量不对应,不能进行完成配货操作!还差[" + xnum + "]坛");
				return SUCCESS;
			} else if (xnum < 0) {
				this.setMessage("订单异常,请记录订单号[" + order.getUuid() + "],马上和系统管理员联系!");
				return SUCCESS;
			}

			setOrderStatus(40);
			// 需要计算库存,返还冻结
			GoodsDAO gdao = new GoodsDAO();
			gdao.mdyStockByOrderID(order.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 重新配货
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:24:45
	 */
	public String order_check39() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK39");
		try {
			setOrderStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check39 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check39 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 交易完成
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-13 下午5:24:45
	 */
	public String order_check41() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHECK41");
		try {
			setOrderStatus(70);

			// 计入会员藏酒
			MemberCellarDAO mdao = new MemberCellarDAO();
			mdao.addByOrderID(order.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check41 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check41 数据更新失败:", e);
		}
		return SUCCESS;
	}

	private void setOrderStatus(Integer status) {
		order.setStatus(status);
		order.setLm_user(ContextHelper.getUserLoginUuid());
		order.setLm_time(new Date());
		dao.saveStatus(order);

		addActn(OrderActn.CHANGE_STATUS, null, status.toString());
	}

	public String order_pay_status() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_CHANGEPAYSTATUS");
		try {
			order.setPay_status(1);
			order.setPay_time(new Date());
			order.setLm_user(ContextHelper.getUserLoginUuid());
			order.setLm_time(new Date());
			dao.savePayStatus(order);

			addActn(OrderActn.CHANGE_PAYSTATUS, null, "1");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_pay 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!order_pay 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDER_DEL");
		try {
			dao.delete(order);
			setMessage("删除成功!ID=" + order.getUuid());

			addActn(OrderActn.DEL_ORDER, null, order.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	private void addActn(String action_type, String original_value, String new_value) {
		OrderActn oa = new OrderActn();
		oa.setOrder_id(order.getUuid());
		oa.setAction_type(action_type);
		oa.setOriginal_value(original_value);
		oa.setNew_value(new_value);
		oa.setNote(op_message);
		oa.setAdd_ip(ContextHelper.getRealIP());
		oa.setAdd_user(ContextHelper.getUserLoginUuid());
		oa.setAdd_time(new Date());
		if (orderGoods != null)
			oa.setGoods_id(orderGoods.getUuid());
		OrderActnDAO oad = new OrderActnDAO();
		oad.add(oa);
	}
}
