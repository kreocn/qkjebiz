package com.qkjsys.ebiz.domain;

import java.util.Date;

public class MemberCellar {
	private Integer uuid;// (int)主键ID
	private String member_id;// (varchar)客户ID
	private String order_id; // 订单ID
	private Integer order_goods_id;// (int)所属订单细项
	private Integer cellar_no;// (varchar)初始藏酒编号
	private Integer goods_id;// (int)商品ID
	private Integer ware_id;// (int)仓库ID
	private Double num;// (decimal)初始库存
	private Double stock;// (decimal)剩余库存
	private Double frozen;// (decimal)冻结库存
	private String cellar_position;// (varchar)藏酒位置号
	private String camera;// (varchar)实时摄像头链接
	private Date storage_date;// 服务截至日期(保管时间)
	private Integer status;// 状态 0 正常 1废弃
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (timestamp)最后修改时间

	// 以下为非数据库字段
	private String goods_name;
	private Integer order_num;// (int)订单数量
	private String goods_unit;
	private String goods_spec;
	private String goods_spec_unit;
	private String goods_cellar_prefix; // 产品默认前缀
	private String ware_name;
	private String user_id;
	private String small_img; // 产品小图
	private String big_img; // 产品大图

	// 查询字段
	// yes no
	private String fullflag;
	private String memflag;

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getFullflag() {
		return fullflag;
	}

	public void setFullflag(String fullflag) {
		this.fullflag = fullflag;
	}

	public String getMemflag() {
		return memflag;
	}

	public void setMemflag(String memflag) {
		this.memflag = memflag;
	}

	public String getSmall_img() {
		return small_img;
	}

	public void setSmall_img(String small_img) {
		this.small_img = small_img;
	}

	public String getBig_img() {
		return big_img;
	}

	public void setBig_img(String big_img) {
		this.big_img = big_img;
	}

	public Date getStorage_date() {
		return storage_date;
	}

	public void setStorage_date(Date storage_date) {
		this.storage_date = storage_date;
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

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public Integer getOrder_num() {
		return order_num;
	}

	public void setOrder_num(Integer order_num) {
		this.order_num = order_num;
	}

	public String getGoods_unit() {
		return goods_unit;
	}

	public void setGoods_unit(String goods_unit) {
		this.goods_unit = goods_unit;
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

	public String getGoods_cellar_prefix() {
		return goods_cellar_prefix;
	}

	public void setGoods_cellar_prefix(String goods_cellar_prefix) {
		this.goods_cellar_prefix = goods_cellar_prefix;
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

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
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

	public Double getFrozen() {
		return frozen;
	}

	public void setFrozen(Double frozen) {
		this.frozen = frozen;
	}

	public String getCellar_position() {
		return cellar_position;
	}

	public void setCellar_position(String cellar_position) {
		this.cellar_position = cellar_position;
	}

	public String getCamera() {
		return camera;
	}

	public void setCamera(String camera) {
		this.camera = camera;
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

}
