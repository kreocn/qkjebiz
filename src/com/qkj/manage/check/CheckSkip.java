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
	private List<SkipStep> skipSteps = new ArrayList<>();
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

	public List<SkipStep> getSkipSteps() {
		return skipSteps;
	}

	public void setSkipSteps(List<SkipStep> skipSteps) {
		this.skipSteps = skipSteps;
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
		skipList();
		int falg = 0;
		if (skipSteps.size() > 0) {
			for (int i = 0; i < skipSteps.size(); i++) {
				SkipStep as = new SkipStep();
				as = skipSteps.get(i);
				if (as.getIsSub() == 1) {// 包含子部门
					String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT + active.getApply_dept());//
					String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
					Boolean iskip = ToolsUtil.isIn(as.getSkip_dept(), s);// 判断在不在数组中
					if (iskip == true) {// 是特殊部门
						specialStep(st);
						falg = 1;
						break;
					} else {
						continue;
					}
				} else {// 不包含子部门
					if (active.getApply_dept().equals(as.getSkip_dept())) {// 是特殊部门
						specialStep(st);
						falg = 1;
						break;
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

	private void specialStep(int st) {
		String userid = ContextHelper.getUserLoginUuid();
		str = "step" + st;// 现在调用的步骤
		skipstr = "step" + skipStep.getSkip_step();// 跳过的步骤
		if (st ==skipStep.getStart_step()) {// 下一步跳过则在这一步填加系统管理员审核
			try {
				step.getClass().getMethod(str, new Class[] { String.class }).invoke(step, new Object[] { userid });
				step.getClass().getMethod(skipstr, new Class[] { String.class }).invoke(step, new Object[] { "1" });// 跳过的方法
			} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {// 调用审核步骤
			try {
				step.getClass().getMethod(str, new Class[] { String.class }).invoke(step, new Object[] { userid });
			} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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

	private void skipList() {
		//北京+省外总监审后，跳过销管副总直接到财务
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("210");
		skipStep.setStart_step(4);//总监
		skipStep.setSkip_step(7);//申请跳过销管副总
		skipSteps.add(skipStep);
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("210");
		skipStep.setStart_step(14);//总监
		skipStep.setSkip_step(17);//结案大区跳过
		skipSteps.add(skipStep);
		
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("211");
		skipStep.setStart_step(4);//总监
		skipStep.setSkip_step(7);//申请跳过销管副总
		skipSteps.add(skipStep);
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("211");
		skipStep.setStart_step(14);//总监
		skipStep.setSkip_step(17);//结案大区跳过
		skipSteps.add(skipStep);
		
		//新疆+西藏跳过销管经理
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("2302");//西藏
		skipStep.setStart_step(2);//大区
		skipStep.setSkip_step(3);//申请跳过销管经理
		skipSteps.add(skipStep);
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("2302");
		skipStep.setStart_step(12);
		skipStep.setSkip_step(13);
		skipSteps.add(skipStep);
		
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("22030");//新疆
		skipStep.setStart_step(2);//大区
		skipStep.setSkip_step(3);//申请跳过销管经理
		skipSteps.add(skipStep);
		skipStep = new SkipStep();
		skipStep.setIsSub(1);
		skipStep.setSkip_dept("22030");
		skipStep.setStart_step(12);
		skipStep.setSkip_step(13);
		skipSteps.add(skipStep);
		
		
	}

	public static void main(String[] args) throws Exception {
		Active ac = new Active();
		ac.setUuid(1);
		ac.setApply_dept("21127");
		System.out.println("execute time:");

	}
}
