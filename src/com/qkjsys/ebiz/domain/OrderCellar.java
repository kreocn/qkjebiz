package com.qkjsys.ebiz.domain;

public class OrderCellar {
	private Integer uuid;// (int)
	private Integer order_goods_id;// (int)qkj_r_order_goods.uuid
	private Integer cellar_no;// (varchar)藏酒位置号
	private Double num;// (decimal)初始库存
	private Double stock;// (decimal)剩余库存
	private String camera;// (varchar)实时摄像头链接

	// 以下为非数据库字段
	private String order_id;// (varchar)
	private Integer goods_id;// (int)
	private String goods_name;
	private Integer order_num;// (int)订单数量
	private String goods_unit;
	private String goods_spec;
	private String goods_spec_unit;
	private Integer ware_id;
	private String ware_name;
	private String user_id;
	private Integer order_status;

	/**
	 * status 查找的方式
	 * 
	 * @see org.iweb.sys.Parameters
	 */
	private Integer status_search_type;

	public Integer getOrder_status() {
		return order_status;
	}

	public String getGoods_spec() {
		return goods_spec;
	}

	public void setGoods_spec(String goods_spec) {
		this.goods_spec = goods_spec;
	}

	public String getGoods_spec_unit() {
		return goods_spec_unit;
	}

	public void setGoods_spec_unit(String goods_spec_unit) {
		this.goods_spec_unit = goods_spec_unit;
	}

	public void setOrder_status(Integer order_status) {
		this.order_status = order_status;
	}

	public String getGoods_unit() {
		return goods_unit;
	}

	public void setGoods_unit(String goods_unit) {
		this.goods_unit = goods_unit;
	}

	public Integer getStatus_search_type() {
		return status_search_type;
	}

	public void setStatus_search_type(Integer status_search_type) {
		this.status_search_type = status_search_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public Integer getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(Integer goods_id) {
		this.goods_id = goods_id;
	}

	public Integer getOrder_num() {
		return order_num;
	}

	public void setOrder_num(Integer order_num) {
		this.order_num = order_num;
	}

	public Integer getWare_id() {
		return ware_id;
	}

	public void setWare_id(Integer ware_id) {
		this.ware_id = ware_id;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getOrder_goods_id() {
		return order_goods_id;
	}

	public void setOrder_goods_id(Integer order_goods_id) {
		this.order_goods_id = order_goods_id;
	}

	public Integer getCellar_no() {
		return cellar_no;
	}

	public void setCellar_no(Integer cellar_no) {
		this.cellar_no = cellar_no;
	}

	public Double getNum() {
		return num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public Double getStock() {
		return stock;
	}

	public void setStock(Double stock) {
		this.stock = stock;
	}

	public String getCamera() {
		return camera;
	}

	public void setCamera(String camera) {
		this.camera = camera;
	}

}
