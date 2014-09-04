package org.iweb.common.action;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.CommonDAO;
import org.iweb.sys.mail.SysMail;

import com.opensymphony.xwork2.ActionSupport;

public class TestAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5402660473816753547L;

	private static Log log = LogFactory.getLog(TestAction.class);

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}

	public String tmain() throws Exception {
		return SUCCESS;
	}

	private void sendMails() {
		String sql = "SELECT * FROM h_tmp_email WHERE 1=0";
		CommonDAO c = new CommonDAO();
		List<Map> l = c.commonSelectMapList(sql);
		// SysMail mail = new SysMail();
		for (int i = 0, n = l.size(); i < n; i++) {
			Map tm = l.get(i);
			if (SysMail.sendHtml((String) tm.get("email"), "【通知】 邮件迁移通知", getContent((String) tm.get("uname"), (String) tm.get("epwd")))) System.out.println(tm.get("email")
					+ " 发送成功!");
			// 0--:43:zhoujunyu@51qkj.com:zxcvbnm166:周骏宇:男
			// System.out.println(i + "--:" + tm.get("uuid") + ":" + tm.get("email") + ":" + tm.get("epwd") + ":" + tm.get("uname") + ":" + tm.get("sex"));
			// mail
		}
	}

	private String getContent(String uname, String epwd) {
		StringBuffer sb = new StringBuffer();
		sb.append("Dear ").append(uname).append(":");
		sb.append("<h2>邮件迁移通知</h2>");
		sb.append("<p>邮件系统将于2014年8月15日(本周五)下午17:00准时迁移(迁移大概需要持续2-3小时,中间可能不能正确的使用邮箱),请大家做好相应准备.</p>");
		sb.append("<p>准备工作只有一个,<span style='color: red;'>请大家修改老邮箱(263企业邮)密码</span>,每个人的密码都由系统自动生成</p>");
		sb.append("<p>分配给您的密码为:<span style='color: red;font-size: 26px;'>").append(epwd).append("</span></p>");
		sb.append("<p>这也将是您的新邮箱的初始密码(请妥善保管,免得在邮箱切换后不能正确登录)</p>");
		sb.append("<p>新邮箱登录方式不变,还是 http://mail.51qkj.com ,也可以使用原始地址 http://exmail.qq.com/login</p>");
		sb.append("<p>新邮箱客户端设置方法,请复制链接到浏览器查看 http://service.exmail.qq.com/cgi-bin/help?subtype=1&&id=28&&no=1000564");
		sb.append("<p>PS:修改密码主要是为了同步原有的邮件,如果没必要同步邮件,也就没必要改老邮箱的密码了;</p>");
		sb.append("<p>同理,如果发现自己的邮件已经全部都同步了,那么你就可以修改为自己的密码了</p>");
		return sb.toString();
	}
}
