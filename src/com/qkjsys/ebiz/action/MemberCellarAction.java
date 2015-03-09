package com.qkjsys.ebiz.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sysvip.domain.Member;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.GoodsDAO;
import com.qkjsys.ebiz.dao.MemberCellarDAO;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Goods;
import com.qkjsys.ebiz.domain.MemberCellar;
import com.qkjsys.ebiz.domain.Ware;

public class MemberCellarAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberCellarAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private Map<String, Object> map2 = new HashMap<String, Object>();
	private MemberCellarDAO dao = new MemberCellarDAO();

	private MemberCellar memberCellar;
	private Member member;
	private List<MemberCellar> memberCellars;
	private List<Ware> wares;
	private List<Goods> goodss;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;订单列表";

	private String sflag;

	public String getSflag() {
		return sflag;
	}

	public void setSflag(String sflag) {
		this.sflag = sflag;
	}

	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}

	public List<Goods> getGoodss() {
		return goodss;
	}

	public void setGoodss(List<Goods> goodss) {
		this.goodss = goodss;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
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

	public String list() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_MEMBERCELLAR_LIST");
		try {
			if (memberCellar == null)
				memberCellar = new MemberCellar();
			if (member == null) {
				member = new Member();
			}

			map.clear();
			map2.clear();
			memberCellar.setMember_id(member.getUuid());
			ContextHelper.SimpleSearchMap("QKJCJ_SYSEBIZ_MEMBERCELLAR_LIST_X", map, memberCellar, viewFlag);
			ContextHelper.SimpleSearchMap("QKJCJ_SYSEBIZ_MEMBERCELLAR_LIST_MEMBER_X", map2, member, viewFlag);

			if (map2.containsKey("uuid")) {
				this.setMemberCellars(dao.list(map));
			}

			WareDAO wdao = new WareDAO();
			this.setWares(wdao.list(null));

			GoodsDAO gdao = new GoodsDAO();
			this.setGoodss(gdao.list(null));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setMemberCellar(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setMemberCellar(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", memberCellar.getUuid());
				if (null == map.get("uuid"))
					this.setMemberCellar(null);
				else
					this.setMemberCellar((MemberCellar) dao.list(map).get(0));
			} else {
				this.setMemberCellar(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_MEMBERCELLAR_ADD");
		try {
			// memberCellar.setLm_user(ContextHelper.getUserLoginUuid());
			// memberCellar.setLm_time(new Date());
			dao.add(memberCellar);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_MEMBERCELLAR_MDY");
		try {
			boolean upflag = false;
			if ("change".equals(sflag)) {
				int count = dao
						.checkMemberCellarsPosition(memberCellar.getWare_id(), memberCellar.getCellar_position());
				if (count == 0) {
					upflag = true;
				}
			} else if ("unchange".equals(sflag)) {
				upflag = true;
			}

			if (upflag) {
				memberCellar.setLm_user(ContextHelper.getUserLoginUuid());
				dao.save(memberCellar);
			} else {
				this.setMessage("更新没有成功,请检查是否有重复位置号!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 移除(不是删除,只是清除藏酒的所有权信息,包括所属人,所属订单/细项,保管时间)
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-9 上午12:22:31
	 */
	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSEBIZ_MEMBERCELLAR_DEL");
		try {
			memberCellar.setLm_user(ContextHelper.getUserLoginUuid());
			int i = dao.delete(memberCellar);
			if (i == 1)
				setMessage("删除成功!ID=" + memberCellar.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

}
