package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberCapital;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ActivePosmDAO;
import com.qkj.manage.dao.ActiveProductDAO;
import com.qkj.manage.dao.ApplyDAO;
import com.qkj.manage.dao.ApplyPosmDAO;
import com.qkj.manage.dao.ApplyProductDAO;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.IntegralPaymentDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.ActiveMemcost;
import com.qkj.manage.domain.ActivePosm;
import com.qkj.manage.domain.ActiveProduct;
import com.qkj.manage.domain.Apply;
import com.qkj.manage.domain.ApplyPosm;
import com.qkj.manage.domain.ApplyProduct;
import com.qkj.manage.domain.Approve;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.domain.IntegralPay;
import com.qkj.manage.domain.StoresOrder;

public class IntegralPaymentAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(IntegralPaymentAction.class);
	private IntegralPay integralPay;
	private IntegralPaymentDAO dao=new IntegralPaymentDAO();
	private String message;
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberDAO mdao = new MemberDAO();
	private Member member;
	public Member getMember() {
		return member;
	}

	public String getMessage() {
		return message;
	}



	public void setMessage(String message) {
		this.message = message;
	}

	public void setMember(Member member) {
		this.member = member;
	}



	public IntegralPay getIntegralPay() {
		return integralPay;
	}



	public void setIntegralPay(IntegralPay integralPay) {
		this.integralPay = integralPay;
	}



	public String list() throws Exception {
		
		return SUCCESS;
	}
	
	
	
	public String add() throws Exception {
		map.put("uuid", integralPay.getMember_id());
			if(mdao.list(map).size()>0){
		member=(Member)mdao.list(map).get(0);
		if(member!=null){
		if(member.getScore()>=integralPay.getIntegral()){
			dao.add(integralPay);
			MemberCapital mc=new MemberCapital();
			mc.setMember_id(integralPay.getMember_id());
			mc.setScore((int) integralPay.getIntegral());
			MemberCapitalDAO md=new MemberCapitalDAO();
			md.mdyCapital(mc, 4, 1, "消费积分减少,调整编号"+integralPay.getMember_id());
			message="成功";
		}else{
			message="积分不足";
		}
		}else{
			message="请输入正确的用户名称";
		}
		}else{
			message="请输入正确的用户名称";
		}
		return SUCCESS;
	};
}
