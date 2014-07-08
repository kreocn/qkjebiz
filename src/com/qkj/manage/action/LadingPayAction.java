package com.qkj.manage.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberCapital;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.LadingDAO;
import com.qkj.manage.dao.LadingPayDAO;
import com.qkj.manage.domain.Lading;
import com.qkj.manage.domain.LadingPay;

public class LadingPayAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(LadingPayAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private LadingPayDAO dao = new LadingPayDAO();

	private LadingPay ladingPay;
	private List<LadingPay> ladingPays;
	private Member member;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public LadingPay getLadingPay() {
		return ladingPay;
	}

	public void setLadingPay(LadingPay ladingPay) {
		this.ladingPay = ladingPay;
	}

	public List<LadingPay> getLadingPays() {
		return ladingPays;
	}

	public void setLadingPays(List<LadingPay> ladingPays) {
		this.ladingPays = ladingPays;
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
		ContextHelper.isPermit("QKJ_MANAGER_LADINGPAY_LIST");
		try {
			map.clear();
			if (ladingPay == null) {
				ladingPay = new LadingPay();
			}
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "add_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_MANAGER_LADINGPAY_LIST", map, ladingPay, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setLadingPays(dao.list(map));
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
				this.setLadingPay(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				if (!(ladingPay == null || ladingPay.getLading_id() == null)) {

				} else {
					setMessage("参数错误!");
				}
			} else if ("mdy".equals(viewFlag)) {
				if (!(ladingPay == null || ladingPay.getUuid() == null)) {
					this.setLadingPay((LadingPay) dao.get(ladingPay.getUuid()));
				} else {
					this.setLadingPay(null);
				}
			} else {
				this.setLadingPay(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_MANAGER_LADINGPAY_ADD");
		try {
			// qkjmanager_getLadingPaysMoneys
			LadingDAO ldao = new LadingDAO();
			Lading lading = (Lading) ldao.get(ladingPay.getLading_id());
			double moneys = dao.getLadingPaysMoneys(lading.getUuid());
			if (lading.getTotal_price() >= (moneys + ladingPay.getMoney())) {
				ladingPay.setAdd_time(new Date());
				ladingPay.setAdd_user(ContextHelper.getUserLoginUuid());
				dao.add(ladingPay);
			} else {
				this.setMessage("所填到款总额超出提货单总额,添加失败!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_MANAGER_LADINGPAY_MDY");
		try {
			ladingPay.setLm_user(ContextHelper.getUserLoginUuid());
			ladingPay.setLm_time(new Date());
			dao.save(ladingPay);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String fd_check() throws Exception {
		ContextHelper.isPermit("QKJ_MANAGER_LADINGPAY_FDCHECK");
		try {
			boolean checkFlag = true;

			this.setLadingPay((LadingPay) dao.get(ladingPay.getUuid()));
			if (ladingPay.getFd_check() == 0) {
				LadingDAO ldao = new LadingDAO();
				Lading lading = (Lading) ldao.get(ladingPay.getLading_id());

				if (ladingPay.getType() == 4) {// 预付款方式
					// 用户账户中,扣除金钱
					MemberCapitalDAO cdao = new MemberCapitalDAO();
					MemberCapital mc_x = cdao.get(lading.getMember_id());
					if (mc_x.getMoney() < ladingPay.getMoney()) {
						checkFlag = false;
						this.setMessage("预付款不足,不能确认!");
					} else {
						MemberCapital mc = new MemberCapital();
						mc.setMember_id(lading.getMember_id());
						mc.setMoney(ladingPay.getMoney());
						cdao.mdyCapital(mc, 2, 1, "用户在提货单[" + lading.getUuid() + "]中,使用预付款金额:" + ladingPay.getMoney());
					}
				}

				if (checkFlag) {
					ladingPay.setFd_check(1);
					ladingPay.setFd_check_user(ContextHelper.getUserLoginUuid());
					ladingPay.setFd_check_time(new Date());
					ladingPay.setLm_user(ContextHelper.getUserLoginUuid());
					ladingPay.setLm_time(new Date());
					dao.fd_check(ladingPay);
				}

				// 得到现在的到款情况总额
				Double moneys = dao.getLadingPaysMoneys(lading.getUuid());

				// 自动计算是否全部到款,财务自动确认
				if (moneys.equals(lading.getTotal_price())) {
					lading.setFd_check(2);
				} else {
					lading.setFd_check(1);
				}
				System.out.println("比较: moneys=" + moneys + " total_price:" + lading.getTotal_price());
				System.out.println(moneys == lading.getTotal_price());
				System.out.println("得出结论,财务确认结果为:" + lading.getFd_check());

				lading.setFd_check_user(ContextHelper.getUserLoginUuid());
				lading.setLm_user(ContextHelper.getUserLoginUuid());
				ldao.mdyLadingFDCheck(lading);
			} else {
				this.setMessage("已经做过付款确认,不用重复提交.");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!fd_check 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!fd_check 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_MANAGER_LADINGPAY_DEL");
		try {
			this.setLadingPay((LadingPay) dao.get(ladingPay.getUuid()));
			int i = dao.delete(ladingPay);
			if (i == 1)
				setMessage("删除成功!ID=" + ladingPay.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
