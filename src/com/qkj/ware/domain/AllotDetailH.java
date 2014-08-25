package com.qkj.ware.domain;
import java.util.*;
public class AllotDetailH {
private Integer uuid;//(int)
private String lading_id;//(varchar)
private Integer stock_id;//(int)
private Integer num;//(int)


// 以下为非数据库字段

public Integer getUuid(){
return uuid;
}public void setUuid(Integer uuid){
this.uuid=uuid;
}
public String getLading_id(){
return lading_id;
}public void setLading_id(String lading_id){
this.lading_id=lading_id;
}
public Integer getStock_id(){
return stock_id;
}public void setStock_id(Integer stock_id){
this.stock_id=stock_id;
}
public Integer getNum(){
return num;
}public void setNum(Integer num){
this.num=num;
}

}
