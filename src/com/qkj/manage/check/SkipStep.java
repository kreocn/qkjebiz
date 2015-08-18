package com.qkj.manage.check;

public class SkipStep {
	private String skip_dept;// 需要重置流程的特殊部门
	private String ex_dept;// 不需要按此流程走的子部门
	private Integer isSub;// 是否包涵子部门1是0否
	private int start_step;// 从第几步开始执行跳过
	private int skip_step;// 要跳过的步骤
	private String skip_n;// 跳过的附加步骤
	private Boolean flag;// true为除此部门外，false只有此部门

	public SkipStep() {

	}

	public SkipStep(String skip_dept,String ex_dept, Integer isSub, int start_step, int skip_step, Boolean flag) {
		this.skip_dept = skip_dept;
		this.ex_dept=ex_dept;
		this.isSub = isSub;
		this.start_step = start_step;
		this.skip_step = skip_step;
		this.flag = flag;
	}

	public SkipStep(String skip_dept,String ex_dept, Integer isSub, int start_step, int skip_step, String skip_n, Boolean flag) {
		this.skip_dept = skip_dept;
		this.ex_dept=ex_dept;
		this.isSub = isSub;
		this.start_step = start_step;
		this.skip_step = skip_step;
		this.skip_n = skip_n;
		this.flag = flag;
	}

	public String getEx_dept() {
		return ex_dept;
	}

	public void setEx_dept(String ex_dept) {
		this.ex_dept = ex_dept;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	public String getSkip_n() {
		return skip_n;
	}

	public void setSkip_n(String skip_n) {
		this.skip_n = skip_n;
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

	public int getSkip_step() {
		return skip_step;
	}

	public void setSkip_step(int skip_step) {
		this.skip_step = skip_step;
	}

	public int getStart_step() {
		return start_step;
	}

	public void setStart_step(int start_step) {
		this.start_step = start_step;
	}

}
