package com.qkj.manage.domain;

public class StoresOrderCustom {
private int id;
private String product_id;
private String login_dept;
private Double price;
private String bar_code;
public String getBar_code() {
	return bar_code;
}
public void setBar_code(String bar_code) {
	this.bar_code = bar_code;
}
public int getId() {
	return id;
}
public String getProduct_id() {
	return product_id;
}

public Double getPrice() {
	return price;
}
public void setId(int id) {
	this.id = id;
}
public void setProduct_id(String product_id) {
	this.product_id = product_id;
}

public void setPrice(Double price) {
	this.price = price;
}
public String getLogin_dept() {
	return login_dept;
}
public void setLogin_dept(String login_dept) {
	this.login_dept = login_dept;
}
}
