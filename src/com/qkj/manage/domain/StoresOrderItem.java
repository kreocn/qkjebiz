package com.qkj.manage.domain;
public class StoresOrderItem {
private int id;
private String order_id;
private String title;
private Double product_price;
private Double order_num;
private Double order_total_price;
private String  integration;
private String prod_code;
private String bar_code;
private String product_id;
private String spec;
private String brand;
private String brand_name;

public String getBrand_name() {
	return brand_name;
}

public void setBrand_name(String brand_name) {
	this.brand_name = brand_name;
}

public int getId() {
	return id;
}

public String getBrand() {
	return brand;
}

public void setBrand(String brand) {
	this.brand = brand;
}

public String getOrder_id() {
	return order_id;
}
public String getTitle() {
	return title;
}
public Double getProduct_price() {
	return product_price;
}

public Double getOrder_total_price() {
	return order_total_price;
}
public String getIntegration() {
	return integration;
}
public String getProd_code() {
	return prod_code;
}
public String getBar_code() {
	return bar_code;
}
public String getProduct_id() {
	return product_id;
}
public String getSpec() {
	return spec;
}
public void setId(int id) {
	this.id = id;
}
public void setOrder_id(String order_id) {
	this.order_id = order_id;
}
public void setTitle(String title) {
	this.title = title;
}
public void setProduct_price(Double product_price) {
	this.product_price = product_price;
}

public void setOrder_total_price(Double order_total_price) {
	this.order_total_price = order_total_price;
}
public void setIntegration(String integration) {
	this.integration = integration;
}
public void setProd_code(String prod_code) {
	this.prod_code = prod_code;
}
public void setBar_code(String bar_code) {
	this.bar_code = bar_code;
}
public void setProduct_id(String product_id) {
	this.product_id = product_id;
}
public void setSpec(String spec) {
	this.spec = spec;
}

public Double getOrder_num() {
	return order_num;
}

public void setOrder_num(Double order_num) {
	this.order_num = order_num;
}

}
