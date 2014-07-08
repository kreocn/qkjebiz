package org.iweb.common.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.iweb.common.dao.AjaxDAO;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.DateUtil;
import org.iweb.sys.Excel;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.UserPrivilege;

import com.opensymphony.xwork2.ActionSupport;

/**
 * Using JsonAjaxAction
 * 
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-16 下午8:37:55
 */
@Deprecated
public class AjaxAction extends ActionSupport {
	private static final long serialVersionUID = 2075319503956837404L;
	private List<Object> list;
	private AjaxDAO dao = new AjaxDAO();

	private String privilege_id;
	private String parameters;
	private String para_condition;
	private Map<String, Object> map = new HashMap<String, Object>();
	private String ajax_result;

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

	public String getAjax_result() {
		return ajax_result;
	}

	public void setAjax_result(String ajax_result) {
		this.ajax_result = ajax_result;
	}

	/**
	 * 
	 * @return
	 */

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma", "no-cache");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		if (!ContextHelper.checkLoginStatus()) {
			setAjax_result("LOGTIMEOUT");
			return SUCCESS;
		}
		if (!ToolsUtil.isEmpty(privilege_id)) {
			// ContextHelper.isPermit(privilege_id);
			if (!ContextHelper.checkPermit(privilege_id)) {
				setAjax_result("NOPERMIT");
				return SUCCESS;
			}

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
			}
			// ############################
			list = dao.list(getAjaxMapID(), map);

			// String work = ServletActionContext.getRequest().getParameter("work");

			if (ToolsUtil.isEmpty(work)) {
				switch (list.size()) {
				case 0:
					setAjax_result("NODATA");
					break;
				case 1:
					setAjax_result(JSONObject.fromObject(list.get(0)).toString());
					// System.out.println(JSONObject.fromObject(list.get(0)).toString());
					break;
				default:
					setAjax_result(JSONArray.fromObject(list).toString());
				}
			} else if ("export_excel".equals(work)) {
				try {
					String file_name = java.net.URLDecoder.decode(request.getParameter("file_name"), "UTF-8");
					String title = java.net.URLDecoder.decode(request.getParameter("title"), "UTF-8");
					String cols_name = java.net.URLDecoder.decode(request.getParameter("cols_name"), "UTF-8");
					String cols_title = java.net.URLDecoder.decode(request.getParameter("cols_title"), "UTF-8");
					// String cols_title =
					// java.net.URLDecoder.decode(request.getParameter("cols_title"), "UTF-8");

					System.out.println("file_name:" + file_name);
					System.out.println("title:" + title);
					System.out.println("cols_name:" + cols_name);
					System.out.println("cols_title:" + cols_title);

					String download_path = Parameters.getRelativePath() + File.separator + "tmp" + File.separator
							+ file_name + ".xls";
					Excel ex = new Excel();
					ex.getExcel(Parameters.getAbsolutePath() + "tmp" + File.separator, file_name + ".xls", title, list,
							cols_name.split(","), cols_title.split(","));

					System.out.println("生成文件:" + download_path);
					// map.clear();
					// map.put("path", download_path);
					// map.put("name", file_name + ".xls");
					map.clear();
					map.put("file_path", download_path);
					map.put("file_name", file_name + ".xls");
					setAjax_result(JSONObject.fromObject(map).toString());
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}
		}
		return SUCCESS;
	}

	public String getAjaxMapID() {
		return (String) ajaxProvolege.get(privilege_id);
	}
}
