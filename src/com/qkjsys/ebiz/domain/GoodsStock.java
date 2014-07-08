package com.qkjsys.ebiz.domain;

import java.util.Date;

public class GoodsStock {
	private Integer uuid;// (int)就是qkj_t_goods.uuid 1:1对应
	private Integer stock_num;// (int)现有库存(算冻结,不算损坏)
	private Integer froze_num;// (int)冻结库存
	private Integer break_num;// (int)损坏数量
	private Date lm_time;// (timestamp)改动时间

	public GoodsStock() {
	}

	public GoodsStock(Integer uuid, Integer stock_num) {
		this.uuid = uuid;
		this.stock_num = stock_num;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
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

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

}
