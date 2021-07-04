package org.iweb.sys;

import java.util.HashMap;
import java.util.Map;

public class SendMessage {
	public  static String cid1="Nz0VtYF775iY";//积分变动
	  public  static String cid2="oInnn04SKId0";//新增会员

	  private static String  cid0; 
	  private static Map<String, Object> map = new HashMap<String, Object>();

	  
	  // 短信接口一，自写短信内容。该接口提交的短信均由人工审核，下发后请联系在线客服。适合：节假日祝福、会员营销群发等。
	  public static void sms_api1(String mobl,String p1,String p2,String cid) {
	    Map<String, String> para = new HashMap<String, String>();
	    //目标手机号码，多个以“,”分隔，一次性调用最多100个号码，示例：139********,138********
	    
	    para.put("mob", mobl);//会员电话
	    //微米账号的接口CID
	    switch(cid)
	    {  
	    case "1":
	      cid0=cid1;  //积分变动
	      break; 
	    case "2":
	      cid0=cid2;  //新增会员
	      break; 
	    }
	    para.put("cid", cid0);
	    //微米账号的接口UID
	    para.put("uid", "SUw48FZQYLzm");
	    // 微米账号的接口密码
	    para.put("pas", "n4fv356x");
	    //接口返回类型：json、xml、txt。默认值为txt
	    para.put("type", "json");
	    /**
	     * 短信内容。必须设置好短信签名，签名规范： 
	     * 1、短信内容一定要带签名，签名放在短信内容的最前面；
	     * 2、签名格式：【***】，签名内容为三个汉字以上（包括三个）；
	     * 3、短信内容不允许双签名，即短信内容里只有一个“【】”
	     */
	    //para.put("con", "【微米】您的验证码是：610912，3分钟内有效。如非您本人操作，可忽略本消息。");
	    para.put("p1",p1);
	    para.put("p2",p2);
	    // 特别注意：参数传递时去除“<>”符号！
	    try {
	      System.out.println(HttpClientHelper.convertStreamToString(HttpClientHelper.get("http://api.weimi.cc/2/sms/send.html",para), "UTF-8"));
	      //System.out.println(HttpClientHelper.convertStreamToString(HttpClientHelper.post("http://api.weimi.cc/2/sms/send.html", para),"UTF-8"));
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	  }
	  /**
	   * 短信接口二，触发类模板短信接口，可以设置动态参数变量。适合：验证码、订单短信等。
	   */
	  public static void sms_api2() {
	    Map<String, String> para = new HashMap<String, String>();
	    /**
	     * 目标手机号码，多个以“,”分隔，一次性调用最多100个号码，示例：139********,138********
	     */
	    para.put("mob", "");
	    /**
	     * 微米账号的接口UID
	     */

	    para.put("uid", "SUw48FZQYLzm");
	    /**
	     * 微米账号的接口密码
	     */
	    para.put("pas", "n4fv356x");
	    /**
	     * 接口返回类型：json、xml、txt。默认值为txt
	     */
	    para.put("type", "json");
	    /**
	     * 短信模板cid，通过微米后台创建，由在线客服审核。必须设置好短信签名，签名规范： 
	     * 1、模板内容一定要带签名，签名放在模板内容的最前面；
	     * 2、签名格式：【***】，签名内容为三个汉字以上（包括三个）；
	     * 3、短信内容不允许双签名，即短信内容里只有一个“【】”
	     */
	    para.put("cid", "<enter your cid>");
	    /**
	     * 传入模板参数。
	     * 
	     * 短信模板示例：
	     * 【微米】您的验证码是：%P%，%P%分钟内有效。如非您本人操作，可忽略本消息。
	     * 
	     * 传入两个参数：
	     * p1：610912
	     * p2：3
	     * 最终发送内容：
	     * 【微米】您的验证码是：610912，3分钟内有效。如非您本人操作，可忽略本消息。
	     */
	    para.put("p1", "610912");
	    para.put("p2", "3");

	    try {
	      System.out.println(HttpClientHelper.convertStreamToString(HttpClientHelper.get("http://api.weimi.cc/2/sms/send.html",para), "UTF-8"));
	      //System.out.println(HttpClientHelper.convertStreamToString(HttpClientHelper.post("http://api.weimi.cc/2/sms/send.html", para),"UTF-8"));
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	  }
	  /*public static void main(String mobl,String p1,String p2,String cid) {
	    // 测试短信接口一 参数  电话号码、内容1、内容2、类别（1：短信模板1   ，  2：短信模板2）
	    sms_api1(mobl,p1,p2,cid);
	    // 测试短信接口二
	    //sms_api2();
	    // 注意：以上参数传入时不包括“<>”符号
	  }*/
	  public static void main(String[] args) {
		SendMessage sm = new SendMessage();
	    sm.sms_api1("15726631303","","","1");

	  }
}
