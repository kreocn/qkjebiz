package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.MemberHandoverDAO;
import org.iweb.sysvip.domain.MemberHandover;

import com.opensymphony.xwork2.ActionSupport;

public class MemberHandoverAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberHandoverAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberHandoverDAO dao = new MemberHandoverDAO();

	private MemberHandover memberHandover;
	private List<MemberHandover> memberHandovers;
	private List<MemberHandover> memberHandoverIns;
	private List<MemberHandover> memberHandoverOuts;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public MemberHandover getMemberHandover() {
		return memberHandover;
	}

	public void setMemberHandover(MemberHandover memberHandover) {
		this.memberHandover = memberHandover;
	}

	public List<MemberHandover> getMemberHandovers() {
		return memberHandovers;
	}

	public void setMemberHandovers(List<MemberHandover> memberHandovers) {
		this.memberHandovers = memberHandovers;
	}

	public List<MemberHandover> getMemberHandoverIns() {
		return memberHandoverIns;
	}

	public void setMemberHandoverIns(List<MemberHandover> memberHandoverIns) {
		this.memberHandoverIns = memberHandoverIns;
	}

	public List<MemberHandover> getMemberHandoverOuts() {
		return memberHandoverOuts;
	}

	public void setMemberHandoverOuts(List<MemberHandover> memberHandoverOuts) {
		this.memberHandoverOuts = memberHandoverOuts;
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
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERHANDOVER_LIST");
		try {
			if (memberHandover == null) {
				memberHandover = new MemberHandover();
			}
			if (memberHandover.getStatus() == null) {
				memberHandover.setStatus(0);
			}

			map.clear();
			map.putAll(ToolsUtil.getMapByBean(memberHandover));
			ContextHelper.setSearchDeptPermit4Search(map, "target_depts", "target_manager");
			this.setMemberHandoverIns(dao.list(map));

			map.clear();
			map.putAll(ToolsUtil.getMapByBean(memberHandover));
			ContextHelper.setSearchDeptPermit4Search(map, "m_dept_codes", "m_manager");
			this.setMemberHandoverOuts(dao.list(map));

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setMemberHandover(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setMemberHandover(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", memberHandover.getUuid());
				if (null == map.get("uuid"))
					this.setMemberHandover(null);
				else
					this.setMemberHandover((MemberHandover) dao.list(map).get(0));
			} else {
				this.setMemberHandover(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERHANDOVER_ADD");
		try {
			memberHandover.setApplicant(ContextHelper.getUserLoginUuid());
			memberHandover.setApplicant_time(new Date());
			memberHandover.setStatus(0);
			memberHandover.setLm_user(ContextHelper.getUserLoginUuid());
			dao.add(memberHandover);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save1() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERHANDOVER_SAVE1");
		try {
			if (memberHandover != null && memberHandover.getUuids() != null && memberHandover.getUuids().length > 0) {
				memberHandover.setStatus(1);
				memberHandover.setLm_user(ContextHelper.getUserLoginUuid());
				dao.save(memberHandover);
				this.setMessage("拒绝接收操作成功!");
			} else {
				this.setMessage("参数错误,操作失败!");
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String save2() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERHANDOVER_SAVE2");
		try {
			if (memberHandover != null && memberHandover.getUuids() != null && memberHandover.getUuids().length > 0) {
				// 接收之后,需要改变实际的会员部门和客户经理(由于更改之后状态会改变,所以需要把改变放在前面)
				map.clear();
				map.put("uuids", memberHandover.getUuids());
				dao.MemberHandoverByHandoverIDs(map);

				memberHandover.setStatus(2);
				memberHandover.setLm_user(ContextHelper.getUserLoginUuid());
				dao.save(memberHandover);

				this.setMessage("拒绝接收操作成功!");
			} else {
				this.setMessage("参数错误,操作失败!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save2 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save2 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJCJ_SYSVIP_MEMBERHANDOVER_DEL");
		try {
			memberHandover.setLm_user(ContextHelper.getUserLoginUuid());
			dao.delete(memberHandover);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
