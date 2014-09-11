package org.iweb.sys;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.login.LoginException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.domain.UserLoginInfo;
import org.iweb.sys.exception.PermitException;

/**
 * HttpServlet相关的工具类
 * 
 * @author Kreo
 * 
 */
public class ContextHelper {

	private static Log log = LogFactory.getLog(ContextHelper.class);

	public static javax.servlet.http.HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * 得到一个分页所需的默认map
	 * 
	 * @return
	 */
	public static Map<String, Object> getDefaultRequestMap4Page() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Parameters.Page_Size_Str, IWebConfig.getConfigMap().get("Default_Page_Size"));
		int Current_Page = 0;
		try {
			Current_Page = Integer.parseInt((String) getRequest().getParameter("Page"));
		} catch (Exception e) {
			Current_Page = 1;
		}
		if (Current_Page != 0) {
			map.put(Parameters.Current_Page_Str, Current_Page);
		}
		return map;
	}

	/**
	 * 专门为限制部门人员查询而做的工具函数,可以把部门和人员查询的限制条件加入map中
	 * 
	 * @param m
	 *            待添加map
	 * @param dept_column
	 *            添加限制的dept元素名称
	 * @param user_column
	 *            添加闲置的user元素名称
	 * @date 2014-2-1 下午7:54:01
	 */
	public static void setSearchDeptPermit4Search(Map<String, Object> m, String dept_column, String user_column) {
		if (ContextHelper.getUserLoginInfo().getPermit_depts() == null) {
			m.put(user_column, ContextHelper.getUserLoginUuid());
			m.put(dept_column, Arrays.asList(new String[] { ContextHelper.getUserLoginInfo().getDept_code() }));
		} else m.put(dept_column, ContextHelper.getUserLoginPermitDepts());
	}

	/**
	 * 把http request里传入的参数直接赋给一个JavaBean的实例,request和JavaBean里的参数名大小写不区分
	 * ,只能识别和写入String,Double,Integer(包括true=1 false=0的判断),Date(yyyy-MM-dd
	 * HH:mm:ss或者yyyy-MM-dd)类型的参数
	 * 
	 * @param bean
	 * @param request
	 * @return
	 */
	public static Object getBeanByRequest(Object bean, javax.servlet.http.HttpServletRequest request) {
		try {
			Map map = request.getParameterMap();
			java.beans.BeanInfo info = java.beans.Introspector.getBeanInfo(bean.getClass());
			if (info != null) {
				java.beans.PropertyDescriptor pds[] = info.getPropertyDescriptors();
				for (java.beans.PropertyDescriptor pd : pds) {
					String fieldName = pd.getName();
					if (fieldName != null && !fieldName.equals("class")) {
						try {
							for (Map.Entry m : (java.util.Set<Map.Entry>) map.entrySet()) {
								if ((fieldName.toUpperCase()).equals(m.getKey().toString().toUpperCase())) {
									String value = ((String[]) m.getValue())[0];
									String argType = pd.getPropertyType().getName();
									java.lang.reflect.Method method = pd.getWriteMethod();
									Object[] args = new Object[1];
									if ("java.lang.String".equals(argType)) {
										args[0] = value;
									} else if ("java.lang.Integer".equals(argType)) {
										if (null == value || "".equals(value)) {
											args[0] = null;
										} else if ("false".equals(value)) {
											args[0] = 0;
										} else if ("true".equals(value)) {
											args[0] = 1;
										} else {
											args[0] = Integer.parseInt(value);
										}
									} else if ("java.lang.Double".equals(argType)) {
										args[0] = Double.parseDouble(value);
									} else if ("java.util.Date".equals(argType)) {
										if (null == value || "".equals(value)) {
											// args[0] = null;
										} else if (value.length() >= 8 && value.length() <= 10) {
											args[0] = (new SimpleDateFormat("yyyy-MM-dd")).parse(value);
										} else if (value.length() >= 17 && value.length() <= 19) {
											args[0] = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse(value);
										}
									}
									method.invoke(bean, args);
									// System.out.println("写入属性:" + pd.getName()
									// + "=" +
									// value);
								}
							}
						} catch (Exception e) {
							System.out.println("写入[" + pd.getName() + "]参数值异常!");
							e.printStackTrace();
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	/**
	 * 
	 * @param request
	 *            从request中得到用户登陆的信息
	 * @return
	 */
	public static UserLoginInfo getUserLoginInfo() {
		return (UserLoginInfo) getRequest().getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
	}

	/**
	 * 为方便的得到用户所拥有的权限列表而写的方法
	 */
	public static HashMap<String, Integer> getUserLoginPermits() {
		try {
			if (ContextHelper.getUserLoginInfo().getUser_prvg_map() != null) return (HashMap<String, Integer>) (ContextHelper.getUserLoginInfo().getUser_prvg_map());
			else return new HashMap<String, Integer>();
		} catch (Exception e) {
			return new HashMap<String, Integer>();
		}
	}

	/**
	 * 
	 * @param request
	 *            从request中得到用户登陆的信息
	 * @return
	 */
	public static List<String> getUserLoginPermitDepts() {
		try {
			return ContextHelper.getUserLoginInfo().getPermit_depts();
		} catch (Exception e) {
			return new ArrayList<String>();
		}
	}

	/**
	 * 为方便得到LM_USER而专门写的方法
	 * 
	 * @return
	 */
	public static String getUserLoginTitle() {
		try {
			return ContextHelper.getUserLoginInfo().getTitle();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 为方便得到LM_USER而专门写的方法
	 * 
	 * @return
	 */
	public static String getUserLoginUuid() {
		try {
			return ContextHelper.getUserLoginInfo().getUuid();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 为方便得到USER_NAME而专门写的方法
	 * 
	 * @return
	 */
	public static String getUserLoginName() {
		try {
			return ContextHelper.getUserLoginInfo().getUser_name();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 为方便得到Dept_code而专门写的方法
	 * 
	 * @return
	 */
	public static String getUserLoginDept() {
		try {
			return ContextHelper.getUserLoginInfo().getDept_code();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 为方便得到Dept_name而专门写的方法
	 * 
	 * @return
	 */
	public static String getUserLoginDeptName() {
		try {
			return ContextHelper.getUserLoginInfo().getDept_cname();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 判断登陆状态,true为已登录,false为未登陆
	 * 
	 * @return
	 */
	public static boolean checkLoginStatus() {
		return (!ToolsUtil.isEmpty(ContextHelper.getUserLoginInfo()));
	}

	/**
	 * 封装判断函数,如没有登录,则抛出名为"登陆超时"的LoginException异常(此异常会使页面定位到user_login的action)
	 */
	@Deprecated
	public static void isLogin() throws LoginException {
		if (!checkLoginStatus()) { throw new LoginException("登陆超时"); }
	}

	/**
	 * 判断当前人员是否是默认的系统超级管理员
	 */
	public static boolean isAdmin() {
		try {
			return IWebConfig.getConfigMap().get("defaultAdministrator").equals(ContextHelper.getUserLoginInfo().getTitle());
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 权限判断,判断p_id是否在UserLoginInfo.user_prov_set中
	 * 
	 * @param p_id
	 * @return
	 */
	public static boolean checkPermit(String p_id) {
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		return isAdmin() || (ulf.getStatus() == 1 && ulf.getUser_prvg_map().containsKey(p_id));
	}

	/**
	 * 封装权限判断,如果无此权限,则抛出名为"无此操作权限"的PermitException异常(此异常会跳出"无此操作权限"的提示,并后退)
	 * 
	 * @param p_id
	 * @return
	 */
	public static void isPermit(String p_id) {
		try {
			if (!checkPermit(p_id)) {
				log.error("无操作权限:" + p_id);
				throw new PermitException("无此操作权限");
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw new PermitException("检查权限异常,请重新登录", e);
		}
	}

	/**
	 * 多权限判断,判断p_id[]是否符合通过标准
	 * 
	 * @param p_id
	 * @param flag
	 *            多权限判断标准 true = && | false == ||
	 * @return
	 */
	public static boolean checkPermits(String[] p_id, boolean flag) {
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		boolean _p = flag ? true : false;
		for (int i = 0; i < p_id.length; i++) {
			_p = flag ? _p && checkPermit(p_id[i]) : _p || checkPermit(p_id[i]);
		}
		return isAdmin() || (ulf.getStatus() == 1 && _p);
	}

	/**
	 * 多权限判断封装
	 * 
	 * @param p_id
	 * @param flag
	 *            多权限判断标准 true = && | false == ||
	 */
	public static void isPermits(String[] p_ids, boolean flag) {
		if (!checkPermits(p_ids, flag)) {
			log.error("无操作权限.");
			throw new PermitException("无此操作权限");
		}
	}

	/**
	 * 得到权限类型,0代表个人,1代表部门,2代表全局
	 * 
	 * @param p_id
	 * @return
	 */
	public static Integer getPermitType(String p_id) {
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		return isAdmin() ? 2 : ulf.getUser_prvg_map().get(p_id);
	}

	/**
	 * 得到权限功能
	 * 
	 * @param p_id
	 * @return
	 */
	public static String getPermitFunction(String p_id) {
		String function = "";
		try {
			UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
			if (!(ulf.getUser_function_map() == null || ToolsUtil.isEmpty(ulf.getUser_function_map().get(p_id)))) {
				function = ulf.getUser_function_map().get(p_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return isAdmin() ? "admin" : function;
	}

	public static void Logout() {
		getRequest().getSession().invalidate();
	}

	public static String getRealIP() {
		javax.servlet.http.HttpServletRequest request = getRequest();
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 快捷方法,得到request的参数值
	 * 
	 * @param name
	 * @return
	 */
	public static Object getParameter(String name) {
		return getRequest().getParameter(name);
	}

	/**
	 * 判断是否是从左侧导航菜单进入
	 * 
	 * @return
	 */
	public static boolean isFromLeftMenu() {
		return null != getParameter(Parameters.left_menu_refresh);
	}

	/**
	 * 记忆查询,把原来的查询条件写入Session,下次自动设定条件,亦可作为导出的条件依据
	 * 
	 * @param s
	 *            查询标识名,一般为权限名
	 * @param m
	 *            条件MAP
	 */
	public static void addSerachMap(String s, Map<String, Object> m) {
		if (m != null) {
			System.out.println("开始查询记录..");
			HashMap<String, Map<String, Object>> searchMap = getSerachSession();
			Map<String, Object> x_m = new HashMap<String, Object>();
			x_m.putAll(m);
			searchMap.put(s, x_m);
			getRequest().getSession().setAttribute(Parameters.searchMap_Session_Str, searchMap);
			System.out.println("查询记录完成:" + s + "#" + x_m);
		}
	}

	public static HashMap<String, Map<String, Object>> getSerachSession() {
		Object obj = getRequest().getSession().getAttribute(Parameters.searchMap_Session_Str);
		HashMap<String, Map<String, Object>> searchMap;
		if (ToolsUtil.isEmpty(obj) || !(obj instanceof HashMap)) {
			searchMap = new HashMap<String, Map<String, Object>>();
		} else {
			searchMap = (HashMap<String, Map<String, Object>>) obj;
		}
		return searchMap;
	}

	public static Map<String, Object> getSearchMap(String s) {
		return getSerachSession().get(s);
	}

	public static void SimpleSearchMap(String s, Map<String, Object> smap, Object bean, String viewFlag) {
		Map<String, Object> sessionMap = ContextHelper.getSearchMap(s);
		if ("relist".equals(viewFlag) && sessionMap != null && sessionMap.size() > 0) {
			smap.putAll(sessionMap);
			ToolsUtil.getBeanByMap(bean, smap);
		} else {
			smap.putAll(ToolsUtil.getMapByBean(bean));
		}
		ContextHelper.addSerachMap(s, smap);
	}

	public static void SimpleSearchMap4Page(String s, Map<String, Object> smap, Object bean, String viewFlag) {
		Map<String, Object> sessionMap = ContextHelper.getSearchMap(s);
		if ("relist".equals(viewFlag) && sessionMap != null && sessionMap.size() > 0) {
			smap.putAll(sessionMap);
			String page = getRequest().getParameter("Page");
			if (ToolsUtil.isEmpty(page) || "0".equals(page)) {
				if (smap.containsKey(Parameters.Current_Page_Str)) {
					getRequest().setAttribute("Page", smap.get(Parameters.Current_Page_Str));
				}
			} else {
				try {
					smap.put(Parameters.Current_Page_Str, Integer.parseInt(page));
				} catch (Exception e) {
					log.warn("Page 参数不正确,可能不能正常显示!");
				}
			}
			ToolsUtil.getBeanByMap(bean, smap);
		} else {
			smap.putAll(ToolsUtil.getMapByBean(bean));
			smap.putAll(ContextHelper.getDefaultRequestMap4Page());
		}
		ContextHelper.addSerachMap(s, smap);
	}

	public static Integer getPageSize(Map<String, Object> p_map) {
		if (p_map.containsKey(Parameters.Page_Size_Str) && p_map.get(Parameters.Page_Size_Str) != null) return Integer.parseInt(p_map.get(Parameters.Page_Size_Str).toString());
		return Integer.parseInt(IWebConfig.getConfigMap().get("Default_Page_Size"));
	}

	public static Integer getCurrPage(Map<String, Object> p_map) {
		if (p_map.containsKey(Parameters.Current_Page_Str) && p_map.get(Parameters.Current_Page_Str) != null) return Integer.parseInt(p_map.get(Parameters.Current_Page_Str)
				.toString());
		return 1;
	}
}
