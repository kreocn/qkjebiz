package org.iweb.sys.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.PositionDAO;
import org.iweb.sys.domain.Position;

import com.opensymphony.xwork2.ActionSupport;

public class PositionAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(PositionAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private PositionDAO dao = new PositionDAO();

	private Position position;
	private List<Position> positions;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;职务管理列表";
	
	public String getPath() {
		return path;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public List<Position> getPositions() {
		return positions;
	}

	public void setPositions(List<Position> positions) {
		this.positions = positions;
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

	public void validate() {
	}

	public String list() throws Exception {
		ContextHelper.isPermit("SYS_CONFIG_POSITION_LIST");
		try {
			map.clear();
			if (position != null)
				map.putAll(ToolsUtil.getMapByBean(position));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setPositions(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;职务管理列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setPosition(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setPosition(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sys/position_list?viewFlag=relist'>职务管理列表</a>&nbsp;&gt;&nbsp;添加职务";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", position.getUuid());
				if (null == map.get("uuid"))
					this.setPosition(null);
				else
					this.setPosition((Position) dao.list(map).get(0));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sys/position_list?viewFlag=relist'>职务管理列表</a>&nbsp;&gt;&nbsp;修改职务";
			} else {
				this.setPosition(null);
				setMessage("无操作类型!");
			}

			this.setPositions(dao.list(null));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("SYS_CONFIG_POSITION_ADD");
		try {
			position.setUuid(ToolsUtil.getUUID());
			position.setLm_user(ContextHelper.getUserLoginTitle());
			position.setLm_time(new Date());
			dao.add(position);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_CONFIG_POSITION_MDY");
		try {
			position.setLm_user(ContextHelper.getUserLoginTitle());
			position.setLm_time(new Date());
			dao.save(position);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("SYS_CONFIG_POSITION_DEL");
		try {
			dao.delete(position);
			setMessage("删除成功!ID=" + position.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
