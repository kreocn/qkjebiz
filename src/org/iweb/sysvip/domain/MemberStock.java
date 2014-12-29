package org.iweb.sysvip.domain;
import java.util.*;
public class MemberStock {
private Integer uuid;//(int)
private String dealer;//(varchar)经销商帐号
private Integer product;//(int)商品编号
private Integer stock;//(int)库存数量（瓶）
private String check_date;//(varchar)核对日期
private String add_user;//(varchar)填加人
private Date add_time;//(datetime)填加时间
private String lm_user;//(varchar)修改人
private Date lm_time;//(datetime)修改时间


// 以下为非数据库字段

public Integer getUuid(){
return uuid;
}public void setUuid(Integer uuid){
this.uuid=uuid;
}
public String getDealer(){
return dealer;
}public void setDealer(String dealer){
this.dealer=dealer;
}
public Integer getProduct(){
return product;
}public void setProduct(Integer product){
this.product=product;
}
public Integer getStock(){
return stock;
}public void setStock(Integer stock){
this.stock=stock;
}
public String getCheck_date(){
return check_date;
}public void setCheck_date(String check_date){
this.check_date=check_date;
}
public String getAdd_user(){
return add_user;
}public void setAdd_user(String add_user){
this.add_user=add_user;
}
public Date getAdd_time(){
return add_time;
}public void setAdd_time(Date add_time){
this.add_time=add_time;
}
public String getLm_user(){
return lm_user;
}public void setLm_user(String lm_user){
this.lm_user=lm_user;
}
public Date getLm_time(){
return lm_time;
}public void setLm_time(Date lm_time){
this.lm_time=lm_time;
}

}
