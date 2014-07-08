package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.InfoDAO;
import org.iweb.sysvip.domain.Info;

import com.opensymphony.xwork2.ActionSupport;

public class InfoAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(InfoAction.class);
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

	public String loadTips() throws Exception {
		try {
			this.setInfo((Info) dao.get(info.getUuid()));
			// if (!"PRIV".equals(info.getType())) {
			// map.clear();
			// map.put("itype", "REPLY");
			// map.put("reuuid", info.getUuid());
			// this.setInfos(dao.list(map));
			// }
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!loadTips 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!loadTips 读取数据错误:", e);
		}
		return SUCCESS;
	}

	/**
	 * 列出网友交流列表
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-1 下午8:45:48
	 */
	public String listTips() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_INFO_LISTTIPS");
		try {
			if (info == null)
				info = new Info();
			info.setType("TIPS");
			map.clear();
			map.putAll(ToolsUtil.getMapByBean(info));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setInfos(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!listTips 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!listTips 读取数据错误:", e);
		}
		return SUCCESS;
	}

	/**
	 * 网友交流 - 审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-1 下午8:52:50
	 */
	public String TipsPass() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_INFO_TIPSPASS");
		try {
			info.setChecked(2);
			dao.checkInfo(info);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!TipsPass 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!TipsPass 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 网友交流 - 审核不通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-1 下午8:52:50
	 */
	public String TipsFail() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_INFO_TIPSFAIL");
		try {
			info.setChecked(1);
			dao.checkInfo(info);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!TipsFail 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!TipsFail 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String loadMsgs() throws Exception {
		try {
			this.setInfo((Info) dao.get(info.getUuid()));
			if (!"PRIV".equals(info.getType())) {
				map.clear();
				map.put("type", "MSG");
				map.put("itype", "REPLYS");
				map.put("reuuid", info.getUuid());
				this.setInfos(dao.list(map));
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!loadMsgs 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!loadMsgs 读取数据错误:", e);
		}
		return SUCCESS;
	}

	/**
	 * 列出留言列表
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-1 下午8:45:48
	 */
	public String listMsgs() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_INFO_LISTMSGS");
		try {
			if (info == null)
				info = new Info();
			info.setType("MSG");
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
	 * 留言回复
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-2 下午2:16:29
	 */
	public String MsgReply() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_INFO_ADDMSGREPLY");
		try {
			info.setRe_user(ContextHelper.getUserLoginUuid());
			info.setRe_time(new Date());
			dao.reMsg(info);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addMsgReply 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!addMsgReply 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("VIP_SYSVIP_INFO_DEL");
		try {
			dao.delete(info);
			setMessage("删除成功!ID=" + info.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
