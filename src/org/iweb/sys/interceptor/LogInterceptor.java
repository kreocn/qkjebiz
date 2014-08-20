package org.iweb.sys.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 专门写LOG的拦截器
 * 
 * @author Kreo
 */
public class LogInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = -5450967612788685778L;
	private static Log log = LogFactory.getLog(LogInterceptor.class);

	@Override
	public String intercept(ActionInvocation inv) throws Exception {
		ActionProxy ap = inv.getProxy();
		if (ap != null) {
			String result = null;
			String actionClass = ap.getAction().getClass().getName();
			String method = ap.getMethod();
			String namespace = ap.getNamespace();
			String actionName = ap.getActionName();
			String UUID = ToolsUtil.getUUIDByTimeMillis();
			log.info("业务逻辑处理开始:" + UUID);
			log.info("ActionMethod(" + UUID + "):" + actionClass + "!" + method);
			log.info("Action(" + UUID + "):(" + namespace + ")" + actionName);
			result = inv.invoke();
			log.info("处理结果(" + UUID + "):" + inv.getResultCode());
			log.info("业务逻辑处理结束:" + UUID);
			return result;
		} else {
			return inv.invoke();
		}
	}
}
