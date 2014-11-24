package org.iweb.rpt.domain;

import java.util.Date;

public class ActiveTime {
	private Integer uuid;
	private Double total;
	private Double edit;
	private Double mct;
	private Double xct;
	private Double zct;
	private Double xgt;
	private Double xgft;
	private Double pct;
	private String atype;
	private Date adate;
	private String acode;
	
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public Double getEdit() {
		return edit;
	}
	public void setEdit(Double edit) {
		this.edit = edit;
	}
	public Double getMct() {
		return mct;
	}
	public void setMct(Double mct) {
		this.mct = mct;
	}
	public Double getXct() {
		return xct;
	}
	public void setXct(Double xct) {
		this.xct = xct;
	}
	public Double getZct() {
		return zct;
	}
	public void setZct(Double zct) {
		this.zct = zct;
	}
	
	public Double getXgt() {
		return xgt;
	}
	public void setXgt(Double xgt) {
		this.xgt = xgt;
	}
	
	public Double getXgft() {
		return xgft;
	}
	public void setXgft(Double xgft) {
		this.xgft = xgft;
	}
	public Double getPct() {
		return pct;
	}
	public void setPct(Double pct) {
		this.pct = pct;
	}
	public String getAtype() {
		return atype;
	}
	public void setAtype(String atype) {
		this.atype = atype;
	}
	public Date getAdate() {
		return adate;
	}
	public void setAdate(Date adate) {
		this.adate = adate;
	}
	public String getAcode() {
		return acode;
	}
	public void setAcode(String acode) {
		this.acode = acode;
	}
	
	
	

}
