package com.qkjsys.ebiz.domain;

import java.util.Date;

public class GoodsImg {
	private int uuid;// (int) 主键
	private int goods_id;// (int) 对应的商品ID
	private String title;// (varchar) 图片标题
	private String alt;// (varchar) 图片提示文本,一般等于title
	private String url;// (varchar) 0
	private int index_flag;// (int) 前台展示标志 0 不展示 1 展示 2主图
	private int state;// (int) 图片状态
	private String add_user;// (varchar) 0
	private Date add_time;// (datetime) 0

	public int getUuid() {
		return uuid;
	}

	public void setUuid(int uuid) {
		this.uuid = uuid;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAlt() {
		return alt;
	}

	public void setAlt(String alt) {
		this.alt = alt;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getIndex_flag() {
		return index_flag;
	}

	public void setIndex_flag(int index_flag) {
		this.index_flag = index_flag;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
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

}
