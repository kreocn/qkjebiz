package com.qkj.manage.domain;

public class IntegralPay {
private Integer uuid;
private String member_id;
private String payContent;
private String payDetails;
private double integral;

public String getMember_id() {
	return member_id;
}
public void setMember_id(String member_id) {
	this.member_id = member_id;
}
public Integer getUuid() {
	return uuid;
}
public void setUuid(Integer uuid) {
	this.uuid = uuid;
}
public String getPayContent() {
	return payContent;
}
public void setPayContent(String payContent) {
	this.payContent = payContent;
}
public String getPayDetails() {
	return payDetails;
}
public void setPayDetails(String payDetails) {
	this.payDetails = payDetails;
}
public double getIntegral() {
	return integral;
}
public void setIntegral(double integral) {
	this.integral = integral;
}
}
