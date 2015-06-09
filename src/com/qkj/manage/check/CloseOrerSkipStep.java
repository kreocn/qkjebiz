package com.qkj.manage.check;

public class CloseOrerSkipStep {
	private String skip_dept;// 需要重置流程的特殊部门
	private Integer isSub;// 是否包涵子部门1是0否
	private String start_step;// 从第几步开始执行跳过
	private String skip_step;// 要跳过的步骤

	public CloseOrerSkipStep() {

	}

	public CloseOrerSkipStep(String skip_dept, Integer isSub, String start_step, String skip_step) {
		this.skip_dept = skip_dept;
		this.isSub = isSub;
		this.start_step = start_step;
		this.skip_step = skip_step;
	}

	public String getSkip_dept() {
		return skip_dept;
	}

	public void setSkip_dept(String skip_dept) {
		this.skip_dept = skip_dept;
	}

	public Integer getIsSub() {
		return isSub;
	}

	public void setIsSub(Integer isSub) {
		this.isSub = isSub;
	}

	public String getStart_step() {
		return start_step;
	}

	public void setStart_step(String start_step) {
		this.start_step = start_step;
	}

	public String getSkip_step() {
		return skip_step;
	}

	public void setSkip_step(String skip_step) {
		this.skip_step = skip_step;
	}

}
