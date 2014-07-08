package org.iweb.sys.mail;

public class Mail {
	private static MailSenderInfo mail_sys;
	static {
		mail_sys = new MailSenderInfo();
		mail_sys.setMailServerHost("smtp.51qkj.com");
		mail_sys.setMailServerPort("25");
		mail_sys.setValidate(true);
		mail_sys.setUserName("system@51qkj.com");
		mail_sys.setPassword("z1x2c3v4b5n6m7");// 您的邮箱密码
		mail_sys.setFromAddress("system@51qkj.com");
	}

	private static boolean Send_SYS() {
		return false;
	}

	public static void main(String[] args) {
		// 这个类主要是设置邮件
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost("smtp.51qkj.com");
		mailInfo.setMailServerPort("25");
		mailInfo.setValidate(true);
		mailInfo.setUserName("kreo@51qkj.com");
		mailInfo.setPassword("Jy02223856");// 您的邮箱密码
		mailInfo.setFromAddress("kreo@51qkj.com");
		mailInfo.setToAddress("kreo@qq.com");
		mailInfo.setSubject("测试文本邮件");

		String c = "您有一个活动申请需要审核,活动申请号:S121212121212<br />";
		c += "申请部门:XXXXX   申请人:XXXX<br />";
		c += "主題:为了世界的和平<br />";
		c += "我方总共费用合计:20000 客户总共费用合计:40000";

		mailInfo.setContent(c);
		// 这个类主要来发送邮件
		// SimpleMailSender sms = new SimpleMailSender();
		// 发送文体格式
		// SimpleMailSender.sendTextMail(mailInfo);
		// 发送html格式
		SimpleMailSender.sendHtmlMail(mailInfo);
	}
}
