package com.qkj.ware.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.domain.UserLoginInfo;

import com.qkj.sche.dao.ScheduleDAO;
import com.qkj.sche.domain.Schedule;
import com.qkj.ware.domain.Warepowers;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class warepower {
	private static Log log = LogFactory.getLog(ContextHelper.class);

	public static javax.servlet.http.HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}
	private static Map<String, Object> map = new HashMap<String, Object>();
	
	private static List<Ware> wares;
	private static List<Schedule> sches;
	private static List<Schedule> schen;
	private static Schedule schenn;
	private static Schedule sche;
//	
	
	
	public List<Schedule> getSches() {
		return sches;
	}


	public static Schedule getSchenn() {
		return schenn;
	}


	public static void setSchenn(Schedule schenn) {
		warepower.schenn = schenn;
	}


	public static List<Schedule> getSchen() {
		return schen;
	}


	public static void setSchen(List<Schedule> schen) {
		warepower.schen = schen;
	}


	public static Map<String, Object> getMap() {
		return map;
	}


	public static void setMap(Map<String, Object> map) {
		warepower.map = map;
	}


	public static Schedule getSche() {
		return sche;
	}


	public static void setSche(Schedule sche) {
		warepower.sche = sche;
	}


	public void setSches(List<Schedule> sches) {
		this.sches = sches;
	}


	public List<Ware> getWares() {
		return wares;
	}


	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}

	public static boolean checkPermit(int ware_id, String flag) {
		System.out.println("查询仓库权限开始");
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		WareDAO wd=new WareDAO();
		Boolean f=false;
		if(flag!=null){
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			map.put("ware_id", ware_id);
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
	//判断公告修改权限
	public static boolean checkSche(String schuuid) {
		System.out.println("查询公告修改权限开始");
		UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
		String u = ContextHelper.getUserLoginUuid();
		Boolean f=false;
		map.clear();
		map.put("p_uuid", u);
		map.put("uuid", schuuid);
		ScheduleDAO sd=new ScheduleDAO();
		sches=sd.list(map);
		if(ContextHelper.isAdmin()||sches.size()>0){
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
	public static boolean checkWare(int ware_id, String flag) {
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		WareDAO wd=new WareDAO();
		Boolean f=false;
		if(flag!=null){
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			map.put("ware_id", ware_id);
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
	
	public static int read(int uuid){
		String u = ContextHelper.getUserLoginUuid();
		ScheduleDAO dao = new ScheduleDAO();
		map.clear();
		map.put("uuid", uuid);
		sche=((Schedule) dao.list(map).get(0)); 
		int scuuid=sche.getUuid();
		//修改为已读
		if(sche.getFlag()!=null&&!sche.getFlag().equals("")){//查询已阅人如何此人已读过则不再填加
			String result =sche.getFlag();
			result = result.trim().substring(0, result.length()-1);
			String[] results = result.split(";"); 
			for(int j=0;j<results.length;j++){
				if(u.equals(results[j])){
					break;
				}else{
					String ud=null;
					if(result==null||result.equals("")){
						ud=u+";";
					}else{
						ud=result+u+";";
					}
					sche.setFlag(ud);
					sche.setUuid(scuuid);
					dao.saveflag(sche);
				}
			}
		}else{
			String result =sche.getFlag();
			String ud=null;
			if(result==null||result.equals("")){
				ud=u+";";
			}else{
				ud=result+u+";";
			}
			sche.setFlag(ud);
			sche.setUuid(scuuid);
			dao.saveflag(sche);
		}
		return 1;
	}

	/**
	 * 20150521
	 * sunshanshan
	 * 仓库权限列表
	 */
	public static List<Warepowers> checkWarePower(){
		List<Warepowers> wps=new ArrayList<>();
		if(ContextHelper.isAdmin()){
			wps=null;
		}else{
			wps=ContextHelper.getUserLoginInfo().getWps();
		}
		return wps;
	}
	
	public static boolean checkWarePermit(Integer ware_id, String flag) {
		Boolean iden=false;
		List<Warepowers> wps=new ArrayList<>();
		if(ContextHelper.isAdmin()){
			iden=true;
		}else{
			wps=ContextHelper.getUserLoginInfo().getWps();
			if(wps.size()>0){
				if(ware_id==null || ware_id==0){//添加出、入库单时没有仓库id
					for(int i=0;i<wps.size();i++){
							if(flag.equals("in") && wps.get(i).getPrvg().contains("1")){//入库标识
								iden=true;break;
							}else if(flag.equals("out")  && wps.get(i).getPrvg().contains("2")){//出库标识
								iden=true;break;
							}else if(flag.equals("select")  && wps.get(i).getPrvg().contains("4")){//查询标识
								iden=true;break;
							}
							
					}
				}else{
					for(int i=0;i<wps.size();i++){
						if(wps.get(i).getWare_id().intValue()==ware_id.intValue()){
							if(flag.equals("in") && wps.get(i).getPrvg().contains("1")){//入库标识
								iden=true;break;
							}else if(flag.equals("out")  && wps.get(i).getPrvg().contains("2")){//出库标识
								iden=true;break;
							}else if(flag.equals("select")  && wps.get(i).getPrvg().contains("4")){//查询标识
								iden=true;break;
							}
						}
					}
				}
				
			}
		}
		return iden;
	}

}
