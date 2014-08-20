package com.qkj.manage.domain;

import java.util.Date;

public class Travel {
	private Integer uuid;// (int)主键自增
	private String apply_dept;// (varchar)申请部门
	private String apply_user;// (varchar)申请人
	private String apply_item;// (varchar)申请项目
	private Integer travel_num;// (int)客户人数
	private Integer accompany_num;// (int)陪同人数
	private Date travel_date;// (date)执行日期
	private Date travel_date_end;// (date)执行日期截至
	private String members_names;// (int)客户家数
	private Double lunch_price;// (decimal)午餐标准/桌
	private Integer lunch_num;// (int)午餐次数
	private Integer lunch_desk;// (int)午餐桌数
	private Double dinner_price;// (decimal)晚餐标准/桌
	private Integer dinner_num;// (int)晚餐次数
	private Integer dinner_desk;// (int)晚餐桌数
	private Integer cigarette;// (int)是否使用香烟0否 1是
	private Integer cigarette_num;// (int)准备香烟包数
	private Integer fruit;// (int)是否准备水果0否 1是
	private Integer hotel;// (int)是否安排住宿0否 1是
	private Date hotel_start;// (date)开始住宿时间
	private Date hotel_end;// (date)结束住宿时间
	private Integer hotel_total;// (int)总共住宿天数
	private Integer hotel_twinroom;// (int)标间间数
	private Integer hotel_house;// (int)别墅规格(几人一套)
	private Integer hotel_house_num;// (int)别墅套数
	private String car;// (varchar)车辆标准
	private Integer travel_agency;// (int)是否联系旅行社0否 1是
	private String trip;// (text)具体行程安排
	private String gift;// (varchar)礼品品相
	private Integer gift_num;// (int)礼品份数
	private String note;// (text)其他情况说明
	private Integer check_status;// (int)业务审核状态
	private String check_user;// (varchar)业务审核人
	private Date check_time;// (datetime)业务审核时间
	private String check_note;// (varchar)业务审核意见
	private Integer acheck_status;// (int)行政审核状态
	private String acheck_user;// (varchar)行政审核人
	private Date acheck_time;// (datetime)行政审核时间
	private String acheck_note;// (varchar)行政审核意见
	private String add_user;// (varchar)添加人
	private Date add_time;// (datetime)添加时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (datetime)最后修改时间

	// 以下为非数据库字段
	private String apply_dept_name;
	private String apply_user_name;
	private String check_user_name;
	private String check_user_sign;
	private String acheck_user_name;
	private String acheck_user_sign;
	private String add_user_name;

	// checkbox专用转换字段
	private String[] apply_items;
	private String[] cars;

	// 查询专用字段
	private Date travel_date_search;

	public String getCheck_user_sign() {
		return check_user_sign;
	}

	public void setCheck_user_sign(String check_user_sign) {
		this.check_user_sign = check_user_sign;
	}

	public String getAcheck_user_sign() {
		return acheck_user_sign;
	}

	public void setAcheck_user_sign(String acheck_user_sign) {
		this.acheck_user_sign = acheck_user_sign;
	}

	public Date getTravel_date_search() {
		return travel_date_search;
	}

	public void setTravel_date_search(Date travel_date_search) {
		this.travel_date_search = travel_date_search;
	}

	public String[] getApply_items() {
		return apply_items;
	}

	public void setApply_items(String[] apply_items) {
		this.apply_items = apply_items;
	}

	public String[] getCars() {
		return cars;
	}

	public void setCars(String[] cars) {
		this.cars = cars;
	}

	public Date getTravel_date_end() {
		return travel_date_end;
	}

	public void setTravel_date_end(Date travel_date_end) {
		this.travel_date_end = travel_date_end;
	}

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

	public String getApply_user_name() {
		return apply_user_name;
	}

