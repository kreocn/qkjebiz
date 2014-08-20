/**
 * 
 */
package com.qkj.manage.domain;

import java.util.Date;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-2-18 上午9:50:11
 */
public class RebatesLading {
	private Integer rebates_id;
	private String lading_id;

	// 以下为非数据库字段
	private Date lading_time;

	public RebatesLading() {
	}

	public RebatesLading(Integer rebates_id, String lading_id) {
		this.rebates_id = rebates_id;
		this.lading_id = lading_id;
	}

	public Date getLading_time() {
		return lading_time;
	}

	public void setLading_time(Date lading_time) {
		this.lading_time = lading_time;
	}

	public Integer getRebates_id() {
		return rebates_id;
	}

	public void setRebates_id(Integer rebates_id) {
		this.rebates_id = rebates_id;
	}

	public String getLading_id() {
		return lading_id;
	}

	public void setLading_id(String lading_id) {
		this.lading_id = lading_id;
	}

}
