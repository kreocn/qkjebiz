package com.qkj.manage.check;

public class SkipStep {
	private String skip_dept;//需要重置流程的特殊部门
	private Integer isSub;//是否包涵子部门1是0否
	private int skip_step;//要跳过的步骤
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
	public int getSkip_step() {
		return skip_step;
	}
	public void setSkip_step(int skip_step) {
		this.skip_step = skip_step;
	}

}
