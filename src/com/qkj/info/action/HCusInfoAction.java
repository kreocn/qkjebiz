package com.qkj.info.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.info.dao.CusInfohDAO;
import com.qkj.info.domain.CusInfoh;

public class HCusInfoAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(HCusInfoAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private CusInfohDAO dao = new CusInfohDAO();

	private CusInfoh hcusInfo;
	private List<CusInfoh> hcusInfos;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;

	public CusInfoh getHcusInfo() {
		return hcusInfo;
	}

	public void setHcusInfo(CusInfoh hcusInfo) {
		this.hcusInfo = hcusInfo;
	}

	public List<CusInfoh> getHcusInfos() {
		return hcusInfos;
	}

	public void setHcusInfos(List<CusInfoh> hcusInfos) {
		this.hcusInfos = hcusInfos;
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

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("WEB_MANAGER_HCUSINFO_LIST");
		try {
			map.clear();
			if (hcusInfo == null) {
				hcusInfo = new CusInfoh();
			}
			ContextHelper.SimpleSearchMap4Page("WEB_QKJWEB_HCUSINFO_LIST", map, hcusInfo, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setHcusInfos(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setHcusInfo(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setHcusInfo(null);
			} else if ("mdy".equals(viewFlag)) {
				if (!(hcusInfo == null || hcusInfo.getUuid() == null)) {
					this.setHcusInfo((CusInfoh) dao.get(hcusInfo.getUuid()));
				} else {
					this.setHcusInfo(null);
				}
			} else {
				this.setHcusInfo(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("WEB_MANAGER_HCUSINFO_MDY");
		try {
			hcusInfo.setLm_user(ContextHelper.getUserLoginUuid());
			hcusInfo.setLm_time(new Date());
			dao.save(hcusInfo);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String express() throws Exception {
		ContextHelper.isPermit("WEB_QKJWEB_HCUSINFO_EXPRESS");
		try {
			// http://q.sto.cn/track.aspx?wen=868078517238
			hcusInfo.setExpress_type("申通快递");
			hcusInfo.setExpress_date(new Date());
			hcusInfo.setExpress_status(1);
			hcusInfo.setLm_user(ContextHelper.getUserLoginUuid());
			hcusInfo.setLm_time(new Date());
			dao.express(hcusInfo);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!express 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!express 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("WEB_MANAGER_HCUSINFO_DEL");
		try {
			dao.del(hcusInfo);
			setMessage("删除成功!ID=" + hcusInfo.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public String loadOne() throws Exception {
		try {
			if (!(hcusInfo == null || hcusInfo.getUuid() == null)) {
				if ("next".equals(viewFlag)) {
					hcusInfo.setUuid(hcusInfo.getUuid() + 1);
				}
				this.setHcusInfo((CusInfoh) dao.get(hcusInfo.getUuid()));
			} else {
				this.setHcusInfo(null);
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!loadOne 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!loadOne 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