	public void setApply_user_name(String apply_user_name) {
		this.apply_user_name = apply_user_name;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public String getAcheck_user_name() {
		return acheck_user_name;
	}

	public void setAcheck_user_name(String acheck_user_name) {
		this.acheck_user_name = acheck_user_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}

	public String getApply_user() {
		return apply_user;
	}

	public void setApply_user(String apply_user) {
		this.apply_user = apply_user;
	}

	public String getApply_item() {
		return apply_item;
	}

	public void setApply_item(String apply_item) {
		this.apply_item = apply_item;
	}

	public Integer getTravel_num() {
		return travel_num;
	}

	public void setTravel_num(Integer travel_num) {
		this.travel_num = travel_num;
	}

	public Integer getAccompany_num() {
		return accompany_num;
	}

	public void setAccompany_num(Integer accompany_num) {
		this.accompany_num = accompany_num;
	}

	public Date getTravel_date() {
		return travel_date;
	}

	public void setTravel_date(Date travel_date) {
		this.travel_date = travel_date;
	}

	public String getMembers_names() {
		return members_names;
	}

	public void setMembers_names(String members_names) {
		this.members_names = members_names;
	}

	public Double getLunch_price() {
		return lunch_price;
	}

	public void setLunch_price(Double lunch_price) {
		this.lunch_price = lunch_price;
	}

	public Integer getLunch_num() {
		return lunch_num;
	}

	public void setLunch_num(Integer lunch_num) {
		this.lunch_num = lunch_num;
	}

	public Integer getLunch_desk() {
		return lunch_desk;
	}

	public void setLunch_desk(Integer lunch_desk) {
		this.lunch_desk = lunch_desk;
	}

	public Double getDinner_price() {
		return dinner_price;
	}

	public void setDinner_price(Double dinner_price) {
		this.dinner_price = dinner_price;
	}

	public Integer getDinner_num() {
		return dinner_num;
	}

	public void setDinner_num(Integer dinner_num) {
		this.dinner_num = dinner_num;
	}

	public Integer getDinner_desk() {
		return dinner_desk;
	}

	public void setDinner_desk(Integer dinner_desk) {
		this.dinner_desk = dinner_desk;
	}

	public Integer getCigarette() {
		return cigarette;
	}

	public void setCigarette(Integer cigarette) {
		this.cigarette = cigarette;
	}

	public Integer getCigarette_num() {
		return cigarette_num;
	}

	public void setCigarette_num(Integer cigarette_num) {
		this.cigarette_num = cigarette_num;
	}

	public Integer getFruit() {
		return fruit;
	}

	public void setFruit(Integer fruit) {
		this.fruit = fruit;
	}

	public Integer getHotel() {
		return hotel;
	}

	public void setHotel(Integer hotel) {
		this.hotel = hotel;
	}

	public Date getHotel_start() {
		return hotel_start;
	}

	public void setHotel_start(Date hotel_start) {
		this.hotel_start = hotel_start;
	}

	public Date getHotel_end() {
		return hotel_end;
	}

	public void setHotel_end(Date hotel_end) {
		this.hotel_end = hotel_end;
	}

	public Integer getHotel_total() {
		return hotel_total;
	}

	public void setHotel_total(Integer hotel_total) {
		this.hotel_total = hotel_total;
	}

	public Integer getHotel_twinroom() {
		return hotel_twinroom;
	}

	public void setHotel_twinroom(Integer hotel_twinroom) {
		this.hotel_twinroom = hotel_twinroom;
	}

	public Integer getHotel_house() {
		return hotel_house;
	}

	public void setHotel_house(Integer hotel_house) {
		this.hotel_house = hotel_house;
	}

	public Integer getHotel_house_num() {
		return hotel_house_num;
	}

	public void setHotel_house_num(Integer hotel_house_num) {
		this.hotel_house_num = hotel_house_num;
	}

	public String getCar() {
		return car;
	}

	public void setCar(String car) {
		this.car = car;
	}

	public Integer getTravel_agency() {
		return travel_agency;
	}

	public void setTravel_agency(Integer travel_agency) {
		this.travel_agency = travel_agency;
	}

	public String getTrip() {
		return trip;
	}

	public void setTrip(String trip) {
		this.trip = trip;
	}

	public String getGift() {
		return gift;
	}

	public void setGift(String gift) {
		this.gift = gift;
	}

	public Integer getGift_num() {
		return gift_num;
	}

	public void setGift_num(Integer gift_num) {
		this.gift_num = gift_num;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getCheck_status() {
		return check_status;
	}

	public void setCheck_status(Integer check_status) {
		this.check_status = check_status;
	}

	public String getCheck_user() {
		return check_user;
	}

	public void setCheck_user(String check_user) {
		this.check_user = check_user;
	}

	public Date getCheck_time() {
		return check_time;
	}

	public void setCheck_time(Date check_time) {
		this.check_time = check_time;
	}

	public String getCheck_note() {
		return check_note;
	}

	public void setCheck_note(String check_note) {
		this.check_note = check_note;
	}

	public Integer getAcheck_status() {
		return acheck_status;
	}

	public void setAcheck_status(Integer acheck_status) {
		this.acheck_status = acheck_status;
	}

	public String getAcheck_user() {
		return acheck_user;
	}

	public void setAcheck_user(String acheck_user) {
		this.acheck_user = acheck_user;
	}

	public Date getAcheck_time() {
		return acheck_time;
	}

	public void setAcheck_time(Date acheck_time) {
		this.acheck_time = acheck_time;
	}

	public String getAcheck_note() {
		return acheck_note;
	}

	public void setAcheck_note(String acheck_note) {
		this.acheck_note = acheck_note;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
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
