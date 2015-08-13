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
