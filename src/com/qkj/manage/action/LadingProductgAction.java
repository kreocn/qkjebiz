package com.qkj.manage.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.LadingDAO;
import com.qkj.manage.dao.LadingProductgDAO;
import com.qkj.manage.domain.LadingProductg;

public class LadingProductgAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(LadingProductgAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private LadingProductgDAO dao = new LadingProductgDAO();

	private LadingProductg ladingProductg;
	private List<LadingProductg> ladingProductgs;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public LadingProductg getLadingProductg() {
		return ladingProductg;
	}

	public void setLadingProductg(LadingProductg ladingProductg) {
		this.ladingProductg = ladingProductg;
	}

	public List<LadingProductg> getLadingProductgs() {
		return ladingProductgs;
	}

	public void setLadingProductgs(List<LadingProductg> ladingProductgs) {
		this.ladingProductgs = ladingProductgs;
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
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADINGPRODUCTG_LIST");
		try {
			map.clear();
			if (ladingProductg != null) map.putAll(ToolsUtil.getMapByBean(ladingProductg));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setLadingProductgs(dao.list(map));
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
				this.setLadingProductg(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setLadingProductg(null);
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", ladingProductg.getUuid());
				if (null == map.get("uuid")) this.setLadingProductg(null);
				else this.setLadingProductg((LadingProductg) dao.list(map).get(0));
			} else {
				this.setLadingProductg(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADINGPRODUCTG_ADD");
		try {
			dao.add(ladingProductg);

			LadingDAO ldao = new LadingDAO();
			ldao.mdyLadingTotalPriceg(ladingProductg.getLading_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADINGPRODUCTG_MDY");
		try {
			dao.save(ladingProductg);

			LadingDAO ldao = new LadingDAO();
			ldao.mdyLadingTotalPriceg(ladingProductg.getLading_id());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADINGPRODUCTG_DEL");
		try {
			Integer lading_id = ladingProductg.getLading_id();
			dao.delete(ladingProductg);

			LadingDAO ldao = new LadingDAO();
			ldao.mdyLadingTotalPriceg(lading_id);
			setMessage("删除成功!ID=" + ladingProductg.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
