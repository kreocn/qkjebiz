/**
 * 
 */
package org.iweb.member.domain;

import java.util.Date;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-6 下午9:05:19
 */
public class MemberOrderGoods {
	private Integer uuid;// (int)
	private String order_id;// (varchar)
	private Integer goods_id;// (int)
	private Double per_price;// (decimal)单价
	private Integer order_num;// (int)订单数量
	private Double total_price;// (decimal)实际价格
	private Double storage_fees;// 保管费custody
	private Date storage_date;// 保管终止期限

	// 以下为非数据库字段
	private String order_user;
	private String goods_name;
	private Integer goods_type;
	private Integer goods_class;
	private String goods_type_name;
	private String goods_class_name;
	private String goods_unit;
	private String goods_spec_unit;
	private String goods_small_img;
	private Date add_time;
	private String member_id; // 所属会员
	private Integer order_status;// 订单状态

	private Double order_total_price;
	private Integer order_pay_status;

	// 统计型字段
	private Integer og_num; // 非数据库字段,记录订单下有多少种商品

	// 查询字段
	private Date s_add_time; // 起始时间
	private Date e_add_time; // 截至时间

	public Date getS_add_time() {
		return s_add_time;
	}

	public void setS_add_time(Date s_add_time) {
		this.s_add_time = s_add_time;
	}

	public Date getE_add_time() {
		return e_add_time;
	}

	public void setE_add_time(Date e_add_time) {
		this.e_add_time = e_add_time;
	}

	public Double getOrder_total_price() {
		return order_total_price;
	}

	public void setOrder_total_price(Double order_total_price) {
		this.order_total_price = order_total_price;
	}

	public Integer getOrder_pay_status() {
		return order_pay_status;
	}

	public void setOrder_pay_status(Integer order_pay_status) {
		this.order_pay_status = order_pay_status;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public String getGoods_small_img() {
		return goods_small_img;
	}

	public void setGoods_small_img(String goods_small_img) {
		this.goods_small_img = goods_small_img;
	}

	public String getGoods_spec_unit() {
		return goods_spec_unit;
	}

	public void setGoods_spec_unit(String goods_spec_unit) {
		this.goods_spec_unit = goods_spec_unit;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
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

	public Double getPer_price() {
		return per_price;
	}

	public void setPer_price(Double per_price) {
		this.per_price = per_price;
	}

	public Integer getOrder_num() {
		return order_num;
	}

	public void setOrder_num(Integer order_num) {
		this.order_num = order_num;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

	public Double getStorage_fees() {
		return storage_fees;
	}

	public void setStorage_fees(Double storage_fees) {
		this.storage_fees = storage_fees;
	}

	public Date getStorage_date() {
		return storage_date;
	}

	public void setStorage_date(Date storage_date) {
		this.storage_date = storage_date;
	}

	public String getOrder_user() {
		return order_user;
	}

	public void setOrder_user(String order_user) {
		this.order_user = order_user;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public Integer getGoods_type() {
		return goods_type;
	}

	public void setGoods_type(Integer goods_type) {
		this.goods_type = goods_type;
	}

	public Integer getGoods_class() {
		return goods_class;
	}

	public void setGoods_class(Integer goods_class) {
		this.goods_class = goods_class;
	}

	public String getGoods_type_name() {
		return goods_type_name;
	}

	public void setGoods_type_name(String goods_type_name) {
		this.goods_type_name = goods_type_name;
	}

	public String getGoods_class_name() {
		return goods_class_name;
	}

	public void setGoods_class_name(String goods_class_name) {
		this.goods_class_name = goods_class_name;
	}

	public String getGoods_unit() {
		return goods_unit;
	}

	public void setGoods_unit(String goods_unit) {
		this.goods_unit = goods_unit;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Integer getOrder_status() {
		return order_status;
	}

	public void setOrder_status(Integer order_status) {
		this.order_status = order_status;
	}

	public Integer getOg_num() {
		return og_num;
	}

	public void setOg_num(Integer og_num) {
		this.og_num = og_num;
	}
}
