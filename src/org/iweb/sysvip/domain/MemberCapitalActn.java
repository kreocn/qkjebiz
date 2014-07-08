/**
 * 
 */
package org.iweb.sysvip.domain;

import java.util.Date;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-2-20 上午10:14:39
 */
public class MemberCapitalActn {
	private Integer uuid;// (int) 主键自增
	private String member_id;// (varchar) 会员ID
	private Integer htype;// (int) 历史数据类型 -1删除 0新增 1资金账户增加 2减少 3消费积分增加 4减少 5返利积分增加 6减少 7随量积分增加 8减少
	private Integer mode;// (int) 方式 0系统自动 1人工修改 2返利单添加
	private String mode_uuid;// (varchar) 和mode想关联的uuid
	private Double money;// (decimal) 资金
	private Integer score;// (int) 积分
	private String note;// (varchar) 说明
	private String lm_user;// (varchar) 当mode是人工时,需要填写,非人工,则填写SYSTEM
	private Date lm_time;// (timestamp) 0

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

	public Integer getHtype() {
		return htype;
	}

	public void setHtype(Integer htype) {
		this.htype = htype;
	}

	public Integer getMode() {
		return mode;
	}

	public void setMode(Integer mode) {
		this.mode = mode;
	}

	public String getMode_uuid() {
		return mode_uuid;
	}

	public void setMode_uuid(String mode_uuid) {
		this.mode_uuid = mode_uuid;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
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
