/**
 * 
 */
package org.iweb.sysvip;

import java.util.HashMap;
import java.util.Map;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.IWebConfig;
import org.iweb.sys.Parameters;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberLoginInfo;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-4 上午9:56:53
 */
public class MemberStatusFactory {

	public static MemberLoginInfo getMemberLoginInfo() {
		return (MemberLoginInfo) ContextHelper.getRequest().getSession()
				.getAttribute(Parameters.MemberLoginInfo_Session_Str);
	}

	public static Member getLoginMember() {
		Member m = new Member();
		MemberLoginInfo ml = getMemberLoginInfo();
		m.setUuid(ml.getUuid());
		m.setTitle(ml.getTitle());
		m.setMobile(ml.getMobile());
		m.setIs_mobile_check(ml.getIs_mobile_check());
		m.setEmail(ml.getEmail());
		m.setIs_email_check(ml.getIs_email_check());
		m.setMember_name(ml.getMember_name());
		m.setUser_type(ml.getUser_type());
		m.setReg_time(ml.getReg_time());
		m.setReg_type(ml.getReg_type());

		m.setLast_login_time(ml.getLast_login_time());
		m.setDept_code(ml.getDept_code());
		m.setManager(ml.getManager());

		m.setUser_type_name(ml.getUser_type_name());
		m.setDept_name(ml.getDept_name());
		m.setManager_name(ml.getManager_name());
		m.setManager_mobile(ml.getManager_mobile());

		return m;
	}

	public static void resetMemberLoginInfo(Member m) {
		MemberLoginInfo ml = getMemberLoginInfo();
		ml.setEmail(m.getEmail());
		ml.setMember_name(m.getMember_name());
	}

	public static void Logout() {
		ContextHelper.getRequest().getSession().removeAttribute(Parameters.MemberLoginInfo_Session_Str);
		ContextHelper.getRequest().getSession().invalidate();
	}

	public static String getLoginMemberID() {
		if (getLogin())
			return getMemberLoginInfo().getUuid();
		return "";
	}

	public static String getMemberID() {
		if (getLogin())
			return getMemberLoginInfo().getUuid();
		return "";
	}

	/**
	 * 判断登陆状态,true为已登录,false为未登陆
	 * 
	 * @return
	 */
	public static boolean getLogin() {
		return !(getMemberLoginInfo() == null);
	}

	/**
	 * 得到一个分页所需的默认map
	 * 
	 * @return
	 */
	public static Map<String, Object> getDefaultRequestMap4Page() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Parameters.Page_Size_Str, IWebConfig.getConfigMap().get("Member_Page_Size"));
		int Current_Page = 0;
		try {
			Current_Page = Integer.parseInt((String) ContextHelper.getRequest().getParameter("Page"));
		} catch (Exception e) {
			Current_Page = 1;
		}
		if (Current_Page != 0) {
			map.put(Parameters.Current_Page_Str, Current_Page);
		}
		return map;
	}

	public static String getStatus(String name) {
		return name;
	}
}
