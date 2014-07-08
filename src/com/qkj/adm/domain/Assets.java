package com.qkj.adm.domain;
import java.util.*;
public class Assets {
private Integer uuid;//(int)
private String typea;//(varchar)资产种类
private String typeb;//(varchar)资产类别
private String typec;//(varchar)子类别
private String title;//(varchar)资产名称
private Integer num;//(int)数量
private Integer company;//(int)所属公司
private Date p_time;//(datetime)采购时间
private Integer p_scrap;//(int)报废时限(月)
private Double price_scope;//(decimal)价格范围
private Date add_time;//(datetime)添加时间
private String add_user;//(varchar)添加人
private Date lm_time;//(timestamp)修改时间
private String lm_user;//(varchar)修改人

public Integer getUuid(){
return uuid;
}public void setUuid(Integer uuid){
this.uuid=uuid;
}
public String getTypea(){
return typea;
}public void setTypea(String typea){
this.typea=typea;
}
public String getTypeb(){
return typeb;
}public void setTypeb(String typeb){
this.typeb=typeb;
}
public String getTypec(){
return typec;
}public void setTypec(String typec){
this.typec=typec;
}
public String getTitle(){
return title;
}public void setTitle(String title){
this.title=title;
}
public Integer getNum(){
return num;
}public void setNum(Integer num){
this.num=num;
}
public Integer getCompany(){
return company;
}public void setCompany(Integer company){
this.company=company;
}
public Date getP_time(){
return p_time;
}public void setP_time(Date p_time){
this.p_time=p_time;
}
public Integer getP_scrap(){
return p_scrap;
}public void setP_scrap(Integer p_scrap){
this.p_scrap=p_scrap;
}
public Double getPrice_scope(){
return price_scope;
}public void setPrice_scope(Double price_scope){
this.price_scope=price_scope;
}
public Date getAdd_time(){
return add_time;
}public void setAdd_time(Date add_time){
this.add_time=add_time;
}
public String getAdd_user(){
return add_user;
}public void setAdd_user(String add_user){
this.add_user=add_user;
}
public Date getLm_time(){
return lm_time;
}public void setLm_time(Date lm_time){
this.lm_time=lm_time;
}
public String getLm_user(){
return lm_user;
}public void setLm_user(String lm_user){
this.lm_user=lm_user;
}

}
