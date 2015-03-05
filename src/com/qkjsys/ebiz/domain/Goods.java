package com.qkjsys.ebiz.domain;

import java.util.Date;

/**
 * 
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-21 下午3:57:52
 */
public class Goods {
	private Integer uuid;// (int) 0
	private String goods_name;// (varchar) 商品名称
	private Integer goods_class;// (int) 商品分类
	private Integer goods_brand;// (int) 商品品牌
	private String goods_code;// (varchar) 商品货号
	private Integer goods_type;// (int) 商品类型
	private Double goods_price;// (decimal) 本店售价
	private Double goods_price_original;// (decimal) 市场价
	private Double goods_price_promotion;// (decimal) 促销价
	private Integer goods_promotion;// (int) 促销方式(是否促销)
	private Date goods_promotion_start;// (datetime) 促销开始时间
	private Date goods_promotion_end;// (datetime) 促销开始时间
	private Integer goods_points;// (int) 此商品赠送积分 -1代表按价格赠送 >0代表实际可得
	private Integer goods_points_sales;// (int) 此商品是否可积分购买 0 不可以 1 可以 2 只能用积分购买
	private Integer goods_points_price;// (int) 商品价值积分(最高可用多少积分)
	private String goods_description;// (text) 商品详细描述
	private Integer goods_num;// (int) 商品库存
	private String goods_unit;
	private Double goods_spec;// (decimal) 单位商品 规格/重量/体积
	private String goods_spec_unit;// (int) spec的单位
	private Integer goods_num_warning;// (int) 库存警告数量
	private Integer goods_sales;// (int) 上架标志 0 上架 1 下架 2 回收状态
	private Integer goods_parts;// (int) 配件标志,表示只能算配件或者可以当作成品销售
	private Integer goods_freight;// (int) 运费 -1代表沿用配置 0代表免运费 >0代表运费金额
	private String goods_keywords;// (varchar) 商品关键词
	private String goods_short_text;// (varchar) 简短描述
	private String goods_sec_remark;// (text) 内部备注(只有商家才能看到)
	private String small_img;// 商品小图(100x100)
	private String big_img;// 商品大图
	private Date add_time;// (datetime) 0
	private String add_user;// (varchar) 0
	private String add_ip;// (varchar) 0
	private Date lm_time;// (datetime) 0
	private String lm_user;// (varchar) 0
	private String lm_ip;// (varchar) 0

	// 以下为联合表字段
	private Integer stock_num;
	private Integer froze_num;
	private Integer break_num;

	// 以下为非数据库字段
	private Integer available_num; // 可用库存
	private String ware_name;
	private String add_user_name;
	private String lm_user_name;

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
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

	public Integer getStock_num() {
		return stock_num;
	}

	public void setStock_num(Integer stock_num) {
		this.stock_num = stock_num;
	}

	public Integer getFroze_num() {
		return froze_num;
	}

	public void setFroze_num(Integer froze_num) {
		this.froze_num = froze_num;
	}

	public Integer getBreak_num() {
		return break_num;
	}

	public void setBreak_num(Integer break_num) {
		this.break_num = break_num;
	}

	public Integer getAvailable_num() {
		return available_num;
	}

