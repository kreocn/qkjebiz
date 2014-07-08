package org.iweb.sys.interceptor;

import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.UserLoginInfo;
import org.iweb.sysvip.MemberStatusFactory;
import org.iweb.sysvip.domain.MemberLoginInfo;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * Validate User is Login
 * 
 * @author Kreo
 * 
 */
public class MemberInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = 4543992825774912293L;

	@Override
	public String intercept(ActionInvocation inv) throws Exception {
		// TODO Auto-generated method stub
		String result = null;
		MemberLoginInfo info = (MemberLoginInfo) inv.getInvocationContext().getSession()
				.get(Parameters.MemberLoginInfo_Session_Str);
		if (ToolsUtil.isEmpty(info)) {
			result = "membertimeout";
		} else {
			result = inv.invoke();
		}
		return result;
	}

}
