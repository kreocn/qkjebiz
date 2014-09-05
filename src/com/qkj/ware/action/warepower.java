package com.qkj.ware.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.domain.UserLoginInfo;

import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class warepower {
	private static Log log = LogFactory.getLog(ContextHelper.class);

	public static javax.servlet.http.HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}
	private static Map<String, Object> map = new HashMap<String, Object>();
	
	private static List<Ware> wares;
	
	
	public List<Ware> getWares() {
		return wares;
	}


	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}

	public static boolean checkPermit(String ware_id, String flag) {
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa");
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		WareDAO wd=new WareDAO();
		Boolean f=false;
		if(flag!=null){
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			if(flag.equals("add")){
				map.put("add", 1);
			}else if(flag.equals("del")){
				map.put("del", 1);
			}else if(flag.equals("edit")){
				map.put("edit", 1);
			}else if(flag.equals("sel")){
				map.put("sel", 1);
			}
			wares=wd.listByPower(map);
		}
		if(ContextHelper.isAdmin()||wares.size()>0){
			f=true;
		}
		return f;
		//return ContextHelper.isAdmin() || (ulf.getStatus() == 1 && ulf.getUser_prvg_map().containsKey(p_id));
	}

	/**
	 * 多权限判断,判断p_id[]是否符合通过标准
	 * 
	 * @param p_id
	 * @param flag
	 *            多权限判断标准 true = && | false == ||
	 * @return
	 */
	public static boolean checkWare(String ware_id, String flag) {
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		WareDAO wd=new WareDAO();
		Boolean f=false;
		if(flag!=null){
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			if(flag.equals("add")){
				map.put("add", 1);
			}else if(flag.equals("del")){
				map.put("del", 1);
			}else if(flag.equals("edit")){
				map.put("edit", 1);
			}else if(flag.equals("sel")){
				map.put("sel", 1);
			}
			wares=wd.listByPower(map);
		}
		if(ContextHelper.isAdmin()||wares.size()>0){
			f=true;
		}
		return f;
	}

}
