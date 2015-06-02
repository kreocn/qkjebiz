package org.iweb.rpt.domain;

import java.util.Date;

public class SelectEfMonth {
	private Integer cout;

	private Date yearMonth;
	private Integer checkState;
	private Integer type;
	private String dept_code;
	private String dept_cname;
	private Date pass_time_start;
	private Date pass_time_end;

	public Integer getCout() {
		return cout;
	}

	public void setCout(Integer cout) {
		this.cout = cout;
	}

	public Date getPass_time_start() {
		return pass_time_start;
	}

	public void setPass_time_start(Date pass_time_start) {
		this.pass_time_start = pass_time_start;
	}

	public Date getPass_time_end() {
		return pass_time_end;
	}

	public void setPass_time_end(Date pass_time_end) {
		this.pass_time_end = pass_time_end;
	}

	public Date getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(Date yearMonth) {
		this.yearMonth = yearMonth;
	}

	public Integer getCheckState() {
		return checkState;
	}

	public void setCheckState(Integer checkState) {
		this.checkState = checkState;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getDept_cname() {
		return dept_cname;
	}

	public void setDept_cname(String dept_cname) {
		this.dept_cname = dept_cname;
	}

}
