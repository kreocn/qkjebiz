package com.qkj.ware.domain;
import java.util.*;
public class OutStockH {
private Integer uuid;//(int)
private String ordernum;//(varchar)
private Date date;//(date)
private Integer store_id;//(int)
private String operator_id;//(varchar)
private String take_id;//(varchar)
private String note;//(varchar)
private Double total_price;//(decimal)
private String add_user;//(varchar)
private Date add_timer;//(datetime)
private String lm_user;//(varchar)
private Date lm_timer;//(datetime)
private Integer reason;//(int)0销售用酒，1董事会用酒 ，借酒
private Integer send;//(int)0未还1已还2新单3待审核4结案5未出货6未返利
private Integer manager_check;//(int)渠道/运营经理确认
private String manager_check_user;//(varchar)
private Date manager_check_time;//(datetime)确认时间
private Integer coo_check;//(int)运营总监确认
private String coo_check_user;//(varchar)
private Date coo_check_time;//(datetime)确认时间
private String member_id;//(varchar)会员号,收货人
private String member_mebile;//(varchar)手机号
private String member_name;//(varchar)姓名
private String member_adress;//(varchar)地址
private Double member_price;//(decimal)基本费用
private String bsreason;//(varchar)报损原因


// 以下为非数据库字段

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
public Integer getStore_id(){
return store_id;
}public void setStore_id(Integer store_id){
this.store_id=store_id;
}
public String getOperator_id(){
return operator_id;
}public void setOperator_id(String operator_id){
this.operator_id=operator_id;
}
public String getTake_id(){
return take_id;
}public void setTake_id(String take_id){
this.take_id=take_id;
}
public String getNote(){
return note;
}public void setNote(String note){
this.note=note;
}
public Double getTotal_price(){
return total_price;
}public void setTotal_price(Double total_price){
this.total_price=total_price;
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
public Integer getReason(){
return reason;
}public void setReason(Integer reason){
this.reason=reason;
}
public Integer getSend(){
return send;
}public void setSend(Integer send){
this.send=send;
}
public Integer getManager_check(){
return manager_check;
}public void setManager_check(Integer manager_check){
this.manager_check=manager_check;
}
public String getManager_check_user(){
return manager_check_user;
}public void setManager_check_user(String manager_check_user){
this.manager_check_user=manager_check_user;
}
public Date getManager_check_time(){
return manager_check_time;
}public void setManager_check_time(Date manager_check_time){
this.manager_check_time=manager_check_time;
}
public Integer getCoo_check(){
return coo_check;
}public void setCoo_check(Integer coo_check){
this.coo_check=coo_check;
}
public String getCoo_check_user(){
return coo_check_user;
}public void setCoo_check_user(String coo_check_user){
this.coo_check_user=coo_check_user;
}
public Date getCoo_check_time(){
return coo_check_time;
}public void setCoo_check_time(Date coo_check_time){
this.coo_check_time=coo_check_time;
}
public String getMember_id(){
return member_id;
}public void setMember_id(String member_id){
this.member_id=member_id;
}
public String getMember_mebile(){
return member_mebile;
}public void setMember_mebile(String member_mebile){
this.member_mebile=member_mebile;
}
public String getMember_name(){
return member_name;
}public void setMember_name(String member_name){
this.member_name=member_name;
}
public String getMember_adress(){
return member_adress;
}public void setMember_adress(String member_adress){
this.member_adress=member_adress;
}
public Double getMember_price(){
return member_price;
}public void setMember_price(Double member_price){
this.member_price=member_price;
}
public String getBsreason(){
return bsreason;
}public void setBsreason(String bsreason){
this.bsreason=bsreason;
}

}
