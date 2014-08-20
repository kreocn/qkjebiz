package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sysvip.dao.DepositDAO;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Deposit;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberCapital;

import com.opensymphony.xwork2.ActionSupport;

public class DepositAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(DepositAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private DepositDAO dao = new DepositDAO();
	private MemberDAO mdao = new MemberDAO();

	private Deposit deposit;
	private List<Deposit> deposits;
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

	public Deposit getDeposit() {
		return deposit;
	}

	public void setDeposit(Deposit deposit) {
		this.deposit = deposit;
	}

	public List<Deposit> getDeposits() {
		return deposits;
	}

	public void setDeposits(List<Deposit> deposits) {
		this.deposits = deposits;
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
		ContextHelper.isPermit("VIP_SYSVIP_DEPOSIT_LIST");
		try {
			map.clear();
			if (deposit == null) {
				deposit = new Deposit();
			}
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "add_user");
			ContextHelper.SimpleSearchMap4Page("VIP_SYSVIP_DEPOSIT_LIST", map, deposit, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setDeposits(dao.list(map));
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
				this.setDeposit(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				if (!(deposit == null || deposit.getMember_id() == null)) {
					this.setMember(mdao.get(deposit.getMember_id()));
					deposit.setMember_name(member.getMember_name());
				} else {
					setMessage("参数错误!");
				}
			} else if ("mdy".equals(viewFlag)) {
				if (!(deposit == null || deposit.getUuid() == null)) {
					this.setDeposit((Deposit) dao.get(deposit.getUuid()));
				} else {
					this.setDeposit(null);
				}
			} else {
				this.setDeposit(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_DEPOSIT_ADD");
		try {
			deposit.setAdd_time(new Date());
			deposit.setAdd_user(ContextHelper.getUserLoginUuid());
			dao.add(deposit);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_DEPOSIT_MDY");
		try {
			deposit.setLm_user(ContextHelper.getUserLoginUuid());
			deposit.setLm_time(new Date());
			dao.save(deposit);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String fd_check() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_DEPOSIT_FDCHECK");
		try {
			this.setDeposit((Deposit) dao.get(deposit.getUuid()));
			if (deposit.getFd_check() == 0) {
				deposit.setFd_check(1);
				deposit.setFd_check_user(ContextHelper.getUserLoginUuid());
				deposit.setFd_check_time(new Date());
				deposit.setLm_user(ContextHelper.getUserLoginUuid());
				deposit.setLm_time(new Date());
				dao.fd_check(deposit);

				// 用户账户中,增加金钱
				MemberCapitalDAO cdao = new MemberCapitalDAO();
				MemberCapital memberCapital = new MemberCapital();
				memberCapital.setMember_id(deposit.getMember_id());
				memberCapital.setMoney(deposit.getAmount());
				cdao.mdyCapital(memberCapital, 1, 1, "用户以预付款形式增加余额:" + deposit.getAmount());
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!fd_check 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!fd_check 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_DEPOSIT_DEL");
		try {
			dao.delete(deposit);
			setMessage("删除成功!ID=" + deposit.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