	public void setAvailable_num(Integer available_num) {
		this.available_num = available_num;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public Integer getGoods_class() {
		return goods_class;
	}

	public void setGoods_class(Integer goods_class) {
		this.goods_class = goods_class;
	}

	public Integer getGoods_brand() {
		return goods_brand;
	}

	public void setGoods_brand(Integer goods_brand) {
		this.goods_brand = goods_brand;
	}

	public String getGoods_code() {
		return goods_code;
	}

	public void setGoods_code(String goods_code) {
		this.goods_code = goods_code;
	}

	public Integer getGoods_type() {
		return goods_type;
	}

	public void setGoods_type(Integer goods_type) {
		this.goods_type = goods_type;
	}

	public Double getGoods_price() {
		return goods_price;
	}

	public void setGoods_price(Double goods_price) {
		this.goods_price = goods_price;
	}

	public Double getGoods_price_original() {
		return goods_price_original;
	}

	public void setGoods_price_original(Double goods_price_original) {
		this.goods_price_original = goods_price_original;
	}

	public Double getGoods_price_promotion() {
		return goods_price_promotion;
	}

	public void setGoods_price_promotion(Double goods_price_promotion) {
		this.goods_price_promotion = goods_price_promotion;
	}

	public Integer getGoods_promotion() {
		return goods_promotion;
	}

	public void setGoods_promotion(Integer goods_promotion) {
		this.goods_promotion = goods_promotion;
	}

	public Date getGoods_promotion_start() {
		return goods_promotion_start;
	}

	public void setGoods_promotion_start(Date goods_promotion_start) {
		this.goods_promotion_start = goods_promotion_start;
	}

	public Date getGoods_promotion_end() {
		return goods_promotion_end;
	}

	public void setGoods_promotion_end(Date goods_promotion_end) {
		this.goods_promotion_end = goods_promotion_end;
	}

	public Integer getGoods_points() {
		return goods_points;
	}

	public void setGoods_points(Integer goods_points) {
		this.goods_points = goods_points;
	}

	public Integer getGoods_points_sales() {
		return goods_points_sales;
	}

	public void setGoods_points_sales(Integer goods_points_sales) {
		this.goods_points_sales = goods_points_sales;
	}

	public Integer getGoods_points_price() {
		return goods_points_price;
	}

	public void setGoods_points_price(Integer goods_points_price) {
		this.goods_points_price = goods_points_price;
	}

	public String getGoods_description() {
		return goods_description;
	}

	public void setGoods_description(String goods_description) {
		this.goods_description = goods_description;
	}

	public Double getGoods_spec() {
		return goods_spec;
	}

	public void setGoods_spec(Double goods_spec) {
		this.goods_spec = goods_spec;
	}

	public String getGoods_unit() {
		return goods_unit;
	}

	public void setGoods_unit(String goods_unit) {
		this.goods_unit = goods_unit;
	}

	public String getGoods_spec_unit() {
		return goods_spec_unit;
	}

	public void setGoods_spec_unit(String goods_spec_unit) {
		this.goods_spec_unit = goods_spec_unit;
	}

	public Integer getGoods_num() {
		return goods_num;
	}

	public void setGoods_num(Integer goods_num) {
		this.goods_num = goods_num;
	}

	public Integer getGoods_num_warning() {
		return goods_num_warning;
	}

	public void setGoods_num_warning(Integer goods_num_warning) {
		this.goods_num_warning = goods_num_warning;
	}

	public Integer getGoods_sales() {
		return goods_sales;
	}

	public void setGoods_sales(Integer goods_sales) {
		this.goods_sales = goods_sales;
	}

	public Integer getGoods_parts() {
		return goods_parts;
	}

	public void setGoods_parts(Integer goods_parts) {
		this.goods_parts = goods_parts;
	}

	public Integer getGoods_freight() {
		return goods_freight;
	}

	public void setGoods_freight(Integer goods_freight) {
		this.goods_freight = goods_freight;
	}

	public String getGoods_keywords() {
		return goods_keywords;
	}

	public void setGoods_keywords(String goods_keywords) {
		this.goods_keywords = goods_keywords;
	}

	public String getGoods_short_text() {
		return goods_short_text;
	}

	public void setGoods_short_text(String goods_short_text) {
		this.goods_short_text = goods_short_text;
	}

	public String getGoods_sec_remark() {
		return goods_sec_remark;
	}

	public void setGoods_sec_remark(String goods_sec_remark) {
		this.goods_sec_remark = goods_sec_remark;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public String getAdd_ip() {
		return add_ip;
	}

	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

	public String getLm_ip() {
		return lm_ip;
	}

	public void setLm_ip(String lm_ip) {
		this.lm_ip = lm_ip;
	}

}
