package com.qkj.manage.check;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;

import com.qkj.manage.domain.Active;

public class CheckSkip {
	private SkipStep skipStep;
	private static List<SkipStep> skipSteps = new ArrayList<>();
	static {
		// 北京
		skipSteps.add(new SkipStep("3",null, 1, 4, 7,false)); // 申请 4总监 7跳过销管副总
		skipSteps.add(new SkipStep("3",null, 1, 14, 17,false));// 结案 14总监 17销管副总
		skipSteps.add(new SkipStep("3",null,1, 2, 3,false));// 结案 14总监 17跳过销管经理
		skipSteps.add(new SkipStep("3",null, 1, 12, 13,false));// 结案 14总监 17跳过销管经理
		// 省外
		skipSteps.add(new SkipStep("211",null, 1, 4, 7,false)); // 申请 4总监 7跳过销管副总
		skipSteps.add(new SkipStep("211",null, 1, 14, 17,false));// 结案 14总监 17跳过大区
		skipSteps.add(new SkipStep("211", null,1, 2, 3,false));// 申请 2大区 3跳过销管经理
		skipSteps.add(new SkipStep("211",null, 1, 12, 13,false));// 结案 12大区 13跳过销管经理
		// 西藏
		skipSteps.add(new SkipStep("2302",null, 1, 2, 3,false)); // 申请 2大区 3跳过销管经理
		skipSteps.add(new SkipStep("2302",null, 1, 12, 13,false));// 结案 12大区 13跳过销管经理
		// 新疆
		skipSteps.add(new SkipStep("2203",null, 1, 2, 3,false)); // 申请 2大区 3跳过销管经理
		skipSteps.add(new SkipStep("2203",null, 1, 12, 13,false));// 结案 12大区 13跳过销管经理
		//西北（申请（办事外，总监）结案（办事处，销管，总监，财务））
		skipSteps.add(new SkipStep("220","2203", 1, 0, 2,"3",false)); // 申请
		skipSteps.add(new SkipStep("220","2203",1, 4, 7,"9",false)); // 申请
		//skipSteps.add(new SkipStep("220","2203",1, 10, 12,false)); // 结案
		skipSteps.add(new SkipStep("220","2203",1, 14, 17,"19",false)); // 结案
		
		skipSteps.add(new SkipStep("220","2203",1, 7, 9,false)); // 结案
		skipSteps.add(new SkipStep("220","2203",1, 17, 19,false)); // 结案
		
		skipSteps.add(new SkipStep("2202A",null,1, 1, 2,"3",false)); // 申请
		skipSteps.add(new SkipStep("2202A",null,1, 11, 10,false)); // 结案
		
		skipSteps.add(new SkipStep("2202E",null,1, 1, 2,"3",false)); // 申请
		skipSteps.add(new SkipStep("2202E",null,1, 11, 10,false)); // 结案
		
		skipSteps.add(new SkipStep("2202X",null,1, 1, 2,"3",false)); // 申请
		skipSteps.add(new SkipStep("2202X",null,1, 11, 10,false)); // 结案
		//红酒
		skipSteps.add(new SkipStep("312", null,1, 1, 2,"3",false)); // 申请 直接到总监
		skipSteps.add(new SkipStep("312", null,1,11, 12, "13",false));// 结案 直接到总监
		
		//传奇天估德401402
		skipSteps.add(new SkipStep("4",null, 1, 2, 4,"5",false));// 结案 14总监 17跳过销管副总
		skipSteps.add(new SkipStep("4",null, 1, 12,14,"15",false));// 结案 14总监 17跳过销副总
		
		skipSteps.add(new SkipStep("4", "40102",1, 1, 3,false)); // 申请 2大区 3跳过大区
		skipSteps.add(new SkipStep("4","40102", 1, 11, 13,false)); // 申请 2大区 3跳过大区
		
		skipSteps.add(new SkipStep("40102",null, 1, 1, 0,"3",false)); // 申请 2大区 3跳过大区
		skipSteps.add(new SkipStep("40102",null, 1, 11, 10,"13",false)); // 申请 2大区 3跳过大区
		
		
		
	}

	private Step step = new Step();
	private static Active active;
	private String str;
	private String skipstr;

	public SkipStep getSkipStep() {
		return skipStep;
	}

	public void setSkipStep(SkipStep skipStep) {
		this.skipStep = skipStep;
	}

	public static List<SkipStep> getSkipSteps() {
		return skipSteps;
	}

	public static void setSkipSteps(List<SkipStep> skipSteps) {
		CheckSkip.skipSteps = skipSteps;
	}

	public Step getStep() {
		return step;
	}

	public void setStep(Step step) {
		this.step = step;
	}

	public static Active getActive() {
		return active;
	}

	public static void setActive(Active active) {
		CheckSkip.active = active;
	}

