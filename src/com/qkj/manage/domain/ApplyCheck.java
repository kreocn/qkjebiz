package com.qkj.manage.domain;
import java.util.*;
public class ApplyCheck {
private Integer uuid;//(int)系统编号
private Integer apply_id;//(int)至事由编号
private Integer flag;//(int)审核标记
private String check_user;//(varchar)审核人
private String check_title;//(varchar)审核人称谓
private String advice;//(varchar)审核意见
private Date ad_time;//(datetime)审核时间

public Integer getUuid(){
return uuid;
}public void setUuid(Integer uuid){
this.uuid=uuid;
}
public Integer getApply_id(){
return apply_id;
}public void setApply_id(Integer apply_id){
this.apply_id=apply_id;
}
public Integer getFlag(){
return flag;
}public void setFlag(Integer flag){
this.flag=flag;
}
public String getCheck_user(){
return check_user;
}public void setCheck_user(String check_user){
this.check_user=check_user;
}
public String getCheck_title(){
return check_title;
}public void setCheck_title(String check_title){
this.check_title=check_title;
}
public String getAdvice(){
return advice;
}public void setAdvice(String advice){
this.advice=advice;
}
public Date getAd_time(){
return ad_time;
}public void setAd_time(Date ad_time){
this.ad_time=ad_time;
}

}
