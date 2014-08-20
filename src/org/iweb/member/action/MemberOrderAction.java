package org.iweb.member.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.member.dao.MemberCenterDAO;
import org.iweb.member.domain.MemberOrderGoods;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.MemberStatusFactory;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.domain.Order;
import com.qkjsys.ebiz.domain.OrderGoods;

public class MemberOrderAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberOrderAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberCenterDAO dao = new MemberCenterDAO();

	private Order order;
	private List<Order> orders;

	private MemberOrderGoods memberOrderGoods;
	private List<MemberOrderGoods> memberOrderGoodss;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public MemberOrderGoods getMemberOrderGoods() {
		return memberOrderGoods;
	}

	public void setMemberOrderGoods(MemberOrderGoods memberOrderGoods) {
		this.memberOrderGoods = memberOrderGoods;
	}

	public List<MemberOrderGoods> getMemberOrderGoodss() {
		return memberOrderGoodss;
	}

	public void setMemberOrderGoodss(List<MemberOrderGoods> memberOrderGoodss) {
		this.memberOrderGoodss = memberOrderGoodss;
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

	public String list() throws Exception {
		try {
			map.clear();
			if (memberOrderGoods == null)
				memberOrderGoods = new MemberOrderGoods();
			memberOrderGoods.setMember_id(MemberStatusFactory.getLoginMemberID());
			map.putAll(ToolsUtil.getMapByBean(memberOrderGoods));
			map.putAll(MemberStatusFactory.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setMemberOrderGoodss(dao.listMemberOrderGoods(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

}