	public void checkSkip(Active active, int st) {
		this.setActive(active);
		// check.getClass().getMethod(str, new Class[]{});
		String userid = ContextHelper.getUserLoginUuid();
		// skipList();
		int falg = 0;
		if (skipSteps.size() > 0) {
			/*
			 * for (int i = 0; i < skipSteps.size(); i++) {
			 * SkipStep as = new SkipStep();
			 * as = skipSteps.get(i);
			 * String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT + active.getApply_dept());//
			 * String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
			 * Boolean iskip = ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
			 * }
			 */

			for (int i = 0; i < skipSteps.size(); i++) {
				SkipStep as = new SkipStep();
				SkipStep asn = new SkipStep();
				as = skipSteps.get(i);
				Integer star=null;
				if (as.getIsSub() == 1) {// 包含子部门
					String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT + active.getApply_dept());//
					String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
					Boolean iskip = ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
					Boolean isex=true;
					if(as.getEx_dept()!=null){
						//isex=ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
						if(ToolsUtil.isIn(as.getEx_dept(), s) || as.getEx_dept().equals(active.getApply_dept())){
							isex=false;
						}
					}
					if (as.getSkip_dept().equals(active.getApply_dept())) {
						iskip = true;
					}
					for(int j=0;j<skipSteps.size();j++){
						SkipStep as2 = new SkipStep();
						as2 = skipSteps.get(j);
						if(as2.getFlag()==true){
							Boolean f=ToolsUtil.isIn(as2.getSkip_dept(), s);// 除些部门外
							if(f==false){
								star=as2.getStart_step();
								asn=as2;
								iskip=true;
								break;
							}
						}
					}
					
					if (iskip == true && isex==true) {// 是特殊部门
						if (st == as.getStart_step() || (star!=null && st==star)) {
							if(star!=null && st==star){
								specialStep(st, asn);
								falg = 1;
							}else{
								if(as.getFlag()==false){
									specialStep(st, as);
									falg = 1;
								}
							}
							break;
						}else {
							continue;
						}
					} else {
						continue;
					}
				} else {// 不包含子部门
					if (active.getApply_dept().equals(as.getSkip_dept())) {// 是特殊部门
						if (st == as.getStart_step()) {
							specialStep(st, as);
							falg = 1;
							break;
						} else {
							continue;
						}
					} else {
						continue;
					}

				}
			}
			if (falg != 1) {// 特殊部门列表中不包含当前部门，流程照常进行
				normalStep(st);
			}
		} else {// 没有特殊流程
			normalStep(st);
		}
	}

	public void checkSkip2(Active active, int st) {
		this.setActive(active);
		// check.getClass().getMethod(str, new Class[]{});
		String userid = ContextHelper.getUserLoginUuid();
		// skipList();
		int falg = 0;
		if (skipSteps.size() > 0) {
			/*
			 * for (int i = 0; i < skipSteps.size(); i++) {
			 * SkipStep as = new SkipStep();
			 * as = skipSteps.get(i);
			 * String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT + active.getApply_dept());//
			 * String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
			 * Boolean iskip = ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
			 * }
			 */

			for (int i = 0; i < skipSteps.size(); i++) {
				SkipStep as = new SkipStep();
				as = skipSteps.get(i);
				if (as.getIsSub() == 1) {// 包含子部门
					String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT + active.getApply_dept());//
					String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
					Boolean iskip = ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
					if (as.getSkip_dept().equals(active.getApply_dept())) {
						iskip = true;
					}
					if (iskip == true) {// 是特殊部门
						if (st == as.getStart_step()) {
							specialStep2(st, as);
							falg = 1;
							break;
						} else {
							continue;
						}
					} else {
						continue;
					}
				} else {// 不包含子部门
					if (active.getApply_dept().equals(as.getSkip_dept())) {// 是特殊部门
						if (st == as.getStart_step()) {
							specialStep(st, as);
							falg = 1;
							break;
						} else {
							continue;
						}
					} else {
						continue;
					}

				}
			}
			if (falg != 1) {// 特殊部门列表中不包含当前部门，流程照常进行
				normalStep(st);
			}
		} else {// 没有特殊流程
			normalStep(st);
		}
	}

	private void specialStep(int st, SkipStep as) {
		String userid = ContextHelper.getUserLoginUuid();
		str = "step" + st;// 现在调用的步骤
		skipstr = "step" + as.getSkip_step();// 跳过的步骤
		try {
			step.getClass().getMethod(str, new Class[] { String.class }).invoke(step, new Object[] { userid });
			step.getClass().getMethod(skipstr, new Class[] { String.class }).invoke(step, new Object[] { "2" });// 跳过的方法
			if(as.getSkip_n()!=null&&!as.equals("")){
				String n="step" + as.getSkip_n();
				step.getClass().getMethod(n, new Class[] { String.class }).invoke(step, new Object[] { "2" });// 跳过的方法
			}
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void specialStep2(int st, SkipStep as) {
		String userid = ContextHelper.getUserLoginUuid();
		str = "step" + st;// 现在调用的步骤
		skipstr = "step" + as.getSkip_step();// 跳过的步骤
		try {
			// step.getClass().getMethod(str, new Class[] { String.class }).invoke(step, new Object[] { userid });
			step.getClass().getMethod(skipstr, new Class[] { String.class }).invoke(step, new Object[] { "2" });// 跳过的方法
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void normalStep(int st) {
		String userid = ContextHelper.getUserLoginUuid();
		str = "step" + st;// 现在调用的步骤
		try {
			step.getClass().getMethod(str, new Class[] { String.class }).invoke(step, new Object[] { userid });
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {
		Active ac = new Active();
		ac.setUuid(1);
		ac.setApply_dept("21127");
		System.out.println("execute time:");

	}
}
