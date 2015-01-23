package com.qkj.manage.domain;

import java.util.Date;

public class Product {
	private Integer uuid;// (int)主键ID
	private String prod_code;// 产品统一编码
	private Integer brand;// (varchar)系列/类型/品牌
	private String title;// (varchar)品名
	private String spec;// (varchar)规格(500ml)
	private Integer case_spec;// (int)数量(件)
	private Double alcohol;// (decimal)酒精度
	private String flavor;// (varchar)香型
	private String raw_materials;// (varchar)原材料
	private Integer grade;// (int)档次 1低端 2中端 3中高端 4高端
	private Double market_price;// (decimal)市场价
	private Double group_price;// (decimal)团购价
	private Double dealer_price;// (decimal)经销商价格
	private Double group_rebates;// (int)团购返利点%
	private Double dealer_rebates;// (int)经销商返利点%
	private Double agree_price_1;// (decimal)协议价1
	private Double agree_price_2;// (decimal)协议价2
	private Double agree_price_3;// (decimal)协议价3
	private Integer status;// 是否启用
	private String lm_user;// (varchar)
	private Date lm_time;// (timestamp)

	private String brand_name;

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getProd_code() {
		return prod_code;
	}

	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getBrand() {
		return brand;
	}

	public void setBrand(Integer brand) {
		this.brand = brand;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public Integer getCase_spec() {
		return case_spec;
	}

	public void setCase_spec(Integer case_spec) {
		this.case_spec = case_spec;
	}

	public Double getAlcohol() {
		return alcohol;
	}

	public void setAlcohol(Double alcohol) {
		this.alcohol = alcohol;
	}

	public String getFlavor() {
		return flavor;
	}

	public void setFlavor(String flavor) {
		this.flavor = flavor;
	}

	public String getRaw_materials() {
		return raw_materials;
	}

	public void setRaw_materials(String raw_materials) {
		this.raw_materials = raw_materials;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public Double getMarket_price() {
		return market_price;
	}

	public void setMarket_price(Double market_price) {
		this.market_price = market_price;
	}

	public Double getGroup_price() {
		return group_price;
	}

	public void setGroup_price(Double group_price) {
		this.group_price = group_price;
	}

	public Double getDealer_price() {
		return dealer_price;
	}

	public void setDealer_price(Double dealer_price) {
		this.dealer_price = dealer_price;
	}

	public Double getGroup_rebates() {
		return group_rebates;
	}

	public void setGroup_rebates(Double group_rebates) {
		this.group_rebates = group_rebates;
	}

	public Double getDealer_rebates() {
		return dealer_rebates;
	}

	public void setDealer_rebates(Double dealer_rebates) {
		this.dealer_rebates = dealer_rebates;
	}

	public Double getAgree_price_1() {
		return agree_price_1;
	}

	public void setAgree_price_1(Double agree_price_1) {
		this.agree_price_1 = agree_price_1;
	}

	public Double getAgree_price_2() {
		return agree_price_2;
	}

	public void setAgree_price_2(Double agree_price_2) {
		this.agree_price_2 = agree_price_2;
	}

	public Double getAgree_price_3() {
		return agree_price_3;
	}

	public void setAgree_price_3(Double agree_price_3) {
		this.agree_price_3 = agree_price_3;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

}
