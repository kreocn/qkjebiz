package com.qkj.manage.dao;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.action.UserAction;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.dao.UserDAO;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.User;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;

import com.qkj.manage.action.SalPromotAction;
import com.qkj.manage.domain.SalPromot;
public class SalPromotPower{
	private static Log log = LogFactory.getLog(UserAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberDAO mdao = new MemberDAO();
	private SalPromotDAO salp=new SalPromotDAO();
	private Member member;
	private List<Member> members;
	private SalPromot salPro;
	private List<SalPromot> salpros;
	
	

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}

	public SalPromot getSalPro() {
		return salPro;
	}

	public void setSalPro(SalPromot salPro) {
		this.salPro = salPro;
	}

	public List<SalPromot> getSalpros() {
		return salpros;
	}

	public void setSalpros(List<SalPromot> salpros) {
		this.salpros = salpros;
	}

	/**
	 * 查询是否有权限选择促销活动
	 */
	public List<SalPromot> salProPower(String userId){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		map.clear();
		map.put("uuid", userId);
		this.setMembers(mdao.list(map));
		if(members.size()>0){
			this.setMember(members.get(0));
			map.clear();
			map.put("sal_scopDept", member.getDept_code());
			map.put("add_user_dept", ContextHelper.getUserLoginUuid());
			map.put("status", 2);
			map.put("proendtime", sdf.format(new Date()));
			this.setSalpros(salp.listPower(map));
		}
		return salpros;
	}
	
}
