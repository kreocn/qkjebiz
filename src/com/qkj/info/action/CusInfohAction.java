package com.qkj.info.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.info.dao.CusInfohDAO;
import com.qkj.info.domain.CusInfoh;

/**
 * 外部网站使用
 * 
 * @author 骏宇
 * 
 */
public class CusInfohAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(CusInfohAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CusInfohDAO dao = new CusInfohDAO();

	private int qkjajax_result;

	private CusInfoh cusInfoh;
	private List<CusInfoh> cusInfohs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public int getQkjajax_result() {
		return qkjajax_result;
	}

	public void setQkjajax_result(int qkjajax_result) {
		this.qkjajax_result = qkjajax_result;
	}

	public CusInfoh getCusInfoh() {
		return cusInfoh;
	}

	public void setCusInfoh(CusInfoh cusInfoh) {
		this.cusInfoh = cusInfoh;
	}

	public List<CusInfoh> getCusInfohs() {
		return cusInfohs;
	}

	public void setCusInfohs(List<CusInfoh> cusInfohs) {
		this.cusInfohs = cusInfohs;
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
			if (cusInfoh != null) map.putAll(ToolsUtil.getMapByBean(cusInfoh));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setCusInfohs(dao.list(map));
			this.setRecCount(dao.getResultCount());
			if (this.getRecCount() > 0) {
				this.setViewFlag("OK");
			} else {
				this.setViewFlag("FAIL");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String postSearch() throws Exception {
		try {
			map.clear();
			if (cusInfoh != null) map.putAll(ToolsUtil.getMapByBean(cusInfoh));
			else cusInfoh = new CusInfoh();
			if (ToolsUtil.isEmpty(cusInfoh.getSecurity())) {
				this.setViewFlag("FAIL_NULL");
			} else {
				// map.put("express_status", 1);
				this.setCusInfohs(dao.list(map));
				this.setRecCount(dao.getResultCount());
				if (this.getRecCount() > 0) {
					this.setViewFlag("OK");
					for (CusInfoh cih : this.getCusInfohs()) {
						this.setCusInfoh(cih);
						if (!ToolsUtil.isEmpty(cih.getExpress_no())) {
							break;
						}
					}
				} else {
					this.setViewFlag("FAIL");
				}
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String loadNull() throws Exception {
		// System.out.println(dao.checkSecNO("v02", "CCC"));
		return SUCCESS;
	}

	public String checkSec() throws Exception {
		this.setQkjajax_result(dao.checkSecNO(cusInfoh.getLinkid(), cusInfoh.getSecurity()));
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setCusInfoh(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setCusInfoh(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", cusInfoh.getUuid());
				if (null == map.get("uuid")) this.setCusInfoh(null);
				else this.setCusInfoh((CusInfoh) dao.list(map).get(0));
			} else {
				this.setCusInfoh(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String loaduMdy() throws Exception {
		try {
			map.clear();
			if (cusInfoh != null) {
				map.put("mobile", cusInfoh.getMobile());
				map.put("security", cusInfoh.getSecurity());
			}
			if (!(ToolsUtil.isEmpty(map.get("mobile")) || ToolsUtil.isEmpty(map.get("security")))) {
				this.setCusInfohs(dao.list(map));
				// this.setCusInfoh((CusInfoh) dao.list(map).get(0));
				if (this.getCusInfohs().size() == 0) {
					this.setViewFlag("NULL");
				} else {
					this.setCusInfoh(this.getCusInfohs().get(0));
					if (cusInfoh.getExpress_status() == 1) {
						this.setViewFlag("EXPRESSED");
					}
				}
			} else {
				this.setViewFlag("NOPARA");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!loaduMdy 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!loaduMdy 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String usave() throws Exception {
		try {
			dao.userMdy(cusInfoh);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!usave 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!usave 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		try {
			int i = dao.checkSecNO(cusInfoh.getLinkid(), cusInfoh.getSecurity());
			if (i == 0) {
				cusInfoh.setAdd_time(new Date());
				cusInfoh.setAdd_ip(ContextHelper.getRealIP());
				cusInfoh.setUuid(dao.add(cusInfoh));
			} else {
				if (i == 1) this.setMessage("您已经成功提交了数据,请不要重复提交,我们将尽快把酒送到您的手上,谢谢您的关注!");
				if (i == 2) this.setMessage("您不是此次活动的预定人群,请阅读活动公告,十分感谢您关注我们的产品!");
				return INPUT;
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
}
