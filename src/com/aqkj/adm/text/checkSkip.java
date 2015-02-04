package com.aqkj.adm.text;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;
import org.iweb.test.test;

import com.qkj.manage.domain.Active;

public class checkSkip {
	private skip skip;
	private List<skip> skips=new ArrayList<>();
	private check check=new check();
	private String str;
	private String skipstr;
	
	
	public skip getSkip() {
		return skip;
	}

	public void setSkip(skip skip) {
		this.skip = skip;
	}

	public void checkSkip(Active active,int st){
		//check.getClass().getMethod(str, new Class[]{});
		skipList();
		int falg=0;
		if(skips.size()>0){
			for(int i=0;i<skips.size();i++){
				skip as=new skip();
				as=skips.get(i);
				if(as.getIsSub()==1){//包含子部门
					String str = (String)CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT+active.getApply_dept());//
					String[] s = (String[])JSONUtil.toObject(str, String[].class);//转换成数组
					Boolean iskip=ToolsUtil.isIn(as.getSkip_dept(), s);//判断在不在数组中
					if(iskip==true){//是特殊部门
						specialStep(st);
						falg=1;
						break;
					}else{
						continue;
					}
				}else{//不包含子部门
					if(active.getApply_dept().equals(as.getSkip_dept())){//是特殊部门
						specialStep(st);
						falg=1;
						break;
					}else{
						continue;
					}
					
				}
			}
			if(falg!=1){//特殊部门列表中不包含当前部门，流程照常进行
				str="step"+st;//现在调用的步骤
				try {
					check.getClass().getMethod(str, new Class[]{}).invoke(check, new Object[]{});
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
		}
	}

	private void specialStep(int st) {
		str="step"+st;//现在调用的步骤
		skipstr="step"+skip.getSkip_step();//跳过的步骤
		if(st==(skip.getSkip_step()-1)){//下一步跳过则在这一步填加系统管理员审核
			try {
				check.getClass().getMethod(str, new Class[]{}).invoke(check, new Object[]{});
				check.getClass().getMethod(skipstr, new Class[]{}).invoke(check, new Object[]{});//跳过的方法
			} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
		}else{//调用审核步骤
			try {
				check.getClass().getMethod(str, new Class[]{}).invoke(check, new Object[]{});
			} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private void skipList() {
		skip.setIsSub(1);
		skip.setSkip_dept("211");
		skip.setSkip_step(2);
		skips.add(skip);
	}
	
/*	public static void main(String[] args) {
		checkSkip cs=new checkSkip();
		Active ac=new Active();
		ac.setUuid(1);
		ac.setApply_dept("21127");
		cs.checkSkip(ac,1);
	
	}*/
	
	public static void main(String[] args) throws Exception {
		Active ac=new Active();
		ac.setUuid(1);
		ac.setApply_dept("21127");
		System.out.println("execute time:");
		checkSkip cs=new checkSkip();
		cs.checkSkip(ac,1);
		

	}
}
