package org.iweb.sysvip.domain;

import java.util.Date;

public class Info {
	private Integer uuid;// (int)
	private String type;// (varchar)信息种类 TIPS:交流 MSG:留言 PRIV:私信
	private String itype;// (varchar)信息类型 NORMAL:正常 REPLY:回复 REPLYS:管理员回复
	private Integer reuuid;// (int)回复的主UUID
	private String tomember;// (varchar)私信的接收人
	private String imode;// (varchar)交流分类 TIPS:普通 SALES:买卖 QA:询问
	private String title;// (varchar)标题
	private String content;// (text)信息内容
	private Integer checked;// (int)审核状态 0待审 1未通过 2已通过 (留言则是 0未回复 1已回复)
	private Integer del;// (int)删除标记 0正常 1删除
	private Date add_time;// (timestamp)添加时间
	private String add_ip;// (varchar)添加IP
	private String add_member;// (varchar)添加人
	private Date lm_time;// (timestamp)修改时间
	private String lm_ip;// (varchar)修改IP
	private String lm_member;// (varchar)修改人
	private String re_user;// 留言回复专用(管理员)
	private Date re_time;// 留言回复时间

	private String add_member_name;
	private String lm_member_name;
	private String re_user_name;

	public String getRe_user() {
		return re_user;
	}

	public void setRe_user(String re_user) {
		this.re_user = re_user;
	}

	public Date getRe_time() {
		return re_time;
	}

	public void setRe_time(Date re_time) {
		this.re_time = re_time;
	}

	public String getRe_user_name() {
		return re_user_name;
	}

	public void setRe_user_name(String re_user_name) {
		this.re_user_name = re_user_name;
	}

	public String getAdd_member_name() {
		return add_member_name;
	}

	public void setAdd_member_name(String add_member_name) {
		this.add_member_name = add_member_name;
	}

	public String getLm_member_name() {
		return lm_member_name;
	}

	public void setLm_member_name(String lm_member_name) {
		this.lm_member_name = lm_member_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getItype() {
		return itype;
	}

	public void setItype(String itype) {
		this.itype = itype;
	}

	public Integer getReuuid() {
		return reuuid;
	}

	public void setReuuid(Integer reuuid) {
		this.reuuid = reuuid;
	}

	public String getTomember() {
		return tomember;
	}

	public void setTomember(String tomember) {
		this.tomember = tomember;
	}

	public String getImode() {
		return imode;
	}

	public void setImode(String imode) {
		this.imode = imode;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getChecked() {
		return checked;
	}

	public void setChecked(Integer checked) {
		this.checked = checked;
	}

	public Integer getDel() {
		return del;
	}

	public void setDel(Integer del) {
		this.del = del;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public String getAdd_ip() {
		return add_ip;
	}

	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}

	public String getAdd_member() {
		return add_member;
	}

	public void setAdd_member(String add_member) {
		this.add_member = add_member;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getLm_ip() {
		return lm_ip;
	}

	public void setLm_ip(String lm_ip) {
		this.lm_ip = lm_ip;
	}

	public String getLm_member() {
		return lm_member;
	}

	public void setLm_member(String lm_member) {
		this.lm_member = lm_member;
	}

}
