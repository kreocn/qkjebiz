package com.qkj.ware.domain;
import java.util.*;
public class AllotDetail {
private Integer uuid;//(int)
private String lading_id;//(varchar)
private Integer stock_id;//(int)
private Integer num;//(int)


// 以下为非数据库字段
private Integer goldId;
private String product_name;
private int case_spec;


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
public Integer getGoldId() {
	return goldId;
}
public void setGoldId(Integer goldId) {
	this.goldId = goldId;
}
public String getProduct_name() {
	return product_name;
}
public void setProduct_name(String product_name) {
	this.product_name = product_name;
}
public int getCase_spec() {
	return case_spec;
}
public void setCase_spec(int case_spec) {
	this.case_spec = case_spec;
}


}
