package com.qkjsys.ebiz.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.GoodsDAO;
import com.qkjsys.ebiz.dao.OrderActnDAO;
import com.qkjsys.ebiz.dao.OrderCellarDAO;
import com.qkjsys.ebiz.dao.OrderDAO;
import com.qkjsys.ebiz.dao.OrderGoodsDAO;
import com.qkjsys.ebiz.domain.OrderActn;
import com.qkjsys.ebiz.domain.OrderGoods;

public class OrderGoodsAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OrderGoodsAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OrderGoodsDAO dao = new OrderGoodsDAO();

	private OrderGoods orderGoods;
	private List<OrderGoods> orderGoodss;

	private String op_message;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

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

	public List<OrderGoods> getOrderGoodss() {
		return orderGoodss;
	}

	public void setOrderGoodss(List<OrderGoods> orderGoodss) {
		this.orderGoodss = orderGoodss;
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
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERGOODS_LIST");
		try {
			map.clear();
			if (orderGoods != null)
				map.putAll(ToolsUtil.getMapByBean(orderGoods));
			// map.putAll(ContextHelper.getDefaultRequestMap4Page());
			// this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setOrderGoodss(dao.list(map));
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
				this.setOrderGoods(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setOrderGoods(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", orderGoods.getUuid());
				if (null == map.get("uuid"))
					this.setOrderGoods(null);
				else
					this.setOrderGoods((OrderGoods) dao.list(map).get(0));
			} else {
				this.setOrderGoods(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERGOODS_ADD");
		try {
			// orderGoods.setLm_user(ContextHelper.getUserLoginUuid());
			// orderGoods.setLm_time(new Date());
			dao.add(orderGoods);

			OrderDAO odao = new OrderDAO();
			odao.saveTotalPrice(orderGoods.getOrder_id());

			addActn(OrderActn.ADD_ORDERGOODS, null, null);

			GoodsDAO gdao = new GoodsDAO();
			gdao.saveFrozeStock(orderGoods.getGoods_id());
			log.info("成功冻结商品库存:" + orderGoods.getGoods_id());

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERGOODS_MDY");
		try {
			// orderGoods.setLm_user(ContextHelper.getUserLoginUuid());
			// orderGoods.setLm_time(new Date());
			dao.save(orderGoods);

			addActn(OrderActn.MDY_ORDERGOODS, null, orderGoods.getUuid().toString());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERGOODS_DEL");
		try {
			this.setOrderGoods((OrderGoods) dao.get(orderGoods.getUuid()));

			// 删除藏酒
			OrderCellarDAO ocdao = new OrderCellarDAO();
			ocdao.delByOrderGoods(orderGoods.getUuid());
			log.info("成功删除已配藏酒:" + orderGoods.getUuid());

			// 删除商品
			dao.delete(orderGoods);
			log.info("成功删除商品:" + orderGoods.getUuid());

			// 重新计算总价
			OrderDAO odao = new OrderDAO();
			odao.saveTotalPrice(orderGoods.getOrder_id());
			log.info("订单重新计算总价成功:" + orderGoods.getOrder_id());
			// 写入ACTN
			addActn(OrderActn.DEL_ORDERGOODS, null, orderGoods.getUuid().toString());
			log.info("订单动态更新成功:" + orderGoods.getOrder_id());
			setMessage("删除成功!ID=" + orderGoods.getUuid());

			// 解除库存冻结
			GoodsDAO gdao = new GoodsDAO();
			gdao.saveFrozeStock(orderGoods.getGoods_id());
			log.info("成功解除库存冻结goods_id:" + orderGoods.getGoods_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	private void addActn(String action_type, String original_value, String new_value) {
		OrderActn oa = new OrderActn();

		oa.setOrder_id(orderGoods.getOrder_id());
		oa.setGoods_id(orderGoods.getGoods_id());
		oa.setAction_type(action_type);
		oa.setOriginal_value(original_value);
		oa.setNew_value(new_value);
		oa.setNote(op_message);
		oa.setAdd_ip(ContextHelper.getRealIP());
		oa.setAdd_user(ContextHelper.getUserLoginUuid());
		oa.setAdd_time(new Date());

		OrderActnDAO oad = new OrderActnDAO();
		oad.add(oa);
	}
}
