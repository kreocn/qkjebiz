package com.qkj.manage.domain;

import java.util.Date;
public class StoresOrder {
private int id;  //主键
private String user_id;//用户id
private String user_name;//用户名称
private Double total_price;//订单总价
private int fd_check=0;//订单状态
private String add_time;//添加时间
private Date lmtime;//修改时间
public Date getLmtime() {
	return lmtime;
}

public void setLmtime(Date lmtime) {
	this.lmtime = lmtime;
}

private String lm_user;//修改用户
public String getAdd_time() {
	return add_time;
}

public void setAdd_time(String add_time) {
	this.add_time = add_time;
}

public int getId() {
	return id;
}

public Double getTotal_price() {
	return total_price;
}
public int getFd_check() {
	return fd_check;
}

public String getLm_user() {
	return lm_user;
}
public void setId(int id) {
	this.id = id;
}
public void setTotal_price(Double total_price) {
	this.total_price = total_price;
}
public void setFd_check(int fd_check) {
	this.fd_check = fd_check;
}

public void setLm_user(String lm_user) {
	this.lm_user = lm_user;
}

public String getUser_id() {
	return user_id;
}

public String getUser_name() {
	return user_name;
}

public void setUser_id(String user_id) {
	this.user_id = user_id;
}

public void setUser_name(String user_name) {
	this.user_name = user_name;
}

}
