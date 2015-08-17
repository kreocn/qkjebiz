package com.qkj.manage.domain;

import java.util.Date;
public class StoresTicket {
private int id;  //主键
private String product_id;
private String ticket_name;
private String product_code;
private String start_time;
private String end_time;
private Integer num;
private String user_name;
private String login_dept;
private String login_name;
private String user_id;

//非数据库字段

private String time_begin;
private String time_end;
public String getTime_begin() {
	return time_begin;
}
public void setTime_begin(String time_begin) {
	this.time_begin = time_begin;
}
public String getTime_end() {
	return time_end;
}
public void setTime_end(String time_end) {
	this.time_end = time_end;
}
public String getUser_id() {
	return user_id;
}
public void setUser_id(String user_id) {
	this.user_id = user_id;
}
public String getUser_name() {
	return user_name;
}
public void setUser_name(String user_name) {
	this.user_name = user_name;
}
public String getLogin_dept() {
	return login_dept;
}
public void setLogin_dept(String login_dept) {
	this.login_dept = login_dept;
}
public String getLogin_name() {
	return login_name;
}
public void setLogin_name(String login_name) {
	this.login_name = login_name;
}

public Integer getNum() {
	return num;
}
public void setNum(Integer num) {
	this.num = num;
}
public String getProduct_code() {
	return product_code;
}
public void setProduct_code(String product_code) {
	this.product_code = product_code;
}


public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getProduct_id() {
	return product_id;
}
public void setProduct_id(String product_id) {
	this.product_id = product_id;
}
public String getTicket_name() {
	return ticket_name;
}
public void setTicket_name(String ticket_name) {
	this.ticket_name = ticket_name;
}
public String getStart_time() {
	return start_time;
}
public void setStart_time(String start_time) {
	this.start_time = start_time;
}
public String getEnd_time() {
	return end_time;
}
public void setEnd_time(String end_time) {
	this.end_time = end_time;
}

}
