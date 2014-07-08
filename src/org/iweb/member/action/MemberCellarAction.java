package org.iweb.member.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.MemberStatusFactory;
import org.iweb.sysvip.dao.MemberAddressDAO;
import org.iweb.sysvip.domain.MemberAddress;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.CellarOrderDAO;
import com.qkjsys.ebiz.dao.GoodsDAO;
import com.qkjsys.ebiz.dao.MemberCellarDAO;
import com.qkjsys.ebiz.domain.CellarOrder;
import com.qkjsys.ebiz.domain.Goods;
import com.qkjsys.ebiz.domain.MemberCellar;

public class MemberCellarAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberCellarAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private MemberCellarDAO dao = new MemberCellarDAO();
	private CellarOrderDAO cdao = new CellarOrderDAO();

	private MemberCellar memberCellar;
	private List<MemberCellar> memberCellars;

	private List<Goods> goods;

	private CellarOrder cellarOrder;

	private List<MemberAddress> memberAddresses;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public List<MemberAddress> getMemberAddresses() {
		return memberAddresses;
	}

	public void setMemberAddresses(List<MemberAddress> memberAddresses) {
		this.memberAddresses = memberAddresses;
	}

	public CellarOrder getCellarOrder() {
		return cellarOrder;
	}

	public void setCellarOrder(CellarOrder cellarOrder) {
		this.cellarOrder = cellarOrder;
	}

	public List<Goods> getGoods() {
		return goods;
	}

	public void setGoods(List<Goods> goods) {
		this.goods = goods;
	}

	public MemberCellar getMemberCellar() {
		return memberCellar;
	}

	public void setMemberCellar(MemberCellar memberCellar) {
		this.memberCellar = memberCellar;
	}

	public List<MemberCellar> getMemberCellars() {
		return memberCellars;
	}

	public void setMemberCellars(List<MemberCellar> memberCellars) {
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

	@Override
	public String execute() throws Exception {
		try {
			map.clear();
			if (memberCellar == null)
				memberCellar = new MemberCellar();
			memberCellar.setMember_id(MemberStatusFactory.getLoginMemberID());
			map.putAll(ToolsUtil.getMapByBean(memberCellar));
			map.putAll(MemberStatusFactory.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setMemberCellars(dao.list(map));
			this.setRecCount(dao.getResultCount());

			GoodsDAO gdao = new GoodsDAO();
			map.clear();
			map.put("goods_type", 1);
			this.setGoods(gdao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String viewVideo() throws Exception {
		try {
			if (cellarOrder == null || ToolsUtil.isEmpty(cellarOrder.getUuid()))
				this.setCellarOrder(null);
			else {
				map.clear();
				map.put("uuid", cellarOrder.getUuid());
				this.setCellarOrder((CellarOrder) cdao.list(map).get(0));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!viewVideo 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!viewVideo 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String cellarOrderLoad() throws Exception {
		try {
			if (!(memberCellar == null || memberCellar.getUuid() == null)) {
				this.setMemberCellar((MemberCellar) dao.get(memberCellar.getUuid()));
				MemberAddressDAO mdao = new MemberAddressDAO();
				map.clear();
				map.put("member_id", MemberStatusFactory.getLoginMemberID());
				this.setMemberAddresses(mdao.list(map));

				// 如果cellarOrder不为null,则为查看订单
				if (!(cellarOrder == null || cellarOrder.getUuid() == null)) {
					this.setViewFlag("view");
					map.clear();
					map.put("uuid", cellarOrder.getUuid());
					this.setCellarOrder((CellarOrder) cdao.list(map).get(0));
				}
			} else {
				return INPUT;
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!cellarOrderLoad 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!cellarOrderLoad 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String cellarOrderAdd() throws Exception {
		try {
			String uuid = ToolsUtil.getUUIDByDateRandom();
			cellarOrder.setUuid(uuid);
			cellarOrder.setMember_cellar_id(memberCellar.getUuid());
			cellarOrder.setStatus(10);
			cellarOrder.setOrder_source(0);
			cellarOrder.setAdd_time(new Date());
			cellarOrder.setLm_time(new Date());
			cdao.add(cellarOrder);
			log.info("取酒订单下单成功!" + uuid);
			cdao.outCellarStockByCellarOrderID(uuid);
			log.info("库存调整成功!" + uuid);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
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
	public String cellarOrderDel() throws Exception {
		try {
			cellarOrder.setStatus(0);
			cellarOrder.setLm_time(new Date());
			cdao.mdyCellarOrderStatus(cellarOrder);
			log.info("库存调整成功!" + cellarOrder.getUuid());
			cdao.inCellarStockByCellarOrderID(cellarOrder.getUuid());
			log.info("库存调整成功!" + cellarOrder.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!order_check10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!order_check10 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
