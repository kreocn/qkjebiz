package com.qkjsys.ebiz.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.MemberCellarDAO;
import com.qkjsys.ebiz.dao.OrderCellarDAO;
import com.qkjsys.ebiz.domain.MemberCellar4Add;
import com.qkjsys.ebiz.domain.OrderGoods4Add;

public class OrderCellarAddAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OrderCellarAddAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberCellarDAO dao = new MemberCellarDAO();

	private MemberCellar4Add memberCellar;
	private List<MemberCellar4Add> memberCellars;

	private List<OrderGoods4Add> orderGoodss;

	private String goods_add_id;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public String getGoods_add_id() {
		return goods_add_id;
	}

	public void setGoods_add_id(String goods_add_id) {
		this.goods_add_id = goods_add_id;
	}

	public List<OrderGoods4Add> getOrderGoodss() {
		return orderGoodss;
	}

	public void setOrderGoodss(List<OrderGoods4Add> orderGoodss) {
		this.orderGoodss = orderGoodss;
	}

	public MemberCellar4Add getMemberCellar() {
		return memberCellar;
	}

	public void setMemberCellar(MemberCellar4Add memberCellar) {
		this.memberCellar = memberCellar;
	}

	public List<MemberCellar4Add> getMemberCellars() {
		return memberCellars;
	}

	public void setMemberCellars(List<MemberCellar4Add> memberCellars) {
		this.memberCellars = memberCellars;
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

	public String listCellarByOrder() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_LIST");
		try {
			map.clear();
			if (!(memberCellar == null || ToolsUtil.isEmpty(memberCellar.getOrder_id()))) {
				map.putAll(ToolsUtil.getMapByBean(memberCellar));
				this.setMemberCellars(dao.listMemberCellars4Add(map));

				OrderCellarDAO odao = new OrderCellarDAO();
				this.setOrderGoodss(odao.listOrderGoods(memberCellar.getOrder_id()));
			} else {
				this.setMessage("参数不正确!");
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!listCellarByOrder 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!listCellarByOrder 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_ADD");
		try {
			dao.addBatch(memberCellar, goods_add_id);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_ORDERCELLAR_DEL");
		try {
			dao.delete4Add(memberCellar.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 操作失败:", e);
			throw new Exception(this.getClass().getName() + "!del 操作失败:", e);
		}
		return SUCCESS;
	}
}
