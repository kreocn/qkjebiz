package org.iweb.sys.interceptor;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 
 * @author Kreo
 * 
 */
public class EncodeInterceptor extends AbstractInterceptor {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3066990416203931631L;

	@Override
	public String intercept(ActionInvocation inv) throws Exception {
		// TODO Auto-generated method stub
		javax.servlet.http.HttpServletRequest request = ServletActionContext.getRequest();
		javax.servlet.http.HttpServletResponse response = ServletActionContext.getResponse();
		// response.setCharacterEncoding("UTF-8");
		/**
		 * 此方法体对GET 和 POST方法均可
		 */
		// System.out.println("request.getMethod():" + request.getMethod());
		if (request.getMethod().compareToIgnoreCase("post") >= 0) {
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} else {
			// System.out.println("THIS IS GET CODE INTERCEPT!");
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			Iterator iter = request.getParameterMap().values().iterator();
			while (iter.hasNext()) {
				String[] parames = (String[]) iter.next();
				for (int i = 0; i < parames.length; i++)
					parames[i] = new String(parames[i].getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		return inv.invoke();
	}
}
