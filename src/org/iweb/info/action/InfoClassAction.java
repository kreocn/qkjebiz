package org.iweb.info.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.info.dao.InfoClassDAO;
import org.iweb.info.domain.InfoClass;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 此类未使用Struts2校验框架/未使用Struts2自带的POJO 使用了继承validate()方法校验/使用了自己编写的POJO 作为范例
 * 
 * @author Kreo
 * 
 */
public class InfoClassAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6933875222440644692L;
	private static Log log = LogFactory.getLog(InfoClassAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InfoClassDAO dao = new InfoClassDAO();

	private InfoClass iclass;
	private List<InfoClass> iclasses;

	private String message;

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public InfoClass getIclass() {
		return iclass;
	}

	public void setIclass(InfoClass iclass) {
		this.iclass = iclass;
	}

	public List<InfoClass> getIclasses() {
		return iclasses;
	}

	public void setIclasses(List<InfoClass> iclasses) {
		this.iclasses = iclasses;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public void validate() {
		if (iclass == null) {
			setRequest();
		}
	}

	public void validateSave() {
		setRequest();
		if (ToolsUtil.isEmpty(this.getIclass().getUuid())) {
			addFieldError("uuid", "操作异常,参数丢失!");
		}
		if (ToolsUtil.isEmpty(this.getIclass().getTitle())) {
			addFieldError("title", "[类别名称]不能为空!");
		}
	}

	public void validateAdd() {
		setRequest();
		if (ToolsUtil.isEmpty(this.getIclass().getTitle())) {
			addFieldError("title", "[类别名称]不能为空!");
		}
	}

	public String list() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_CLASS_LIST");
		try {
			map.clear();
			this.setIclasses(dao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_CLASS_ADD");
		try {
			iclass.setUuid(ToolsUtil.getUUID());
			iclass.setLm_user(ContextHelper.getUserLoginUuid());
			iclass.setLm_time(new Date());
			dao.add(iclass);
			setMessage("添加成功!");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_CLASS_MDY");
		try {
			iclass.setLm_user(ContextHelper.getUserLoginUuid());
			iclass.setLm_time(new Date());
			dao.save(iclass);
			setMessage("保存成功!ID=" + iclass.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_CLASS_DEL");
		try {
			if (!ToolsUtil.isEmpty(iclass.getUuid())) {
				dao.delete(iclass);
				setMessage("删除成功!ID=" + iclass.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	private void setRequest() {
		this.iclass = new InfoClass();
		ContextHelper.getBeanByRequest(iclass, ContextHelper.getRequest());
	}
}
