package com.qkj.manage.check;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;

import com.qkj.manage.action.CloseOrderAction;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.CloseOrder;

public class CloseOrderCheckSkip {
	private CloseOrerSkipStep skipStep;
	private static List<CloseOrerSkipStep> skipSteps = new ArrayList<>();
	static {
		// 北京
		skipSteps.add(new CloseOrerSkipStep("3", 1, "check30", "mdyCloseOrderSMDStatus50")); // 申请 4总监 7跳过销管副总
		skipSteps.add(new CloseOrerSkipStep("3", 1, "check0", "check20,mdyCloseOrderSMDStatus10")); // 跳过大区
		// 省外
		skipSteps.add(new CloseOrerSkipStep("211", 1, "check30", "mdyCloseOrderSMDStatus50"));// 总监审后销管销管副总代审
		skipSteps.add(new CloseOrerSkipStep("211", 1, "check0", "check20,mdyCloseOrderSMDStatus10"));// 跳过大区
		// 西藏
		skipSteps.add(new CloseOrerSkipStep("2302", 1, "check20", "mdyCloseOrderSMDStatus10"));// 大区审后销管经理代审
		// 新疆
		skipSteps.add(new CloseOrerSkipStep("2203", 1, "check20", "mdyCloseOrderSMDStatus10"));// 大区审后销管经理代审
	}

	private String str;
	private String skipstr;
	private static CloseOrder closerOrder;

	public static CloseOrder getCloserOrder() {
		return closerOrder;
	}

	public static void setCloserOrder(CloseOrder closerOrder) {
		CloseOrderCheckSkip.closerOrder = closerOrder;
	}

	public void checkSkip(CloseOrder closerOrder,String method) {
		this.setCloserOrder(closerOrder);
		String userid = ContextHelper.getUserLoginUuid();
		int falg = 0;
		if (skipSteps.size() > 0) {
			for (int i = 0; i < skipSteps.size(); i++) {
				CloseOrerSkipStep as = new CloseOrerSkipStep();
				as = skipSteps.get(i);
				if(closerOrder.getType()==1){
					if(as.getStart_step().equals("check0")){
						continue;
					}
				}
				
				if (as.getIsSub() == 1) {// 包含子部门
					String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT + closerOrder.getApply_dept());//
					String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
					Boolean iskip = ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
					if (as.getSkip_dept().equals(closerOrder.getApply_dept())) {
						iskip = true;
					}
					if (iskip == true) {// 是特殊部门
						if (method.equals(as.getStart_step())) {
							specialStep(method, as);
							falg = 1;
							break;
						} else {
							continue;
						}
					} else {
						continue;
					}
				} else {// 不包含子部门
					if (closerOrder.getApply_dept().equals(as.getSkip_dept())) {// 是特殊部门
						if (method.equals(as.getStart_step())) {
							specialStep(method, as);
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
				normalStep(method);
			}
		} else {// 没有特殊流程
			normalStep(method);
		}
	}

	private void specialStep(String st, CloseOrerSkipStep as) {
		String userid = ContextHelper.getUserLoginUuid();
		CloseOrderStep ca = new CloseOrderStep();
		
		str = st;// 现在调用的步骤
		skipstr = as.getSkip_step();// 跳过的步骤
		try {
			ca.getClass().getMethod(str, new Class[] { String.class }).invoke(ca, new Object[] { userid });
			if(skipstr.contains(",")){
				String meth[]=skipstr.split(",");
				if(meth.length>0){
					for(int i=0;i<meth.length;i++){
						String m=meth[i];
						ca.getClass().getMethod(m, new Class[] { String.class }).invoke(ca, new Object[] { "2" });// 跳过的方法
					}
				}else{
					ca.getClass().getMethod(skipstr, new Class[] { String.class }).invoke(ca, new Object[] { "2" });// 跳过的方法
				}
			}else{
				ca.getClass().getMethod(skipstr, new Class[] { String.class }).invoke(ca, new Object[] { "2" });// 跳过的方法
			}
			
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void normalStep(String st) {
		String userid = ContextHelper.getUserLoginUuid();
		CloseOrderStep ca = new CloseOrderStep();
		str = st;// 现在调用的步骤
		try {
			ca.getClass().getMethod(str, new Class[] { String.class }).invoke(ca, new Object[] { userid });
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
