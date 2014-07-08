package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sysvip.dao.MemberCapitalRescoreDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberCapitalRescore;

import com.opensymphony.xwork2.ActionSupport;

public class MemberCapitalRescoreAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberCapitalRescoreAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberCapitalRescoreDAO dao = new MemberCapitalRescoreDAO();

	private MemberCapitalRescore memberCapitalRescore;
	private List<MemberCapitalRescore> memberCapitalRescores;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public MemberCapitalRescore getMemberCapitalRescore() {
		return memberCapitalRescore;
	}

	public void setMemberCapitalRescore(MemberCapitalRescore memberCapitalRescore) {
		this.memberCapitalRescore = memberCapitalRescore;
	}

	public List<MemberCapitalRescore> getMemberCapitalRescores() {
		return memberCapitalRescores;
	}

	public void setMemberCapitalRescores(List<MemberCapitalRescore> memberCapitalRescores) {
		this.memberCapitalRescores = memberCapitalRescores;
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
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_LIST");
		try {
			map.clear();
			if (memberCapitalRescore == null)
				memberCapitalRescore = new MemberCapitalRescore();
			ContextHelper.setSearchDeptPermit4Search(map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("QKJ_SYSVIP_MEMBERCAPITALRESCORE_LIST", map, memberCapitalRescore,
					viewFlag);

			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setMemberCapitalRescores(dao.list(map));
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
				this.setMemberCapitalRescore(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				if (memberCapitalRescore.getMember_id() != null) {
					MemberDAO mdao = new MemberDAO();
					map.clear();
					map.put("uuid", memberCapitalRescore.getMember_id());
					Member m = mdao.get(map);
					memberCapitalRescore.setMember_name(m.getMember_name());
					memberCapitalRescore.setMscore(m.getRe_score());
				} else {
					setMessage("操作异常!");
				}
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", memberCapitalRescore.getUuid());
				if (null == map.get("uuid"))
					this.setMemberCapitalRescore(null);
				else
					this.setMemberCapitalRescore((MemberCapitalRescore) dao.list(map).get(0));
			} else {
				this.setMemberCapitalRescore(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_ADD");
		try {
			memberCapitalRescore.setAdd_user(ContextHelper.getUserLoginUuid());
			memberCapitalRescore.setAdd_time(new Date());
			memberCapitalRescore.setLm_user(ContextHelper.getUserLoginUuid());
			dao.add(memberCapitalRescore);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDY");
		try {
			memberCapitalRescore.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(memberCapitalRescore);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报批
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-21 下午5:25:46
	 */
	public String mdyStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDYSTATUS0");
		try {
			memberCapitalRescore.setStatus(1);
			memberCapitalRescore.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(memberCapitalRescore);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 主管审核
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-21 下午5:25:46
	 */
	public String mdyStatus1() throws Exception {
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDYSTATUS1");
		try {
			memberCapitalRescore.setStatus(2);
			memberCapitalRescore.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(memberCapitalRescore);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 经理审核
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-21 下午5:25:46
	 */
	public String mdyStatus2() throws Exception {
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDYSTATUS2");
		try {
			memberCapitalRescore.setStatus(3);
			memberCapitalRescore.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyStatus(memberCapitalRescore);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus2 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus2 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_SYSVIP_MEMBERCAPITALRESCORE_DEL");
		try {
			dao.delete(memberCapitalRescore);
			setMessage("删除成功!ID=" + memberCapitalRescore.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
