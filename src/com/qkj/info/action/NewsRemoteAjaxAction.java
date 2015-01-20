package com.qkj.info.action;

import java.lang.annotation.Annotation;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.DateUtil;
import org.iweb.sys.Parameters;
import org.iweb.sys.HtmlUtils;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.info.dao.NewsRemoteAjaxDAO;

/**
 * 外部新闻调用专用AJAX Action
 * 
 */
public class NewsRemoteAjaxAction extends ActionSupport {

	private static final long serialVersionUID = 2075319503956837404L;
	private static Log log = LogFactory.getLog(NewsRemoteAjaxAction.class);
	private List<Object> list;
	private String parameters;
	private String para_condition;
	private Map<String, Object> map = new HashMap<String, Object>();
	private String callback;
	private Object ajax_result;

	/**
	 * 请求类型: <br />
	 * news:列出信息 <br />
	 * class:列出类别 <br />
	 * rhtml:抓取网页内容
	 */
	private String work;

	public String getWork() {
		return work;
	}

	public void setWork(String work) {
		this.work = work;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
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

		if (map.containsKey("pageSize") && !ToolsUtil.isEmpty(map.get("pageSize"))) {
			map.put(Parameters.Page_Size_Str, map.get("pageSize"));
			map.remove("pageSize");
		}

		if (map.containsKey("pageNum") && !ToolsUtil.isEmpty(map.get("pageNum"))) {
			map.put(Parameters.Current_Page_Str, map.get("pageNum"));
			map.remove("pageNum");
		}

		NewsRemoteAjaxDAO dao = new NewsRemoteAjaxDAO();

		if ("news".equals(work)) {
			list = dao.listNews(map);
			HashMap<String, Object> pmap = new HashMap<>();
			pmap.putAll(map);
			pmap.put("total_counts", dao.getResultCount());
			// 最后会加上所有的参数和返回的数据,一起送到客户端,作为查询条件和结果
			list.add(pmap);
		} else if ("class".equals(work)) {
			list = dao.listClasss(map);
		} else if ("rhtml".equals(work)) {
			HtmlUtils th = new HtmlUtils();
			this.setAjax_result(th.getOneHtml((String) map.get("openurl")));
			return SUCCESS;
		}
		if (list != null) {
			switch (list.size()) {
			case 0:
				setAjax_result(Object2JSON(new ArrayList<Object>()));
				break;
			default:
				setAjax_result(Object2JSON(list));
			}
		} else {
			setAjax_result("NODATA");
		}

		return SUCCESS;
	}

	private Object Object2JSON(Object obj) {
		if ((obj instanceof Annotation) || obj != null && obj.getClass().isAnnotation()) {
			return JSONObject.fromObject("NODATA");
		} else if (obj instanceof Enum || JSONUtils.isArray(obj)) {
			return JSONArray.fromObject(obj);
		} else {
			return JSONObject.fromObject(obj);
		}
	}
}
