package org.iweb.common.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.ajax.data.Ajax;
import org.iweb.common.dao.AjaxDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.DateUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.UserPrivilege;

import com.opensymphony.xwork2.ActionSupport;

public class JsonAjaxAction extends ActionSupport {
	private static final long serialVersionUID = 2075319503956837404L;
	private static Log log = LogFactory.getLog(JsonAjaxAction.class);
	private List<Object> list;
	private AjaxDAO dao = new AjaxDAO();

	private String privilege_id;
	private String parameters;
	private String para_condition;
	private Map<String, Object> map = new HashMap<String, Object>();
	private Object ajax_result;

	private String work;

	public String getPrivilege_id() {
		return privilege_id;
	}

	public void setPrivilege_id(String privilege_id) {
		this.privilege_id = privilege_id;
	}

	public String getWork() {
		return work;
	}

	public void setWork(String work) {
		this.work = work;
	}

	private static Map<String, Object> ajaxProvolege = new HashMap<String, Object>();
	static {
		ajaxProvolege.put("is_ajax", 1);
		List<UserPrivilege> list = new AjaxDAO().list("sys_getPrivileges", ajaxProvolege);
		ajaxProvolege.clear();
		for (int i = 0, length = list.size(); i < length; i++) {
			UserPrivilege u = list.get(i);
			ajaxProvolege.put(u.getPrivilege_id(), u.getAjax_map_id());
		}
	}

	/**
	 * @param parameters
	 * <br>
	 *            format like:id=1&msg=this is the msg&tim=this is the tim
	 */
	public void setParameters(String parameters) {
		this.parameters = parameters;
	}

	public void setPara_condition(String para_condition) {
		this.para_condition = para_condition;
	}

	public Object getAjax_result() {
		return ajax_result;
	}

	public void setAjax_result(Object ajax_result) {
		this.ajax_result = ajax_result;
	}

	/**
	 * 
	 * @return
	 */

	@Override
	public String execute() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma", "no-cache");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		// 设置参数
		if (!ToolsUtil.isEmpty(parameters)) {
			parameters = java.net.URLDecoder.decode(parameters, "UTF-8");
			HashMap<String, String> t_map = new HashMap<String, String>();
			if (!ToolsUtil.isEmpty(para_condition)) {
				para_condition = java.net.URLDecoder.decode(para_condition, "UTF-8");
				for (String p_c : para_condition.split(",")) {
					String[] t_p_c = p_c.split(":");
					if (t_p_c.length == 2) {
						t_map.put(t_p_c[0], t_p_c[1]);
					}
				}
			}

			for (String p_1 : parameters.split("\\&")) {
				String[] p_2 = p_1.split("=");
				if (p_2.length == 2) {
					if (t_map.containsKey(p_2[0])) {
						if ("date".equals(t_map.get(p_2[0]))) {
							map.put(p_2[0], DateUtil.getDate(p_2[1], "yyyy-MM-dd"));
						} else if ("datetime".equals(t_map.get(p_2[0]))) {
							map.put(p_2[0], DateUtil.getDate(p_2[1], "yyyy-MM-dd HH:mm:ss"));
						} else if ("integer".equals(t_map.get(p_2[0]))) {
							map.put(p_2[0], Integer.parseInt(p_2[1]));
						} else if ("double".equals(t_map.get(p_2[0]))) {
							map.put(p_2[0], Double.parseDouble(p_2[1]));
						} else {
							map.put(p_2[0], p_2[1]);
						}
					} else {
						map.put(p_2[0], p_2[1]);
					}
				}
			}
			log.info("初始化参数成功:" + parameters);
		}

		if (ToolsUtil.isEmpty(privilege_id)) {
			// 如果没有privilege_id,则从Ajax中取出Content进行操作
			// work参数存储初始化ajax的类名
			if (ToolsUtil.isEmpty(work)) {
				setAjax_result(ToolsUtil.Object2JSON("ERROR:work参数错误!"));
				return SUCCESS;
			} else {
				// 规定ajax_data的数据都放在org.iweb.ajax.data包下,可以直接指定类名,系统会自动添加
				try {
					if (!getWork().startsWith("org.iweb.ajax.data.")) {
						setWork("org.iweb.ajax.data." + getWork() + "Ajax");
					}
					log.info("开始指向AjaxWork类:" + this.getWork());
					Ajax ajax = (Ajax) Class.forName(getWork()).newInstance();
					ajax.setParameter(map);
					setAjax_result(ToolsUtil.Object2JSON(ajax.getResult()));
				} catch (Exception e) {
					log.error("work参数错误!", e);
					e.printStackTrace();
					setAjax_result(ToolsUtil.Object2JSON("ERROR:work参数错误!"));
					return SUCCESS;
				}
			}
		} else {
			// 如果有privilege_id,则从privilege_id中读出map_id来查询数据库
			log.info("获取privilege_id成功:" + privilege_id);

			// 有权限ID,就必定要登录LOGTIMEOUT NOPERMIT NODATA
			if (!ContextHelper.checkLoginStatus()) {
				setAjax_result(ToolsUtil.Object2JSON("ERROR:登录超时,请重新登录!"));
				return SUCCESS;
			}

			if (!ContextHelper.checkPermit(privilege_id)) {
				setAjax_result(ToolsUtil.Object2JSON("ERROR:权限不足!"));
				return SUCCESS;
			}
			String map_id = getAjaxMapID();
			if (ToolsUtil.isEmpty(map_id)) {
				setAjax_result(ToolsUtil.Object2JSON("ERROR:work参数错误!"));
				return SUCCESS;
			}
			log.info("权限审核通过,获得MapID:" + map_id);

			if ("update".equals(this.getWork())) {
				setAjax_result(dao.update(map_id, map));
			} else {
				list = dao.list(map_id, map);
				switch (list.size()) {
				case 0:
					setAjax_result(ToolsUtil.Object2JSON(new ArrayList<Object>()));
					break;
				default:
					setAjax_result(ToolsUtil.Object2JSON(list));
				}
			}
		}
		return SUCCESS;
	}

	public String getAjaxMapID() {
		return (String) ajaxProvolege.get(privilege_id);
	}
}
