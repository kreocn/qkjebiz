package com.qkjsys.ebiz.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.OrderCellarDAO;
import com.qkjsys.ebiz.dao.OrderDAO;
import com.qkjsys.ebiz.domain.Order;
import com.qkjsys.ebiz.domain.OrderCellar;

public class OrderCellarAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OrderCellarAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private Map<String, Object> mmap = new HashMap<String, Object>();
	private OrderCellarDAO dao = new OrderCellarDAO();

	private Order order;
	private Member member;

	// 特殊列表,这个orderGoodses区别于一般的 OrderGoods
	private List<OrderCellar> orderGoodses;
	private OrderCellar orderCellar;
	private List<OrderCellar> orderCellars;
	private String message;
	private String errorMessage;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public List<OrderCellar> getOrderGoodses() {
		return orderGoodses;
	}

	public void setOrderGoodses(List<OrderCellar> orderGoodses) {
		this.orderGoodses = orderGoodses;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public OrderCellar getOrderCellar() {
		return orderCellar;
	}

	public void setOrderCellar(OrderCellar orderCellar) {
		this.orderCellar = orderCellar;
	}

	public List<OrderCellar> getOrderCellars() {
		return orderCellars;
	}

	public void setOrderCellars(List<OrderCellar> orderCellars) {
		this.orderCellars = orderCellars;
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
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_LIST");
		try {
			if (orderCellar == null) {
				this.setMessage("你没有选择任何订单!");
				return INPUT;
			} else {
				map.clear();
				map.put("uuid", orderCellar.getOrder_id());
				OrderDAO odao = new OrderDAO();
				this.setOrder((Order) odao.get(map));

				map.clear();
				map.put("order_id", orderCellar.getOrder_id());
				this.setOrderGoodses(dao.listOrderGoods(map));

				map.clear();
				map.putAll(ToolsUtil.getMapByBean(orderCellar));
			}
			this.setOrderCellars(dao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String listMemberCellar() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_MEMBERCELLAR_LIST");
		try {
			if (orderCellar == null) {
				orderCellar = new OrderCellar();
			}
			if (member == null) {
				member = new Member();
			}
			orderCellar.setOrder_status(70); // 只有交易成功后的订单才能分配
			orderCellar.setStatus_search_type(Parameters.SEARCH_MORE_EQUAL);
			map.clear();
			mmap.clear();

			if (!ToolsUtil.isEmpty(member.getUuid())) {
				orderCellar.setUser_id(member.getUuid());
			}

			ContextHelper.SimpleSearchMap("QKJCJ_SYSEBIZ_MEMBERCELLAR_LIST", map, orderCellar, viewFlag);
			ContextHelper.SimpleSearchMap("QKJCJ_SYSEBIZ_MEMBERCELLAR_LIST_MEMBER", mmap, member, viewFlag);

			if (mmap.containsKey("uuid")) {
				MemberDAO mdao = new MemberDAO();
				this.setMember(mdao.get(mmap));
				this.setOrderCellars(dao.list(map));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!listMemberCellar 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!listMemberCellar 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setOrderCellar(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setOrderCellar(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", orderCellar.getUuid());
				if (null == map.get("uuid"))
					this.setOrderCellar(null);
				else
					this.setOrderCellar((OrderCellar) dao.list(map).get(0));
			} else {
				this.setOrderCellar(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_ADD");
		try {
			// orderCellar.setLm_user(ContextHelper.getUserLoginUuid());
			// orderCellar.setLm_time(new Date());
			// dao.add(orderCellar);
			this.setErrorMessage(dao.addBatch(orderCellars));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_MDY");
		try {
			// orderCellar.setLm_user(ContextHelper.getUserLoginUuid());
			// orderCellar.setLm_time(new Date());
			dao.save(orderCellar);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_DEL");
		try {
			dao.delete(orderCellar);
			setMessage("删除成功!ID=" + orderCellar.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
