package org.iweb.sysvip.domain;

import java.util.Date;

public class MemberCapitalRescore {
	private Integer uuid;// (int)主键ID
	private String member_id;// (varchar)会员ID
	private Integer score;// (int)积分
	private String note; // 消费说明
	private Integer status;// (int)状态 0初始 1待批 2主管已审 3经理已审
	private String add_user;// (varchar)申请人
	private Date add_time;// (datetime)申请时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (timestamp)最后修改时间

	// 以下为非数据库字段
	private String member_name;
	private String add_user_name;
	private String lm_user_name;
	private Integer mscore; // member score

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getMscore() {
		return mscore;
	}

	public void setMscore(Integer mscore) {
		this.mscore = mscore;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

}
