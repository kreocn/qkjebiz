package com.qkj.stock.domain;

import java.math.BigDecimal;

public class Stock {
	private Integer uuid;// (int)
	private Integer product_id;// (int)
	private Integer store_id;// (int)
	private Integer quantity;// (int)

	// 以下为非数据库字段
	private String product_name;
	private String store_name;
	private double market_price;
	private BigDecimal agree_price_1;
	private BigDecimal agree_price_2;
	private BigDecimal agree_price_3;
	private double dealer_price;
	private double group_price;
	private int case_spec;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getStore_id() {
		return store_id;
	}

	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public double getMarket_price() {
		return market_price;
	}

	public void setMarket_price(double market_price) {
		this.market_price = market_price;
	}

	

	public BigDecimal getAgree_price_1() {
		return agree_price_1;
	}

	public void setAgree_price_1(BigDecimal agree_price_1) {
		this.agree_price_1 = agree_price_1;
	}

	public double getDealer_price() {
		return dealer_price;
	}

	public void setDealer_price(double dealer_price) {
		this.dealer_price = dealer_price;
	}

	public double getGroup_price() {
		return group_price;
	}

	public void setGroup_price(double group_price) {
		this.group_price = group_price;
	}

	public int getCase_spec() {
		return case_spec;
	}

	public void setCase_spec(int case_spec) {
		this.case_spec = case_spec;
	}

	public BigDecimal getAgree_price_2() {
		return agree_price_2;
	}

	public void setAgree_price_2(BigDecimal agree_price_2) {
		this.agree_price_2 = agree_price_2;
	}

	public BigDecimal getAgree_price_3() {
		return agree_price_3;
	}

	public void setAgree_price_3(BigDecimal agree_price_3) {
		this.agree_price_3 = agree_price_3;
	}
	
	
	
	

}
