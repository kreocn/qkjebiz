package org.iweb.member.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.MemberStatusFactory;
import org.iweb.sysvip.dao.InfoDAO;
import org.iweb.sysvip.domain.Info;

import com.opensymphony.xwork2.ActionSupport;

public class MemberMsgAction extends ActionSupport {
	private static final long serialVersionUID = -7132670103218298675L;
	private static Log log = LogFactory.getLog(MemberMsgAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InfoDAO dao = new InfoDAO();

	private Info info;
	private List<Info> infos;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public Info getInfo() {
		return info;
	}

	public void setInfo(Info info) {
		this.info = info;
	}

	public List<Info> getInfos() {
		return infos;
	}

	public void setInfos(List<Info> infos) {
		this.infos = infos;
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

	/**
	 * 列出留言
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-3 下午2:30:01
	 */
	public String listMsg() throws Exception {
		try {
			if (info == null)
				info = new Info();
			info.setType("MSG");
			info.setAdd_member(MemberStatusFactory.getMemberID());
			map.clear();
			map.putAll(ToolsUtil.getMapByBean(info));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setInfos(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!listMsgs 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!listMsgs 读取数据错误:", e);
		}
		return SUCCESS;
	}

	/**
	 * 添加留言
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-2 下午2:16:29
	 */
	public String addMsg() throws Exception {
		try {
			info.setType("MSG");
			info.setItype("NORMAL");
			// 留言没有主题,只有内容
			info.setTitle("MSG");
			info.setChecked(0);
			info.setAdd_member(MemberStatusFactory.getMemberID());
			info.setAdd_ip(ContextHelper.getRealIP());
			info.setAdd_time(new Date());
			dao.add(info);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addMsgReply 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!addMsgReply 数据添加失败:", e);
		}
		return SUCCESS;
	}
}
