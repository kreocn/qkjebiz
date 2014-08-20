package com.qkj.ware.domain;
import java.util.*;
public class Allot {
private Integer uuid;//(int)
private String ordernum;//(varchar)单号
private Date date;//(date)日期
private Integer sourceid;//(int)调出仓库
private Integer goldid;//(int)调入仓库
private String note;//(varchar)其它说明
private String add_user;//(varchar)
private Date add_timer;//(datetime)
private String lm_user;//(varchar)
private Date lm_timer;//(datetime)
private Integer state;


// 以下为非数据库字段
private String add_user_name;
private String lm_user_name;
private String sourceName;
private String goldName;

public Integer getUuid(){
return uuid;
}public void setUuid(Integer uuid){
this.uuid=uuid;
}
public String getOrdernum(){
return ordernum;
}public void setOrdernum(String ordernum){
this.ordernum=ordernum;
}
public Date getDate(){
return date;
}public void setDate(Date date){
this.date=date;
}
public Integer getSourceid(){
return sourceid;
}public void setSourceid(Integer sourceid){
this.sourceid=sourceid;
}
public Integer getGoldid(){
return goldid;
}public void setGoldid(Integer goldid){
this.goldid=goldid;
}
public String getNote(){
return note;
}public void setNote(String note){
this.note=note;
}
public String getAdd_user(){
return add_user;
}public void setAdd_user(String add_user){
this.add_user=add_user;
}
public Date getAdd_timer(){
return add_timer;
}public void setAdd_timer(Date add_timer){
this.add_timer=add_timer;
}
public String getLm_user(){
return lm_user;
}public void setLm_user(String lm_user){
this.lm_user=lm_user;
}
public Date getLm_timer(){
return lm_timer;
}public void setLm_timer(Date lm_timer){
this.lm_timer=lm_timer;
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
public String getSourceName() {
	return sourceName;
}
public void setSourceName(String sourceName) {
	this.sourceName = sourceName;
}
public String getGoldName() {
	return goldName;
}
public void setGoldName(String goldName) {
	this.goldName = goldName;
}
public Integer getState() {
	return state;
}
public void setState(Integer state) {
	this.state = state;
}


}
