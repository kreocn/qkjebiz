package com.qkj.sche.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.User;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.sche.dao.ScheduleDAO;
import com.qkj.sche.domain.Schedule;
import com.qkj.sche.domain.Scheduser;
import com.qkj.sche.domain.usercode;

/**
 * 
 * @author sunshanshan
 *
 */
public class ScheAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ScheAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ScheduleDAO dao = new ScheduleDAO();

	private Schedule sche;
	private List<Schedule> sches;
	private List<usercode> usercodes;
	private usercode usercode;
	private Scheduser shceduser;
	private List<Scheduser> shcedusers;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private Schedule schenn;
	private List<Schedule> schen;
	private Schedule sname;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;公告管理";
	
	public Schedule getSname() {
		return sname;
	}

	public void setSname(Schedule sname) {
		this.sname = sname;
	}

	public List<Schedule> getSchen() {
		return schen;
	}

	public void setSchen(List<Schedule> schen) {
		this.schen = schen;
	}

	public Schedule getSchenn() {
		return schenn;
	}

	public void setSchenn(Schedule schenn) {
		this.schenn = schenn;
	}

	public List<Scheduser> getShcedusers() {
		return shcedusers;
	}

	public void setShcedusers(List<Scheduser> shcedusers) {
		this.shcedusers = shcedusers;
	}

	public Scheduser getShceduser() {
		return shceduser;
	}

	public void setShceduser(Scheduser shceduser) {
		this.shceduser = shceduser;
	}

	public List<usercode> getUsercodes() {
		return usercodes;
	}

	public void setUsercodes(List<usercode> usercodes) {
		this.usercodes = usercodes;
	}

	public usercode getUsercode() {
		return usercode;
	}

	public void setUsercode(usercode usercode) {
		this.usercode = usercode;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public Schedule getSche() {
		return sche;
	}

	public void setSche(Schedule sche) {
		this.sche = sche;
	}

	

	public List<Schedule> getSches() {
		return sches;
	}

	public void setSches(List<Schedule> sches) {
		this.sches = sches;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void list() throws Exception {
		/*ContextHelper.isPermit("QKJ_SCHE");*/
		String u = ContextHelper.getUserLoginUuid();
		String code = ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (sche != null)
				map.putAll(ToolsUtil.getMapByBean(sche));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			if (ContextHelper.isAdmin()) {// 管理员
				this.setSches(dao.list(map));
			}else{
				map.put("puuid", u);
				map.put("ruuid", u);
				map.put("dept_code", code);
				this.setSches(dao.listbyr(map));
			}
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;公告列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		/*return SUCCESS;*/
	}
	
	public String leftList() throws Exception {
		ContextHelper.isPermit("QKJ_SCHE");
		String u = ContextHelper.getUserLoginUuid();
		String code = ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (sche != null)
				map.putAll(ToolsUtil.getMapByBean(sche));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			if (ContextHelper.isAdmin()) {// 管理员
				this.setSches(dao.list(map));
			}else{
				map.put("puuid", u);
				map.put("ruuid", u);
				map.put("dept_code", code);
				this.setSches(dao.listbyr(map));
			}
			
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;公告列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		String u = ContextHelper.getUserLoginUuid();
		try {
			if (null == viewFlag) {
				this.setSche(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				System.out.println("load                                       add");
				this.setSche(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sche/schedule_leftList'>公告列表</a>&nbsp;&gt;&nbsp;增加公告";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", sche.getUuid());
				int infouuid=sche.getUuid();//新闻id
				if (null == map.get("uuid"))
					this.setSche(null);
				else{
					this.setSche((Schedule) dao.list(map).get(0)); 
					map.clear();
					//map.put("r_uuid", u);
					map.put("infor_uuid", sche.getUuid());
					this.setShcedusers(dao.lists(map));
					String ruuid=null;
					for(int i=0;i<shcedusers.size();i++){
						this.setShceduser(shcedusers.get(i));
						map.clear();
						map.put("uuid", shceduser.getR_uuid());
						this.setSname((Schedule)dao.listy(map).get(0));
						if(ruuid!=null){
							ruuid=ruuid+sname.getUsename()+" "+shceduser.getR_uuid()+";";
						}else{
							if(shceduser.getR_uuid().equals("0")){
								ruuid=shceduser.getR_uuid();
								break;
							}else{
								ruuid=sname.getUsename()+" "+shceduser.getR_uuid()+";";
							}
							
						}
						
					}
					if(shcedusers.size()==0){
						sche.setR_uuid("0");
					}else{
						sche.setR_uuid(ruuid);
					}
					if(sche.getFlag()!=null){//查询已阅人
						String result =sche.getFlag();
						if(result!=null){
							result = result.trim().substring(0, result.length()-1);
							String[] results = result.split(";"); 
							String readuuid=null;
							for(int j=0;j<results.length;j++){
								map.clear();
								map.put("uuid",results[j] );
								schen=dao.listy(map);
								for(int h=0;h<schen.size();h++){
									schenn=schen.get(h);
									if(readuuid!=null){
										readuuid=readuuid+schenn.getUsename()+";";
									}else{
										readuuid=schenn.getUsename()+";";
										
									}
								}
								sche.setUser_name(readuuid);
							}
						}
						
					}
				}
				
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sche/schedule_leftList'>公告列表</a>&nbsp;&gt;&nbsp;公告详情";
			}else if ("view".equals(viewFlag)) {//点击详情后，把信息修改为谁已读
				map.clear();
				map.put("uuid", sche.getUuid());
				if (null == map.get("uuid"))
					this.setSche(null);
				else{
					this.setSche((Schedule) dao.list(map).get(0)); 
					map.clear();
					//map.put("r_uuid", u);
					map.put("infor_uuid", sche.getUuid());
					int scuuid=sche.getUuid();
					this.setShcedusers(dao.lists(map));
					String ruuid=null;
					for(int i=0;i<shcedusers.size();i++){
						this.setShceduser(shcedusers.get(i));
						map.clear();
						map.put("uuid", shceduser.getR_uuid());
						this.setSname((Schedule)dao.listy(map).get(0));
						if(ruuid!=null){
							ruuid=ruuid+sname.getUsename()+" "+shceduser.getR_uuid()+";";
						}else{
							if(shceduser.getR_uuid().equals("0")){
								ruuid=shceduser.getR_uuid();
								break;
							}else{
								ruuid=sname.getUsename()+" "+shceduser.getR_uuid()+";";
							}
							
						}
						
					}
					if(shcedusers.size()==0){
						sche.setR_uuid("0");
					}else{
						sche.setR_uuid(ruuid);
					}
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
					
					
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sche/schedule_leftList'>公告列表</a>&nbsp;&gt;&nbsp;公告详情";
			} 
			else {
				this.setSche(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}
	

	public void view(int uuid){
		String u = ContextHelper.getUserLoginUuid();
		sche.setFlag(u);
		sche.setUuid(uuid);
		dao.saveflag(sche);
	}
	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_SCHE_ADDSCHE");
		String u = ContextHelper.getUserLoginUuid();
		try {
			if(sche!=null&&sche.getR_uuid()!=null&&!sche.getR_uuid().equals("")){
				String result =sche.getR_uuid();
				result = result.trim().substring(0, result.length()-1);
				String[] results = result.split(";"); 
				dao.add(sche);
				for(int i=0;i<results.length;i++){
					String c=results[i];
					String[] cs=c.split(" ");
					shceduser=new Scheduser();
					shceduser.setP_uuid(u);
					shceduser.setR_uuid(cs[1]);
					shceduser.setInfor_uuid(sche.getUuid());
					dao.adds(shceduser);
				}
			}else{
				dao.add(sche);
				shceduser=new Scheduser();
				shceduser.setP_uuid(u);
				shceduser.setR_uuid("0");
				shceduser.setInfor_uuid(sche.getUuid());
				dao.adds(shceduser);
				
			}
			
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_SCHE_LIST_UPDATE");
		String u = ContextHelper.getUserLoginUuid();
		try {
	/*		ware.setLm_user(ContextHelper.getUserLoginUuid());
			ware.setLm_time(new Date());*/
			String result =sche.getR_uuid();
			if(result!=null&&!result.equals("0")){
				result = result.trim().substring(0, result.length()-1);
				String[] results = result.split(";"); 
				dao.save(sche);
				map.clear();
				map.put("p_uuid", u);
				map.put("infor_uuid", sche.getUuid());
				this.setShcedusers(dao.lists(map));
				String ruuid=null;
				for(int i=0;i<shcedusers.size();i++){
					this.setShceduser(shcedusers.get(i));
					dao.deletes(shceduser);
				}
				
				for(int i=0;i<results.length;i++){
					String c=results[i];
					String[] cs=c.split(" ");
					shceduser=new Scheduser();
					shceduser.setP_uuid(u);
					shceduser.setR_uuid(cs[1]);
					shceduser.setInfor_uuid(sche.getUuid());
					dao.adds(shceduser);
				}
			}else{
				
				dao.save(sche);
				map.clear();
				map.put("p_uuid", u);
				map.put("infor_uuid", sche.getUuid());
				this.setShcedusers(dao.lists(map));
				String ruuid=null;
				for(int i=0;i<shcedusers.size();i++){
					this.setShceduser(shcedusers.get(i));
					dao.deletes(shceduser);
				}
					shceduser=new Scheduser();
					shceduser.setP_uuid(u);
					shceduser.setR_uuid("0");
					shceduser.setInfor_uuid(sche.getUuid());
					dao.adds(shceduser);
			}
			
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_SCHE_LIST_DEL");
		String u = ContextHelper.getUserLoginUuid();
		try {
			//查询当前用户发布的信息
			map.clear();
			map.put("p_uuid", u);
			map.put("infor_uuid", sche.getUuid());
			this.setShcedusers(dao.lists(map));
			//查询信息祥细
			map.clear();
			map.put("uuid", sche.getUuid());
			this.setSche((Schedule)dao.list(map).get(0));
			if(shcedusers.size()>0){//信息是当前用户发布的删除信息及中间表数据
				for(int i=0;i<shcedusers.size();i++){
					this.setShceduser(shcedusers.get(i));
					int id=shceduser.getInfor_uuid();
					if(shceduser!=null&&id==sche.getUuid()){
						dao.delete(sche);//删除信息
						//shceduser.setP_uuid(u);//删除中间表
						//shceduser.setInfor_uuid(sche.getUuid());
						dao.deletes(shceduser);
						break;
						
					}
				}
				
			}else{//不是查看是否是接收者只删除中间表数据
				//查询当前用户接收的信息
				map.clear();
				map.put("r_uuid", u);
				map.put("infor_uuid", sche.getUuid());
				List<Scheduser> users=new ArrayList<>();
				users=dao.lists(map);
				for(int i=0;i<users.size();i++){
					this.setShceduser(shcedusers.get(i));
					int id=shceduser.getInfor_uuid();
					if(shceduser!=null&&id==sche.getUuid()){
						//shceduser.setInfor_uuid(sche.getUuid());
						//shceduser.setR_uuid(u);
						dao.deletes(shceduser);
						break;
						
					}
				}
				
			}
			setMessage("删除成功!ID=" + sche.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	
			
	//查询收件人
	public List<usercode> ruser(String u) throws Exception{
		List<usercode> uscode=new ArrayList<>();
		try {
			map.clear();
			map.put("usercode_name", u);
			this.setUsercodes(dao.listusercode(map));
			uscode=this.getUsercodes();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return uscode;
	}
	
}
