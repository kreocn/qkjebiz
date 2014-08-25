package com.qkj.ware.domain;
import java.util.*;
public class InDetailH {
private Integer uuid;//(int)
private String lading_id;//(varchar)入库单号
private Integer product_id;//(int)商品id
private Integer num;//(int)入库数量
private Double price;//(decimal)单价
private Double total;//(decimal)总计


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
public Integer getProduct_id(){
return product_id;
}public void setProduct_id(Integer product_id){
this.product_id=product_id;
}
public Integer getNum(){
return num;
}public void setNum(Integer num){
this.num=num;
}
public Double getPrice(){
return price;
}public void setPrice(Double price){
this.price=price;
}
public Double getTotal(){
return total;
}public void setTotal(Double total){
this.total=total;
}

}
