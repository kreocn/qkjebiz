package org.iweb.sys;

import java.util.Map;

import org.apache.struts2.dispatcher.Dispatcher;

import com.opensymphony.xwork2.inject.Container;

public class Parameters {
	final public static String Current_Page_Str = "Current_Page";
	final public static String Page_Size_Str = "Page_Size";
	final public static String UserLoginInfo_Session_Str = "userlogininfosessionstr";
	final public static String left_menu_refresh = "jsrefreshpagesss";
	final public static String searchMap_Session_Str = "serachmapsessionstr";
	final public static String MemberLoginInfo_Session_Str = "memberlogininfosessionstr";
	final public static String CKFinder_Session_Str = "CK_U";

	// 0= 1>= 2<= 3> 4<
	final public static Integer SEARCH_EQUAL = 0;
	final public static Integer SEARCH_MORE_EQUAL = 1;
	final public static Integer SEARCH_LESS_EQUAL = 2;
	final public static Integer SEARCH_MORE = 3;
	final public static Integer SEARCH_LESS = 4;

	// news class id
	// 专门为固定的类型(比如藏酒动态)所用
	// 藏酒动态
	final public static String CELLAR_NEWS_CLASSID = "1358235987534001";
	// 藏酒帮助中心
	final public static String CELLAR_HELP_CLASSID = "1358236000445001";

	/**
	 * 得到WEB初始化参数的MAP
	 * 
	 * @return
	 */
	final public static Map<String, String> getConfig() {
		return IWebConfig.getConfigMap();
	}

	/**
	 * 得到WEB目录的绝对路径
	 * 
	 * @return
	 */
	final public static String getAbsolutePath() {
		return getConfig().get("WebAbsolutePath");
	}

	/**
	 * 得到WEB的相当路径
	 * 
	 * @return
	 */
	final public static String getRelativePath() {
		return getConfig().get("WebRelativePath");
	}

	public static String get(String para_name) {
		return getConfig().get(para_name);
	}

	/**
	 * 得到struts.xml/struts2.properties/web.xml中配置的struts2的参数
	 * 
	 * @param para
	 *            参数名
	 * @see 如果只是struts2.properties的参数,可以使用DefaultSettings.get("struts.devMode");来获取
	 * @return
	 */
	public static String getStrutsConfig(String para) {
		Container con = Dispatcher.getInstance().getConfigurationManager().getConfiguration().getContainer();
		String s = con.getInstance(String.class, para);
		return s == null ? "" : s;
	}
}